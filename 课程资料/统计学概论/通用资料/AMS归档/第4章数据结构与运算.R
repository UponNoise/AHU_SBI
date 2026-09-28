#第4章  数据结构与运算
# 4.2数据对象

## 向量赋值
x <-c(1,3,5,7,9)#用c()构建向量
c(1,3,5,7,9) -> y  #将c()生成的数值向量赋值给y
u=c(TRUE,FALSE,TRUE,FALSE,FALSE) #将c()生成的逻辑向量赋值给u
v<-paste("x",1:5,sep="") #把自变量对应元素连成一个字符串

#向量运算
x <-c(1,3,5,7,9)
y<-c(1,3,5,7,9)
x * y  #对应元素相乘

#生成有规则序列
(t <- 1:10) #用“:”符号产生有规律的正则序列
(r <- 5:1)
2*1:5
seq(1,10,2) #生成从1开始，10结束，步长为2的序列
seq(10,1,-1) #步长为-1
rep(c(1,3),4)  #将c(1,3)向量重复4次
rep(c(1,3),each=4) #将c(1,3)向量中每个元素都重复4次

#向量的常见函数
x<-c(1,3,5,2,3)
length(x) #求长度
mode(x) #求数据类型
min(x)
range(x) #返回向量范围
which.max(x) #返回向量最大值
t <- 1:10
mean(t) #求向量均值
sd(t) #求标准差

#向量索引
x <- c(1,3,5,7,9)
x[2]  #返回x向量的第2元素
x[2] <- 6 #将6赋值给x向量的第2个元素，即替换掉原来的值
x[c(1,3)] <- c(9,11) #将9和11赋值给x向量的第1和第3个元素
x <- c(1,3,5)
x < 4  #返回逻辑结果，即x向量的元素是否小于4
x[x<4] #返回x向量里小于4的元素
x <- 1:10
x[-(1:5)] #删除x向量中第1到第5个元素

## 矩阵
#矩阵赋值
matrix(1:6,nrow=2,ncol=3) #byrow默认下按列填充
matrix(1:6,nrow=2,ncol=3,byrow=T) #按行填充

#矩阵索引
(A<-matrix(1:9,3,3))
A[2,3] #返回矩阵第2行第3列元素
A[2,]#返回矩阵第2行所有元素
A[1:3,2] #返回矩阵第1到3行，且是第2列的元素

#矩阵运算
(A <- matrix(1:6,nrow=2,ncol=3))
t(A)  #求矩阵转置
A <- B <- matrix(1:6,nrow=2) #将生成的矩阵赋给B，同时又赋给A
A+B
3*A #对应元素相乘
t(A)%*%B  #矩阵乘法
crossprod(A,B)
(A <- matrix(1:9,nrow=3))
diag(A) #取矩阵的对角元素
diag(c(1,2,3))
diag(3)

A<-diag(c(1,2,4))
solve(A) #求A的逆

(A <- diag(3)+1)
(A.eigen <- eigen(A,symmetric=T)) #求矩阵的特征根和特征向量

(A <- matrix(1:12,3))
dim(A) #求矩阵维数
nrow(A) #求行数
rowSums(A) #求各行和
rowMeans(A) #求行均值

A<-matrix(1:9,3)
row(A) #求行下标
col(A)
A[row(A)<col(A)]=0 #求下三角矩阵
det(A)

A <- matrix(1:12,3,4)
apply(A,2,sum) #矩阵的列求和
apply(A,2,mean) #矩阵的列求均值
B=matrix(c(1,1,1,1),2,2) #生成2×2的矩阵
rbind(B,B) #将B和B矩阵按行合并
cbind(B,B) #将B和B矩阵按列合并

## 数组
(xx <- array(1:24,c(3,4,2)))    # 产生维数为(3,4,2)的3维数组
xx[2,3,2]
xx[2,1:3,2]
xx[,2,]
dim(xx)

zz<-c(2,5,6,8,1,4,6,9,10,7,3,5)
dim(zz)<-c(2,2,3) #将向量转成维度为（2,2,3）的数组
zz

## 因子
y <- c("女","男","男","女","女","女","男") 
(f <- factor(y)) #生成因子
levels(f) #提取因子的水平
score <- c("B","C","D","B","A","D","A")
(score_o <- ordered(score,levels=c("D","C","B","A"))) #生成有序因子

##  列表
x <- c(1,1,2,2,3,3,3)   
y <- c("女","男","男","女","女","女","男")  
z <- c(80,85,92,76,61,95,83)
(LST <- list(class=x,sex=y,score=z))
LST[[3]] #返回列表的第三个成分的值
LST[[2]][1:3] #返回列表第二个成分的第1到3元素
LST$score #返回score值
LST$sc #返回score值
LST[3] 
mode(LST[3])
LST[[3]]
mode(LST[[3]])

#  数据框
#数据框的生成
(student <- data.frame(x,y,z))
(student <- data.frame(class=x,sex=y,score=z))
#数据框的索引
student[,"score"]     #返回数据框student的所有样本的socre值
student[,3]  #返回第3列变量的值
student[1:5,1:3]  #返回第1至第5行，第1至第3列的值
student$score 
student[["score"]]
student[[3]]
student[student$score>80,] #得到成绩大于80分的学生
#数据框绑定
attach(student)
score
#要取消连接，用函数detach()即可。
detach()
score







#4.3 函数与优化

###4.3.1 条件控制语句
##4.3.1.1  if/else语句
x<-4
if(x>2) 2+x else 3*x #假如x大于2，则返回2+x，否则返回3*x
if(x>3){
  2+x
} else if(x>2){
  3*x
}else{
  4*x
}#假如x大于3，返回2+x，假如x在2和3之间，返回3*x，否则返回4*x

##4.3.1.2  ifelse 语句
x<-4
ifelse(x>2, 2+x, 3*x) #假如x大于2，则返回2+x，否则返回3*x

##4.3.1.3  switch语句
switch(1,"beef","apple","potato")  #返回"beef"，"apple"，"potato"中的第一个成分
switch(2,"beef","apple","potato")  #返回"beef"，"apple"，"potato"中的第二个成分
switch(3,"beef","apple","potato")  #返回"beef"，"apple"，"potato"中的第三个成分
x<-"fruit"
switch(x, meat="beef", fruit="apple", vegetable="potato")

###4.3.2循环语句
##4.3.2.1  for循环
Fibonacci<-NULL #生成一个空置向量
Fibonacci[1]<-Fibonacci[2]<-1 # Fibonacci向量的第1和2个元素赋值为1
n=14
for (i in 3:n) Fibonacci[i]<-Fibonacci[i-2]+Fibonacci[i-1] #用for执行循环语句
Fibonacci

##4.3.2.2  while循环
#编写小于500的Fibaonacci序列
Fibonacci[1]<-Fibonacci[2]<-1 # Fibonacci向量的第1和2个元素赋值为1
i<-1
while (Fibonacci[i]+Fibonacci[i+1]<500) {  #用while执行循环语句
  Fibonacci[i+2]<-Fibonacci[i]+Fibonacci[i+1]
  i<-i+1 } 
Fibonacci

#4.3.2.3  repeat语句
#利用repeat生成小于500的Fibonacci序列
Fibonacci[1]<-Fibonacci[2]<-1 # Fibonacci向量的第1和2个元素赋值为1
i<-1
repeat {    #用repeat执行循环语句
  Fibonacci[i+2]<-Fibonacci[i]+Fibonacci[i+1]
  i<-i+1
  if (Fibonacci[i]+Fibonacci[i+1]>=500) break
}
Fibonacci

###4.3.3 编写自己的函数
##4.3.3.1 函数名
BMI = function(w,h) { w/h^{2} }#其中w表示体重（kg），h表示身高（m）
BMI(45,1.62) #计算体重为45kg，身高为1.62的人的BMI值

##4.3.3.2 参数
#无参数
welcome = function() print("welcome to use R") 
welcome()
#单参数
welcome.ab = function(names) print(paste("welcome",names,"to use R")) 
welcome.ab("Mr fang")
#多参数
sim.t = function(n,mu,sigma){
  x=rnorm(n,mu,sigma)
  (mean(x)-mu)/(sd(x)/ sqrt(n))
}
sim.t(50,0,1)         # 样本含量为50，均值为0，标准差为1
sim.t(100,sigma=10,mu=1) #样本含量为100，均值为1，标准差为10
#默认参数
welcome.ab=function(names="Mr. Fang")print(paste("welcome", names,"to use R"))
welcome.ab()
plot.f=function(f,a,b,...){
  xvals=seq(a,b,length=100) #生成100个[a,b]区间内的数列
  plot(xvals,f(xvals),type="l",col="red",xlab="x",ylab="f(x)",...) #作函数图
} 
par(mfrow=c(1,2)) #准备一张可以并排放置两张图片的画布
plot.f(cos,-2*pi,2*pi)   
curve(cos,-2*pi,2*pi,col="blue")   

