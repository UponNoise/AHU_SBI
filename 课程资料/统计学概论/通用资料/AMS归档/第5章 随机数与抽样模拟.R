#第5章  随机数与抽样模拟

###5.1 一元随机数产生
##5.1.1  均匀分布随机数

runif(3,1,5)    # 生成3个[1,5] 的均匀分布的随机数
runif(3)        # 默认生成3个[0,1]上的均匀分布随机数

set.seed(1) #种子取一样，生成的随机数相同
runif(3)

Nsim=10^3
x=runif(Nsim) 
x1=x[-Nsim] #因为要求自相关系数，去掉最后一个数
x2=x[-1]  #去掉第一个数
par(mfrow=c(1,3))
hist(x,prob=T,col="blue",main="uniform on [0,1]") #直方图
curve(dunif(x,0,1),add=T,col="red") #添加均匀分布密度函数线
plot(x1,x2,col="red",pch=17)
acf(x)#画自相关系数图

#5.1.2  正态分布随机数

rnorm(3,10,5) #产生3个均值为10标准差为5的正态分布随机数
rnorm(3)   # 默认3个生成标准正态分布随机数

x=rnorm(1000)
hist(x,prob=T,main="normal mu=0,sigma=1",col="blue") #作直方图
curve(dnorm(x),add=T,col="red") #在直方图上添加标准正态分布密度函数线

##5.1.3 离散分布随机数的生成


size=1; p=0.4
rbinom(10,size,p)
size=10; p=0.4
rbinom(5,size,p)  # 生成5个服从B(10,0.4)的二项分布随机数

#分别产生100个n为10，20，50, 概率p为0.4的二项分布随机数
par(mfrow=c(1,3))
p=0.4
for( n in c(10,20,50)){  
  x=rbinom(100,n,p)
  hist(x,prob=T,main=paste("n =",n),col=rainbow(n))
  xvals=0:n
  points(xvals,dbinom(xvals,n,p),type="h",lwd=3)
}

#求标准正态分布的累积概率和分位数
pnorm(1)
qnorm(0.95)

###5.2 多元随机数产生
##5.2.1多元正态分布随机数
#install.packages("MASS")
library(MASS)  #载入MASS包
Sigma <- matrix(c(5,2,2,1),2,2) #生成协方差矩阵
x=mvrnorm(n=1000, rep(0, 2), Sigma)
head(x ,n=3L)
var(x)
plot(x,col= "red ")
#5.2.2 多元正态分布密度函数、分位数与累积概率
#install.packages("mvtnorm")
library(mvtnorm)
mean <- rep(0, 3) #均值向量
lower <- rep(-1, 3) #下限
upper <- rep(1, 3) #上限
corr <- diag(3) #相关系数矩阵
corr[lower.tri(corr)] <- 0.5 #相关系数矩阵下三角用0.5赋值
corr[upper.tri(corr)] <- 0.5 #相关系数矩阵上三角用0.5赋值
pmvnorm(lower, upper, mean, corr)

###5.3  随机抽样
##5.3.1  放回与无放回抽样
#模拟重复掷一颗六面的骰子和掷两颗六面的骰子5次的结果
sample(1:6,5,rep=T)  #掷一颗六面的骰子，重复5次
dice=as.vector(outer(1:6,1:6,paste))        #掷两颗六面的骰子所有可能的结果
sample(dice,5,replace=T)                #重复5次
##5.3.2 分层抽样
#从chickwts数据集的饮食种类中各抽取一个样本
#install.packages("sampling")
library(sampling)
strata(chickwts,stratanames=("feed"),size=rep(1,6),method="srswor")

###5.4  统计模拟
##5.4.1  直方图模拟
#生成二项分布随机数的标准化变量
n=20;p=0.3
z=rbinom(1,n,p) #模拟生成一个二项分布随机数
(z-n*p)/sqrt(n*p*(1-p)) #计算标准化变量
#需要产生1000个这样的随机数
m =1000                      # m为模拟次数
n = 20; p = 0.3
z = rbinom(m,n,p)              # 产生1000个二项随机数
x = (z-n*p)/sqrt(n*p*(1-p))       # 对1000个二项随机数标准化
hist(x,prob=T,main=paste("n =",n,"p=",p),col="red")
curve(dnorm(x),add=T,col="blue")          # 添加正态曲线
#将上面的程序形成一个模拟函数再进行模拟
sim.clt <- function(m,n,p){ 
  z = rbinom(m,n,p)               
  x = (z-n*p)/sqrt(n*p*(1-p))        
  hist(x,prob=T,breaks=20,main=paste("n =",n,"p =",p), col="red")
  curve(dnorm(x),add=T,col="blue")             
}
par(mfrow=c(1,2))
sim.clt(2000,100,0.6)      # 取 m=2000，n=100，p=0.6
sim.clt(1000,30,0.5)   # 取 m=1000，n=30，p=0.5

##5.4.2  正态概率模拟
#分别产生1000个均值为0，标准差为1的正态分布随机数以及均值为10的指数分布。重复计算1000次它们的标准化变量。再分别作它们的正态概率图
n=1000;mu=10 #mu为指数分布均值
par(mfrow=c(1,3))   
x=rnorm(n,0,1);qqnorm(x,main="N(0,1)",col="red");qqline(x,col="blue") #画QQ图并添加qq线 
z=rexp(n,1/mu);qqnorm(z,main="exp(0.1)",col="brown");qqline(z,col="blue")
y=replicate(1000,(mean(rexp(n,1/mu))-mu)/(mu/sqrt(n)))
qqnorm(y,main="趋于N(0,1)",col="orange");qqline(y,col="blue")

##5.4.3  模拟函数的建立方法
#二项分布
f<-function(n=100,p=0.5){s=rbinom(1,n,p);(s-n*p)/sqrt(n*p*(1-p))}
x=sim.fun(10000,f)                 # 模拟10000个二项随机数
hist(x,prob=T,col="brown",main="二项分布验证中心极限定理")
curve(dnorm(x),add=T,col="blue")
#均匀分布
f = function(n=10) (mean(runif(n))-1/2)/(1/sqrt(12*n))
x=sim.fun(10000,f)                 # 模拟10000个均匀随机数
hist(x,prob=T, col="orange",main="均匀分布验证中心极限定理")
curve(dnorm(x),add=T,col="blue")
#指数分布
f <- function(n,mu)(mean(rexp(n,1/mu))-mu)/(mu/sqrt(n))
par(mfrow=c(1,3))
x<- sim.fun(1000,f,5,10)
hist(x,prob=T,main="n=5",col="red")
curve(dnorm(x),add=T,col="blue")
x<- sim.fun(1000,f,10,10)
hist(x,prob=T,main="n=10",col="brown")
curve(dnorm(x),add=T,col="blue")
x<- sim.fun(1000,f,100,10)
hist(x,prob=T,main="n=100",col="orange")
curve(dnorm(x),add=T,col="blue")
