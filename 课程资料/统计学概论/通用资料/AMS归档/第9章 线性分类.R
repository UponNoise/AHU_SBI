#第9章 线性分类模型

##9.5.1 描述统计
#例9.1的数据集通常被称为 Pima.tr (训练集) 和 Pima.te (测试集)，或合在一起用于教学和模型构建。
#它来自 R 语言的 MASS 扩展包，记录了亚利桑那州皮马印第安女性的健康测量和糖尿病状况。
#这个数据集是学习分类模型（如逻辑回归、判别分析等）的经典案例。
#npreg	怀孕次数
#glu	血浆葡萄糖浓度 (Plasma glucose concentration)
#bp	舒张压 (Diastolic blood pressure)
#skin	三头肌皮褶厚度 (Triceps skin fold thickness)
#ins	2小时血清胰岛素 (2-Hour serum insulin)
#bmi	身体质量指数 (Body mass index)
#ped	糖尿病家系功能 (Diabetes pedigree function)
#age	年龄
#type	类别变量：是 (Yes) 还是否 (No) 患有糖尿病

library(MASS)
Pima = rbind(Pima.tr,Pima.te)[,1:7]
head(Pima)
y<- as.numeric(rbind(Pima.tr,Pima.te)$type)-1
Pima = data.frame(Pima,y)
attach(Pima)
#R语言attach命令，#教你使用R语言的attach命令在R语言中，`attach`命令用于在数据框中添加数据集的上下文，让你可以直接引用数据框中的列，而无需每次都使用`$`运算符。 
summarys <- function(x) {data.frame(mean=mean(x), max=max(x),min=min(x), sd=sd(x))} # 自编一个求基本描述统计量简单函数
summarys(npreg); summarys(glu); summarys(bp); summarys(skin)
summarys(bmi); summarys(ped); summarys(age); summarys(y)

#OLS估计
lpm <- lm (y ~ npreg+glu+bp+skin+bmi+ped+age, data = Pima)
summary(lpm)
#Logit模型估计
logit_m <- glm ( y ~ npreg+glu+bp+skin+bmi+ped+age, 
                family = binomial ( link = "logit" ), data = Pima) # 注意link设为logit
summary(logit_m)

#install.packages("zoo")
#install.packages("lmtest")
library(lmtest)
library(zoo)
lrtest (logit_m ) # LR检验
coe.l <- coef ( logit_m ) # 提取logit模型系数
logit <- dlogis (coe.l[1] + coe.l[2]*mean (npreg) + coe.l[3]*mean(glu) + coe.l[4]*mean(bp) + coe.l[5]*mean(skin) + coe.l[6]*mean(bmi) + coe.l[7]*mean(ped) +coe.l[8]*mean(age)) 
coe.l*logit # 求logit模型平均边际影响

##9.5.3 判别分析
#LDA模型
lda.fit<- lda(y ~ npreg+glu+bp+skin+bmi+ped+age, data=Pima)
lda.fit
#对LDA模型的训练误差进行估计
lda.pred <- predict(lda.fit, Pima)
names(lda.pred)
lda.class <- lda.pred $ class
table(lda.class, Pima$y, dnn = c("Prediction" , "Actual"))
mean(lda.class != Pima$y)
#二次判别分析
qda.fit <- qda (y ~ npreg+glu+bp+skin+bmi+ped+age, data = Pima)
qda.fit
qda.pred <- predict ( qda.fit , Pima) #预测
names ( qda.pred )
qda.class <- qda.pred$class
table(qda.class, Pima$y, dnn = c ( "Prediction" , "Actual" ) )
mean(qda.class != Pima$y) #QDA模型训练误差

##9.5.4 模型比较
#计算错分率
logit.pred <- predict ( logit_m , Pima , type = "response" )
logit.class <- rep ( 0 , nrow (Pima) )
logit.class [ logit.pred > 0.5 ] <- 1 #阈值设为0.5
table ( logit.class , Pima$y , dnn = c ( "Prediction" , "Actual" ) )
mean ( logit.class != Pima$y)

#ROC曲线
#install.packages("pROC")
library(pROC)
logit.pred2 <- predict ( logit_m , Pima , type = "response" )
lda.pred2 <- predict ( lda.fit , Pima) $ posterior [ , 2 ]
qda.pred2 <- predict ( qda.fit , Pima) $ posterior [ , 2 ]
par ( mfrow = c ( 2 , 2 ) )
roc(y, logit.pred2, plot=TRUE, main = "Logit")
roc(y, lda.pred2  , plot=TRUE, main = "LDA")
roc(y, qda.pred2  , plot=TRUE, main = "QDA")








