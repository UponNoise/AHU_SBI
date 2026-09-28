#第8章 线性回归
#8.4.1 一元线性回归分析

attach(women);  
cor(weight,height)

lm1 <- lm(weight ~ height, data = women) # 将回归结果保存在lm1对象里
coef(lm1) # 提取估计系数
coef(lm(weight ~ -1 + height, data = women)) #不加截距项

#例8.1的估计结果
slm <- summary(lm1)
slm $ sigma # 得到总体方差的OLS估计量
slm $ coef # 得到系数有关的矩阵
slm $ coef [ , 2] # 矩阵第二列，即系数标准差
slm $ r.squared #提取R2
#例8.1的变量显著性检验程序和结果
slm<- summary(lm1)
slm
#预测
predict ( lm1 , newdata = data.frame(height = 64.5), 
                     interval = "confidence", level = 0.95)  # 均值预测区间，level为置信度
predict ( lm1 , newdata = data.frame (height = 64.5) ,  
                     interval = "prediction" , level = 0.95 )  # 个值预测区间
#画图
attach(women);  
sx <- sort (height) # 把自变量先从小到大排序
# 求均值的预测区间
conf <- predict(lm1, data.frame(height = sx), interval = "confidence" ) 
# 求个值的预测区间
pred <- predict(lm1, data.frame(height = sx), interval = "prediction" ) 
plot(height,weight, xlab = "身高", ylab = "体重") # 画散点图
abline(lm1) # 添加回归线
lines(sx, conf [ , 2 ] ); lines(sx, conf [ , 3 ] ) 
lines(sx, pred [ , 2 ], lty = 3); lines(sx, pred[ , 3], lty = 3)

##8.4.2 多元线性回归
#R中swiss记录了47个法语城市标准化的生育率指标和社会经济指标。为研究影响生育率的主要原因，对生育率进行有效调整，需建立回归模型。
#影响生育因素很多，主要有从事农业男性百分比Agriculture、小学以上上学率百分比Education、天主教徒百分比Catholic、寿命小于1年婴儿死亡率Infant.Mortality。
lm2 <- lm(Fertility ~ Agriculture+Education+Catholic+Infant.Mortality, data = swiss) #多个自变量用+链接
# lm2 <- lm(Fertility ~ . , data = swiss) # 使用其余全部自变量时可用"."代替
coef(lm2)
summary(lm2) #返回估计结果

slm2 <- summary(lm2)
slm2 $ r.squared #提取R方
slm2 $ adj.r.squared

coef(lm2)
coef(lm2)[1]+coef(lm2)[2]*50+coef(lm2)[3]*15+coef(lm2)[4]*30+coef(lm2)[5]*20 #点预测
predict(lm2, newdata = data.frame(Agriculture=50,Education=15,Catholic=30,Infant.Mortality=20))

