#第10章 模型选择与正则化
#10.5.1 子集选择法

#载入数据
#install.packages("ISLR")
library (ISLR)
data (College)
# https://jishuzhan.net/article/1950506947786092546
#将College中Apps(申请者)作为因变量(即响应变量y），将其他变量作为预测变量(即自变量x)
names (College) #返回数据集变量名，限于篇幅省略打印
dim (College)
#最优子集法
#install.packages("leaps")
library (leaps)
subset.full <- regsubsets ( Apps ~ . , College )
summary ( subset.full )
subset.full <- regsubsets ( Apps ~ . , College , nvmax = 17 )
full.summary <- summary ( subset.full )
names ( full.summary )
full.summary $ rsq
#绘图
par ( mfrow = c ( 1 , 3 ) )
# CP
which.min ( full.summary $ cp )
plot ( full.summary $ cp , xlab = "Number of Variables" , ylab = "CP" , type = "b" )
points ( 12 , full.summary $ cp [ 12 ] , col = "red" , cex = 2 , pch = 20 )
# BIC
which.min ( full.summary $ bic )
plot ( full.summary $ bic , xlab = "Number of Variables" , ylab = "BIC" , type = "b" )
points ( 10 , full.summary $ bic [ 10 ] , col = "red" , cex = 2 , pch = 20 )
# Adjust Rsq
which.max ( full.summary $ adjr2 )
plot ( full.summary$adjr2 , xlab = "Number of Variables" , ylab = "Adjusted RSq" , type = "b" )
points ( 13 , full.summary $ adjr2 [ 13 ] , col = "red" , cex = 2 , pch = 20 )

coef ( subset.full , 10 ) #提取该模型的参数估计值

# (1) 向前逐步选择法
subset.fwd <- regsubsets ( Apps ~ . , College , nvmax = 17 , method = "forward" )
summary ( subset.fwd )
# 限于篇幅，此处省略
# (2) 向后逐步选择法
subset.bwd <- regsubsets ( Apps ~ . , College , nvmax = 17 , method = "backward" )
summary ( subset.bwd )

#10.5.2 压缩估计法
#线性回归   模拟产生200的样本，维数p=20，各自变量独立同分布N(0,1)，回归系数真实值由beta设定给出，截距项为0，误差满足N(0,1)。
x <- matrix ( rnorm ( 100*20 ) , 100 , 20 ) 
beta <- c ( seq ( 1 , 2 , length.out = 6 ) , 0 , 0 , 0 ,  0 , rep ( 1 , 10 ) )
y <- x %*% beta + rnorm ( 100 )
# (1) LASSO惩罚 
#install.packages("glmnet", dependencies = TRUE) # 安装并包含依赖包
library (glmnet)
fit1 <- cv.glmnet ( x , y , family = "gaussian" )
beta.fit1 <- coef ( fit1 ) # 提取参数的估计值
beta.fit1
resid1 <- ( x %*% beta.fit1 [ -1 ] + beta.fit1 [ 1 ] - y )
MSE1 <- sum ( resid1 ^ 2 ) # 计算残差平方和
MSE1
# (2) MCP惩罚 
#install.packages("ncvreg")
library (ncvreg)
fit2 <- cv.ncvreg ( x , y , family = "gaussian" )
fit.mcp <- fit2$fit
beta.fit2 <- fit.mcp$beta [ , fit2$min ] # 提取参数的估计值
round ( beta.fit2 , 3 ) # 保留三位小数
resid2 <- ( x %*% beta.fit2 [ -1 ] + beta.fit2 [ 1 ] - y )
MSE2 <- sum( resid2 ^ 2 ) # 计算残差平方和
MSE2
# (3) SCAD惩罚 
fit3 <- cv.ncvreg ( x , y , family = "gaussian" , penalty = "SCAD" )
fit.scad <- fit3$fit
beta.fit3 <- fit.scad$beta [ , fit3$min ] # 提取参数的估计值
round ( beta.fit3 , 3 ) # 保留三位小数
resid3 <- ( x %*% beta.fit3 [ -1 ] + beta.fit3 [ 1 ] - y )
MSE3 <- sum( resid3 ^ 2 ) # 计算残差平方和
MSE3


# 数据集内容：该数据集描述了452个南非人的身体健康状况指标，用来研究哪些因素对是否患有心脏病有影响。其中，因变量chd是一个个二分类变量，代表是否患有冠心病，自变量共9个，包括sbp（血压）、tobacco（累计烟草量）、ldl（低密度脂蛋白胆固醇）、adiposity（肥胖）、famhist（是否有心脏病家族史，定性变量）、typea（型表现）、obesity（过度肥胖）、alcohol（当前饮酒）、age（年龄）。

library(ncvreg)
data(Heart)
data=Heart
x <- Heart$X
dim(x)
y <- Heart$y
length(y)
# (1) LASSO惩罚 
library(glmnet)
fit1 <- cv.glmnet ( x , y , family = "binomial" )
beta.fit1 <- coef ( fit1 )
beta.fit1

# (2) MCP惩罚 
#cv.ncvreg()函数默认使用 MCP 惩罚（最小最大凹惩罚

fit2 <- cv.ncvreg(x, y, family = "binomial")
beta.fit2 <- fit2$fit$beta[, fit2$min]
beta.fit2


# (3) SCAD惩罚 
fit3 <- cv.ncvreg(x, y, family = "binomial", penalty = "SCAD")
beta.fit3 <- fit3$fit$beta[, fit3$min]
beta.fit3

#10.5.3 组变量选择
#https://runebook.dev/zh/docs/r/library/mass/html/birthwt
birthwt 数据集是 MASS (Modern Applied Statistics with S) 包自带的一个经典数据集，常用于逻辑回归等统计模型的教学和演示。它包含了关于新生儿体重（以克为单位）和一些母亲的风险因素的信息。这个数据集的目的是研究哪些因素与低出生体重（低于 2500 克）相关。

#查看数据格式
#install.packages("grpreg")
library(grpreg)
data(birthwt.grpreg)
X <- as.matrix ( birthwt.grpreg [ , -1 : -2 ] )
y <- birthwt.grpreg$bwt
colnames ( X )
group <- c ( 1 , 1 , 1 , 2 , 2 , 2 , 3 , 3 , 4 , 5 , 5 , 6 , 7 , 8 , 8 , 8 )  # 变量组结构

cvfit <- cv.grpreg ( X , y , group , penalty = "grLasso" )
coef ( cvfit ) # Beta at minimum Cross-Validation Error

#Logistic回归
library ( grpreg )
data ( birthwt.grpreg )
X <- as.matrix ( birthwt.grpreg [ , -1 : -2 ] )
y <- birthwt.grpreg$low
group <- c ( 1 , 1 , 1 , 2 , 2 , 2 , 3 , 3 , 4 , 5 , 5 , 6 , 7 , 8 , 8 , 8 ) # 变量的分组结构
cvfit <- cv.grpreg ( X , y , group , penalty = "grLasso" )
coef ( cvfit ) # Beta at minimum Cross-Validation Error
summary ( cvfit )
plot ( cvfit )

#10.5.4 双层变量选择
# (1) Group Bridge
library ( grpreg )
data ( birthwt.grpreg )
X <- as.matrix ( birthwt.grpreg [ , -1 : -2 ] )
y <- birthwt.grpreg $ bwt
group <- c ( 1 , 1 , 1 , 2 , 2 , 2 , 3 , 3 , 4 , 5 , 5 , 6 , 7 , 8 , 8 , 8 ) # 变量的分组结构
cvfit.b <- gBridge ( X , y , group ) # L1 group bridge
select ( cvfit.b ) $ beta
# (2) Composite MCP
cvfit.m <- cv.grpreg ( X , y , group , penalty = "cMCP" , gama = 2.5 ) 
coef ( cvfit.m )

#install.packages("SGL")
library ( SGL )
library ( grpreg )
data ( birthwt.grpreg )
X <- as.matrix ( birthwt.grpreg [ , -1 : -2 ] )
y <- birthwt.grpreg $ bwt
group <- c ( 1 , 1 , 1 , 2 , 2 , 2 , 3 , 3 , 4 , 5 , 5 , 6 , 7 , 8, 8 ,8) # 变量的分组结构
data <- list ( x = X , y = y )
cvFit <- cvSGL ( data , group , type = "linear" ) # SGL
lambda.min <- which.min ( cvFit $ lldiff )
cvFit $ fit $ beta [ , lambda.min ]