par(mfrow=c(1,2))
f<-function(x){(x-2)*(x+3)*x}     #自定义一个一元三次函数
plot.f(f,-3,3)      #绘制 -3 到3的一元三次函数图，见2-4左图
plot.f(exp,0,5)   #绘制0到5的指数函数图.

##4.3.3.3 函数体和函数返回值
my.average = function(x) sum(x)/length(x) #求均值
my.average(c(1,2,3))

as<-function(x){ #计算向量的均值和标准差
  a=mean(x)
  s=sd(x)
  return(list(avg=a,std=s))
}
y<-c(5,15,32,25,26,28,65,48,3,37,45,54,23,44)
as(y)

###4.3.4程序运行时间与效率
proc.time() #返回当前R已经运行的时间
system.time(expr,gcFirst=TRUE)

system.time(for(i in 1:100) mad(rnorm(1000)))    #mad求中位数
#等价于：
ptm<-proc.time() #将proc.time()的返回值保存到ptm对象里
for(i in 1:100) mad(rnorm(1000))
proc.time()-ptm #两者的差即运行程序所需的时间

#求两个向量的差
#程序1
ptm<-proc.time()
n<- 1000000
x<-runif(n)
y<-runif (n)
z<-c()
for (i in 1:n){
  z<-c(z,x[i]-y[i])
}
proc.time()-ptm
#程序2
ptm<-proc.time()
n<- 1000000
x<-runif(n)
y<-runif (n)
z<-rep(NA,n)
for (i in 1:n){
  z[i]<-x[i]-y[i]
}
proc.time()-ptm
#程序3
ptm<-proc.time()
n<- 1000000
x<-runif(n)
y<-runif (n)
z<-x-y
proc.time()-ptm
#使用parallel、snowfall实现并行运算
n<-8^{8}
ptm<-proc.time()
k<-lapply(1:n, function(x) {if(x>500) x+2 else x+4})
proc.time()-ptm

n<-8^{8}
#install.packages("parallel")
library(parallel)
ptm<-proc.time()
cores<-4  #设置线程，线程越多，速度越快
ori<-makeCluster(cores)  #初始化
K<-parLapply(ori,1:n, function(x) {if(x>500) x+2 else x+4})
stopCluster(ori)   #结束并行
proc.time()-ptm


###4.3.5 用R做优化求解
##4.3.5.1 一元函数优化求解
f<-function(x){-x*x-4*x-4} #编写f函数
optimize(f,c(-6,2),tol=0.0001,maximum=T) #求f函数的最大值的返回结果
##4.3.5.2 多元函数优化求解
x1=x2=seq(-10,10,length=100)
fr1=function(x1,x2){
  (x1^2+x2+1)^2+(x1+x2^2-7)^2
}
z=outer(x1,x2,fr1) #求外积
persp(x1,x2,z,box=T,border=T,theta=45,phi=35,col= rainbow(100)) #绘制三维图
fr2=function(x){
  x1<-x[1]
  x2<-x[2]
  (x1^2+x2+1)^2+(x1+x2^2-7)^2
}
grr<-function(x){
  x1<-x[1]
  x2<-x[2]
  c(4*(x1^2+x2+1)*x1+2*(x1+x2^2-7),2*(x1^2+x2+1)+4*(x1+x2^2-7) *x2)
}#一阶导数
optim(c(-1,-1),fr2,grr) #设初始值为-1，-1，不同初始值的优化结果可能不同

##4.3.5.3约束条件下的优化求解
uimat=rbind(c(1,0),c(0,1))
cimat=c(0,0)
constrOptim(c(0.2,0.5),fr2,grr,ui=uimat,ci=cimat)#其中fr2为目标函数，grr为一阶导数
fr3=function(z){  #编写目标函数
  x1=exp(z[1])
  x2=exp(z[2])
  (x1^2+x2+1)^2+(x1+x2^2-7)^2
}
grrNew=function(z){
  x1=exp(z[1])
  x2=exp(z[2])                     #写一阶导表达式(梯度表达式)
  c(4*(x1^2+x2+1)*x1*exp(z[1])+2*(x1+x2^2-7)*exp(z[1]), 2*(x1^2+x2+1)*exp(z[2])+4*(x1+x2^2-7)*x2*exp(z[2]))
}
optran=optim(c(-1.6,-0.7),fr3,grrNew)   #注意：此处最大值返回的是z值的取值
#log(0.2)=-1.6,log(0.5)=-0.7
exp(optran$par) #将z值换算回x的取值
