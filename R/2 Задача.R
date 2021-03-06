# ��� ������ .sav ������
install.packages("devtools")
devtools::install_github("https://github.com/bdemeshev/rlms")

# ����������� ����������� ���������
library("lmtest")
library("rlms")
library("dplyr")
library("GGally")
library("car")
library("sandwich")
library("Hmisc")



# ������ ������ � 17-� �����
data <- rlms_read("C:\\Users\\AmaZZinG\\Desktop\\practice\\r17i_os26b.sav")
glimpse(data)

# �������� ������������ ��� �������
data2 = select(data, mj13.2, mh5, m_marst, m_educ, m_age, status, mj6.2)
#�������� - mj13.2, ��� - mh5, �������� ��������� - m_marst, ������� ������� ����������� - m_educ, ������� - m_age,
#��� ����������� ������ - status ,������������ ������� ������ - mj6.2

# ����������� ������ ����
data2 = na.omit(data2)
glimpse(data2)


#�������� ������������ �� 3 ������(�� ��������� ���������)
#���������� wed1 ����� �������� 1 � ������, ���� ���������� �����, 0 � � ��������� ������; 
#wed2 = 1, ���� ���������� ������� ��� ������;
#wed3 = 1, ���� ���������� ������� �� ������� � �����;
#������������ ������ �������, ����� �����: ������ � ����� ������ ���������� - ��� 

#�������� ����� ������
data2["wed1"] = data2$m_marst
data2["wed1"] = 0

#�������� � ������������������ ����� = 2, ���������� ����������������, �� ������ �� ��������� = 6
data2$wed1[which(data2$m_marst == '2') | which(data2$m_marst == '6')] = 1


#�������� ����� ������
data2["wed2"] = data2$m_marst
data2["wed2"] = 0
#��������, � ����� �� ������� = 4, ������(�����) = 5
data2$wed2[which(data2$m_marst == '4')] = 1
data2$wed2[which(data2$m_marst == '5')] = 1


#�������� ����� ������
data2["wed3"] = data2$m_marst
data2["wed3"] = 0
#������� � ����� �� �������� = 1 
data2$wed3[which(data2$m_marst == '1')] = 1


#�� ��������� ��� ������� ���������� sex, ������� �������� 1 ��� ������ � ������ 0 ��� ������
data2["sex"] = data2$mh5
data2$sex[which(data2$sex == '1')] = 1 
data2$sex[which(data2$sex == '2')] = 0


# �� ���������, ����������� ���� ���������� ������, �������� ���� �����-���������� city_status
# �� ��������� 1 ��� ������ ��� ���������� ������, 0 � � ��������������� ������.
data2["city_status"] = data2$status
data2["city_status"] = 0
data2$city_status[which(data2$status == '1')] = 1
data2$city_status[which(data2$status == '2')] = 1

#������� ���� �������� higher_educ, ��������������� ������� ������� ������� �����������
data2["higher_educ"] = data2$m_educ
data2["higher_educ"] = 0
#���� ������ ������ �����������
data2$higher_educ[which(data2$m_educ == '21')] = 1
data2$higher_educ[which(data2$m_educ == '22')] = 1
data2$higher_educ[which(data2$m_educ == '23')] = 1

data2$wed1 = as.numeric(data2$wed1)
data2$wed2 = as.numeric(data2$wed2)
data2$wed3 = as.numeric(data2$wed3)
data2$sex = as.numeric(data2$sex)
data2$city_status = as.numeric(data2$city_status)
data2$higher_educ = as.numeric(data2$higher_educ)

#��������� ����������, �������� ����� ��������, ����� ���: ��������, ������������ ������� ������ � �������,
#- ���������� ������������� � ������������ ���������� � ������������� �� :
# ������� ������� �������� �� ���� ����������, ��������� � �������� �� ����������� ����������.

#��������
data2["salary"] = data2$mj13.2
data2$salary = as.numeric(data2$salary)
data2["salary"] = (data2["salary"] - mean(data2$salary)) / sqrt(var(data2$salary))

#������������ ������� ������
data2["week_len"] = data2$mj6.2
data2$week_len = as.numeric(data2$week_len)
data2["week_len"] = (data2["week_len"] - mean(data2$week_len)) / sqrt(var(data2$week_len))

#�������
data2["age"] = data2$m_age
data2$age = as.numeric(data2$age)
data2["age"] = (data2["age"] - mean(data2$age)) / sqrt(var(data2$age))

#������� �������������� ������ 
data3 = select(data2, salary, sex, wed1, wed2, wed3, higher_educ, age, status, week_len)
glimpse(data3)

#1 ��������� �������� ��������� �������� �� ��� ���������, ������� �� �������� �� ������ �����������. 
#�� �������� ������� ����������� ������� ��������� VIF.

#������� ������ ����������� �������� �� ������ ��������
model1 = lm(salary ~ sex + wed1 + wed2 + wed3 + higher_educ + age + status + week_len, data3)
summary(model1)

#��� ����������, ����� wed1 � wed2, ������ ��������� �����(�� 3 - *)
#����� ������ ��� wed1 � wed2
model2 = lm(salary ~ sex + wed3 + higher_educ + age + status + week_len, data3)
vif(model2)

#������� �������������������� ������ 

summary(model2)


#2 ������������������� � ��������� ������������ ����������: ����������� �������� � ������� (���� �� �� 0.1 �� 2 � ����� 0.1)

describe(data3)

#��� ���������������� ����������, ����� �������� ���� > 0

data3["salary"] = data3["salary"] + 1.2
data3["age"] = data3["age"] + 2.1
data3["week_len"] = data3["week_len"] + 3.3

#������ ������ � �����������
model3 = lm(salary ~ sex + wed3 + higher_educ + log(age) + status + log(week_len), data3)
summary(model3)

#��� ���������� ����� ������� ������� � ������
#�������� ������������ ���������� ����������� ��� ���������� ������ 

model4 = lm(salary ~ sex + wed3 + higher_educ + age + status + week_len + I(age * week_len) + I(age^2) + I(week_len^2), data3)
summary(model4)


#���������� � week_len � wed3 ����� ������ ���������, ��������� ��
model5 = lm(salary ~ sex +  higher_educ + age + status + week_len + I(age^2), data3)
summary(model5)

#����� ���������� ���������� � week_len ������ �� ����������, ��� � ������ ���������� ������ ������������ ������ 
#������� ������ �� ����������� ���������� �����������
model6 = lm(salary ~ sex + higher_educ + log(age) + status + log(week_len) + I(log(age) * log(week_len)) + I(log(age)^2) + I(log(week_len)^2),data3)
summary(model6)

#������ ��������� ���������� ������, � ��� �� ������� ���������� � log(age) � I(log(age) * log(week_len)) �������� ������ ��� ���

model7 = lm(salary ~ sex + higher_educ  + status + log(week_len) + I(log(age)^2) + I(log(week_len)^2),data3)
summary(model7)

#���������� ������ ������������� ���������� 

#�������� ������ � ���������� ����������
model8 = lm(salary ~ sex + higher_educ + age + log(age^2)
        + status + week_len + log(week_len^2), data3)
summary(model8)

#�������� ������ ������������ �������, ������ ���������� ���������� log(week_len^2) �� ������


#3 �������� ��������� ������ �� �����������: �� ���������� ����������, ���������� � �����������, � �� ������������ � ������� ����������� ������������ �������� adjusted R^2 - R^2.adj.
#1)model5: R^2=0.2011 ,(���������� ���������� � ������������ ***)
#2)model7: R^2=0.1861 ,(���������� ���������� � ������������ ***)
#3)model8 : R^2=0.1985, (���������� ���������� � ������������ ***)
# � ����� ������ �� ����������� model5

#4 �������� ����� � ���, ����� �������� �������� ���������� ��������


#4 �������� ����� � ���, ����� �������� �������� ���������� ��������
summary(model2)

#�����:���������� �������� �������� ������� (estimate: sex > 0), � ������ ������������ (estimate: higher_educ > 0),
#��������������� ������� (estimate: wed3 < 0), ������ ���� ���������� �� ������ ���������� �����, 
#���� ������� �������� ������� ��� (estimate: age ~ 0), ��� �� ����� ������ ��� �� ��������� ������ (estimate: status < 0), 
#��� ����� �������, �.�. � �������� �������� � ���������� ������ ��������������� ������� ��������. 
#��� �� � ���� ����������� ����������� (estimate: duration > 0). � �����, � ������ ������������ ��������� ����������, 
#�� �������� � ����������� ������������. 



#5 1)��������� ������, �� ���������� � �����; 2)����������� �������, ��� ������� �����������

#1)������ ������ ��������� ������ � �������� ��-�� ����, ��� ��� ��������� ������ (status < 0) �� � ��� ������������ � ����� (wed3 < 0) , 
#� ����� � ������ ������ ��������� �������� ���� ��������

#2)��� ������ ��������� �������� ������������ ������ �/� ��-�� ���������� ������� �����������, � ��������� �� �������� ������� � ���,
#��� ������ ����������� ������ ������������ ���� � �� �������, ����� �������� ��������� ��-�� �������� ����(estimate: sex > 0),
#�� ��� ��� ���������, ��������� ����������� �������� �� �� �������� �� ������ m (wed2 ~ 0)
















































