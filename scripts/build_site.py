#!/usr/bin/env python3
"""Build the static course index website into an output directory."""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
from pathlib import Path

from generate_catalog import COURSE_ROOT, MATERIAL_CATEGORIES, ROOT, course_identity, load_json


SITE_SOURCE = ROOT / "site"
MAJOR_LABELS = {"DMT": "数字媒体技术", "AMS": "应用统计学"}
IGNORED_NAMES = {"README.md", ".gitkeep"}


def git(*args: str) -> str:
    result = subprocess.run(
        ["git", *args], cwd=ROOT, check=True, capture_output=True, text=True, encoding="utf-8"
    )
    return result.stdout


def repository() -> str:
    if os.environ.get("GITHUB_REPOSITORY"):
        return os.environ["GITHUB_REPOSITORY"]
    match = re.search(r"github\.com[:/](.+?)(?:\.git)?$", git("remote", "get-url", "origin").strip())
    return match.group(1) if match else "UponNoise/AHU_SBI"


def course_files() -> dict[str, list[str]]:
    """Map each course folder to its material files, read from the committed git tree.

    Reading the tree instead of the working copy lets CI build from a sparse,
    blob-less checkout without downloading the course files themselves.
    """
    prefix = COURSE_ROOT.name + "/"
    courses: dict[str, list[str]] = {}
    for path in git("ls-tree", "-r", "-z", "--name-only", "HEAD").split("\0"):
        if not path.startswith(prefix):
            continue
        slug, _, relative = path[len(prefix):].partition("/")
        if not relative:
            continue
        files = courses.setdefault(slug, [])
        if relative.rsplit("/", 1)[-1] not in IGNORED_NAMES:
            files.append(relative)
    return courses


def build_index() -> dict:
    files = course_files()
    curricula = load_json(ROOT / "data" / "curricula.json")
    hidden = set(curricula.get("hidden_navigation_groups", []))

    majors = []
    for major, groups in curricula["majors"].items():
        visible = [
            {"name": name, "courses": slugs} for name, slugs in groups.items() if name not in hidden
        ]
        majors.append({"id": major, "name": MAJOR_LABELS.get(major, major), "groups": visible})
        for group in visible:
            for slug in group["courses"]:
                files.setdefault(slug, [])

    courses = {}
    for slug in sorted(files):
        code, name = course_identity(slug)
        courses[slug] = {"code": code, "name": name, "files": sorted(files[slug])}

    return {
        "repo": repository(),
        "branch": os.environ.get("GITHUB_REF_NAME", "main"),
        "root": COURSE_ROOT.name,
        "updated": git("log", "-1", "--format=%cs", "HEAD").strip(),
        "types": MATERIAL_CATEGORIES,
        "majors": majors,
        "courses": courses,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=ROOT / "_site", help="output directory")
    args = parser.parse_args()

    index = build_index()
    shutil.rmtree(args.out, ignore_errors=True)
    shutil.copytree(SITE_SOURCE, args.out)
    payload = json.dumps(index, ensure_ascii=False, separators=(",", ":"))
    (args.out / "data.js").write_text(f"window.SITE={payload};\n", encoding="utf-8")

    total = sum(len(course["files"]) for course in index["courses"].values())
    print(f"Built {args.out} with {len(index['courses'])} courses and {total} files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
