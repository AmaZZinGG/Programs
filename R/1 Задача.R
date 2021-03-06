library(lmtest)
data = mtcars


#����� 1

#����������� ������ ��� ����, ����� ����� ������ ��� ���� � ���������� ��������������:
#�������� ������� �������� � ����� ��������� �� ��� ������������������ ���������� 

#������� ������:
#mpg - ����������� ����������. ����/(US) ������.
#Disp - ����������� ����������. �����������.
#drat - ����������� ����������.����������� ������� �����.
#wt - ����������� ����������. ���.

#����� ������� ��������� ������ ���������� �� ������������, � ����� ����������� ��������.

data$Logdisp = log(data$disp)
data$Logdrat = log(data$drat)
data$Logwt = log(data$wt)

#����������� ������

data$mpg = (data$mpg - mean(data$mpg))/sqrt(var(data$mpg))
data$disp = (data$disp - mean(data$disp))/sqrt(var(data$disp))
data$drat = (data$drat - mean(data$drat))/sqrt(var(data$drat))
data$wt = (data$wt - mean(data$wt))/sqrt(var(data$wt))

#����������� ���������
data$Logdisp = (data$Logdisp - mean(data$Logdisp))/sqrt(var(data$Logdisp))
data$Logdrat = (data$Logdrat - mean(data$Logdrat))/sqrt(var(data$Logdrat))
data$Logwt = (data$Logwt - mean(data$Logwt))/sqrt(var(data$Logwt))


#����� 2

#�������� �������� � �������� ������������� ����� ����������
#��� ����� �������� �������� ��������� ����� �����������
#��������� ����� �� ���������� Multiple\Adjusted R-squared (����������� ������������) 
#��� �������� ���������� ������� ��������� ������ �� ������ ������� ��� ��� ���� ������� 

#�������� ������ ����������� ����������� ���������� �� ������������ ������� �����

modeldispdrat = lm(disp ~ drat, data)
modeldispdrat 
summary(modeldispdrat) 

#Multiple R-squared:  0.5044,	Adjusted R-squared:  0.4879 
#����������� ������������ �� ����� �������, �������� ����������� �� ����������



#�������� ������ ����������� ������������ ������� ����� �� ����

modeldratwt = lm(drat ~ wt, data)
modeldratwt 
summary(modeldratwt) 

#Multiple R-squared:  0.5076,	Adjusted R-squared:  0.4912
#����������� ������������ �� ����� �������, �������� ����������� �� ����������




#�������� ������ ����������� ������������ ������� ����� �� ����


modeldispwt = lm(disp ~ wt, data)
modeldispwt 
summary(modeldispwt)


#Multiple R-squared:  0.7885,	Adjusted R-squared:  0.7815 
#����������� ������������ ���������� , �� �� ��������� 0.8 , ������� �� ����� ���������� �������

#����� �������, �� ������������ �������� � �������� ������������� ����������


#�����3

#�������� ������� �������� ������ ����������� mpg  �� ���� ����������� ���������� 
#� ������ �� �� ������������ ������������ � �� p-��������
#p-�������� - ��� ����������� ������ ��� ���������� ������� ��������
#(������������� ����, ��� �������� ����������� �� ����������)

model1 = lm(mpg ~ disp + drat + wt, data)
model1 #p-value - (.)()(*)
summary(model1) 
#Multiple R-squared:  0.7835,	Adjusted R-squared:  0.7603

#��������� ������

#����� 4

#������ � ������ ���������
#����� �������� ������ ���������� �� ������������� ����� �� ����� �� �������

#������� �������� �� ��������� Disp � ������ 
model2 = lm(mpg ~ Logdisp + disp + drat + wt, data)
model2 #p-value - (***)(**)()(**)
summary(model2) #Multiple R-squared:  0.8837,	Adjusted R-squared:  0.8665   


#������� �������� �� ��������� drat � ������ 
model3 = lm(mpg ~ Logdrat + drat + disp + wt, data)
model3 #p-value - ()()(.)(*)
summary(model3) #Multiple R-squared:  0.7901,	Adjusted R-squared:  0.759   


#������� �������� �� ��������� wt � ������ 
model4 = lm(mpg ~ Logwt + wt + disp + drat, data)
model4 #p-value - (**)(.)(*)()
summary(model4) #Multiple R-squared:  0.8479,	Adjusted R-squared:  0.8254

#������ ��������� ��������� � ������ model2

#����� 5

#������ � ������ ������������ ������������ �� ��� �����������, � ��� ����� �������� �����������
#����� ���� ��� ��������� ��������� ������� �� ���� ������������ �������� � ������ R^2
  
model5 = lm(mpg ~ disp + drat + I(disp * wt) + wt, data)
model5 #p-value - (*)()(**)(***)
summary(model5) #Multiple R-squared:  0.8511,	Adjusted R-squared:  0.829  

model6 = lm(mpg ~ disp + drat + wt + I(disp * drat), data)
model6 #p-value - (*)()(**)(**)
summary(model6) #Multiple R-squared:   0.84,	Adjusted R-squared:  0.8163  

model7 = lm(mpg ~ disp + drat + wt + I(drat * wt), data)
model7 #p-value (*)()(**)(**)
summary(model7) #Multiple R-squared:  0.8321,	Adjusted R-squared:  0.8072
  
model8 = lm(mpg ~ disp + drat + wt + I(disp^2), data)
model8 #p-value (**)()(**)(***)
summary(model8) #Multiple R-squared:  0.8621,	Adjusted R-squared:  0.8417 

model9 = lm(mpg ~ disp + drat + wt + I(drat^2), data)
model9 #p-value - (.)()(*)()
summary(model9) #Multiple R-squared:  0.791,	Adjusted R-squared:   0.76 

model10 = lm(mpg ~ disp + drat + wt + I(wt^2), data)
model10 #p-value - (*)()(***)(**)
summary(model10) #Multiple R-squared:  0.847,	Adjusted R-squared:  0.8244  

#model8 ��������� ������� � ������ �������� ������������




