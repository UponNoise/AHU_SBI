import { slug as slugifySegment } from 'github-slugger';
import rawSiteData from '../data/site-index.json';

export type Placement = {
  major: string;
  group: string;
  hidden: boolean;
};

export type ResourceCategory = {
  name: string;
  count: number;
  githubUrl: string;
};

export type Course = {
  slug: string;
  name: string;
  code: string;
  codes: string[];
  displayCode: string;
  credits: string | number | null;
  certification: string | null;
  prerequisite: string | null;
  officialPrograms: Record<string, string>;
  note: string | null;
  transferRequirements: Record<string, string>;
  placements: Placement[];
  totalFiles: number;
  categories: ResourceCategory[];
  hasResources: boolean;
  githubUrl: string;
  searchText: string;
};

export type CurriculumGroup = {
  name: string;
  hidden: boolean;
  courses: string[];
  availableCourses: number;
};

export type SiteIndex = {
  schemaVersion: number;
  repositoryUrl: string;
  officialSource: {
    title: string;
    version: string;
    url: string;
  };
  stats: {
    courses: number;
    coursesWithResources: number;
    files: number;
    majors: number;
  };
  materialCategories: string[];
  majors: Record<string, { name: string; groups: CurriculumGroup[] }>;
  courses: Course[];
};

export const siteData = rawSiteData as SiteIndex;

export const basePath = import.meta.env.BASE_URL.endsWith('/')
  ? import.meta.env.BASE_URL
  : `${import.meta.env.BASE_URL}/`;

export function sitePath(path = ''): string {
  return `${basePath}${path.replace(/^\//, '')}`;
}

export function coursePath(slug: string): string {
  return sitePath(`course/${courseRouteSegment(slug)}/`);
}

export function courseRouteSegment(slug: string): string {
  return slugifySegment(slug);
}

export function majorName(major: string): string {
  return siteData.majors[major]?.name.replace(/（[^）]+）/g, '').trim() ?? major;
}
