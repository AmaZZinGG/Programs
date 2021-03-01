# для чтения .sav файлов
install.packages("devtools")
devtools::install_github("https://github.com/bdemeshev/rlms")

# подключение необходимых библиотек
library("lmtest")
library("rlms")
library("dplyr")
library("GGally")
library("car")
library("sandwich")
library("Hmisc")



# чтение данных о 17-й волне
data <- rlms_read("C:\\Users\\AmaZZinG\\Desktop\\practice\\r17i_os26b.sav")
glimpse(data)

# выделяем интересующие нас столбцы
data2 = select(data, mj13.2, mh5, m_marst, m_educ, m_age, status, mj6.2)
#зарплата - mj13.2, пол - mh5, семейное положение - m_marst, наличие высшего образования - m_educ, возраст - m_age,
#тип населенного пункта - status ,длительность рабочей недели - mj6.2

# отбрасываем пустые поля
data2 = na.omit(data2)
glimpse(data2)


#Разделим респондентов на 3 группы(по семейному положению)
#переменная wed1 имеет значение 1 в случае, если респондент женат, 0 – в противном случае; 
#wed2 = 1, если респондент разведён или вдовец;
#wed3 = 1, если респондент никогда не состоял в браке;
#Просматривая другие знчения, делаю вывод: смысла в вводе других параметров - нет 

#Обнуляем новый стобец
data2["wed1"] = data2$m_marst
data2["wed1"] = 0

#Состоите в зарегистрированном браке = 2, ОФИЦИАЛЬНО ЗАРЕГИСТРИРОВАНЫ, НО ВМЕСТЕ НЕ ПРОЖИВАЮТ = 6
data2$wed1[which(data2$m_marst == '2') | which(data2$m_marst == '6')] = 1


#Обнуляем новый стобец
data2["wed2"] = data2$m_marst
data2["wed2"] = 0
#разведен, в браке не состоит = 4, вдовец(вдова) = 5
data2$wed2[which(data2$m_marst == '4')] = 1
data2$wed2[which(data2$m_marst == '5')] = 1


#Обнуляем новый стобец
data2["wed3"] = data2$m_marst
data2["wed3"] = 0
#Никогда в браке не состояли = 1 
data2$wed3[which(data2$m_marst == '1')] = 1


#Из параметра пол сделаем переменную sex, имеющую значение 1 для мужчин и равную 0 для женщин
data2["sex"] = data2$mh5
data2$sex[which(data2$sex == '1')] = 1 
data2$sex[which(data2$sex == '2')] = 0


# Из параметра, отвечающего типу населённого пункта, создайте одну дамми-переменную city_status
# со значением 1 для города или областного центра, 0 – в противоположном случае.
data2["city_status"] = data2$status
data2["city_status"] = 0
data2$city_status[which(data2$status == '1')] = 1
data2$city_status[which(data2$status == '2')] = 1

#Введите один параметр higher_educ, характеризующий наличие полного высшего образования
data2["higher_educ"] = data2$m_educ
data2["higher_educ"] = 0
#есть полное высшее образование
data2$higher_educ[which(data2$m_educ == '21')] = 1
data2$higher_educ[which(data2$m_educ == '22')] = 1
data2$higher_educ[which(data2$m_educ == '23')] = 1

data2$wed1 = as.numeric(data2$wed1)
data2$wed2 = as.numeric(data2$wed2)
data2$wed3 = as.numeric(data2$wed3)
data2$sex = as.numeric(data2$sex)
data2$city_status = as.numeric(data2$city_status)
data2$higher_educ = as.numeric(data2$higher_educ)

#Факторные переменные, «имеющие много значений», такие как: зарплата, длительность рабочей недели и возраст,
#- необходимо преобразовать в вещественные переменные и нормализовать их :
# вычесть среднее значение по этой переменной, разделить её значения на стандартное отклонение.

#Зарплата
data2["salary"] = data2$mj13.2
data2$salary = as.numeric(data2$salary)
data2["salary"] = (data2["salary"] - mean(data2$salary)) / sqrt(var(data2$salary))

#длительность рабочей недели
data2["week_len"] = data2$mj6.2
data2$week_len = as.numeric(data2$week_len)
data2["week_len"] = (data2["week_len"] - mean(data2$week_len)) / sqrt(var(data2$week_len))

#возраст
data2["age"] = data2$m_age
data2$age = as.numeric(data2$age)
data2["age"] = (data2["age"] - mean(data2$age)) / sqrt(var(data2$age))

#Соберем подготовленные данные 
data3 = select(data2, salary, sex, wed1, wed2, wed3, higher_educ, age, status, week_len)
glimpse(data3)

#1 Постройте линейную регрессию зарплаты на все параметры, которые Вы выделили из данных мониторинга. 
#Не забудьте оценить коэффициент вздутия дисперсии VIF.

#Построю модель зависимости зарплаты от других вакторов
model1 = lm(salary ~ sex + wed1 + wed2 + wed3 + higher_educ + age + status + week_len, data3)
summary(model1)

#все регрессоры, кроме wed1 и wed2, хорошо описывают даные(по 3 - *)
#Строю модель без wed1 и wed2
model2 = lm(salary ~ sex + wed3 + higher_educ + age + status + week_len, data3)
vif(model2)

#уровень мультиколлиниарности низкий 

summary(model2)


#2 Поэкспериментируйте с функциями вещественных параметров: используйте логарифм и степени (хотя бы от 0.1 до 2 с шагом 0.1)

describe(data3)

#для логорифмирование необходимо, чтобы значения были > 0

data3["salary"] = data3["salary"] + 1.2
data3["age"] = data3["age"] + 2.1
data3["week_len"] = data3["week_len"] + 3.3

#Строим модель с логарифмами
model3 = lm(salary ~ sex + wed3 + higher_educ + log(age) + status + log(week_len), data3)
summary(model3)

#Все регрессоры имеют высокое значеие в модели
#Попробую использовать комбинации регрессоров для построения модели 

model4 = lm(salary ~ sex + wed3 + higher_educ + age + status + week_len + I(age * week_len) + I(age^2) + I(week_len^2), data3)
summary(model4)


#комбинации с week_len и wed3 имеют низкий приоритет, исключаем их
model5 = lm(salary ~ sex +  higher_educ + age + status + week_len + I(age^2), data3)
summary(model5)

#После исключения комбинации с week_len ничего не изменилась, как и прежде показатели модели относительно хороши 
#Построю модель на комбинациях логарифмов регрессоров
model6 = lm(salary ~ sex + higher_educ + log(age) + status + log(week_len) + I(log(age) * log(week_len)) + I(log(age)^2) + I(log(week_len)^2),data3)
summary(model6)

#Теперь снизились показатели модели, а так же влияние комбинации с log(age) и I(log(age) * log(week_len)) построим модель без них

model7 = lm(salary ~ sex + higher_educ  + status + log(week_len) + I(log(age)^2) + I(log(week_len)^2),data3)
summary(model7)

#Показатели модели незначительно повысились 

#Построим модель с квадратами логарифмов
model8 = lm(salary ~ sex + higher_educ + age + log(age^2)
        + status + week_len + log(week_len^2), data3)
summary(model8)

#Качество модели относительно высокое, однако значимость регрессора log(week_len^2) не высока


#3 Выделите наилучшие модели из построенных: по значимости параметров, включённых в зависимости, и по объяснённому с помощью построенных зависимостей разбросу adjusted R^2 - R^2.adj.
#1)model5: R^2=0.2011 ,(значимость параметров – максимальная ***)
#2)model7: R^2=0.1861 ,(значимость параметров – максимальная ***)
#3)model8 : R^2=0.1985, (значимость параметров – максимальная ***)
# В итоге лучшая по показателям model5

#4 Сделайте вывод о том, какие индивиды получают наибольшую зарплату


#4 Сделайте вывод о том, какие индивиды получают наибольшую зарплату
summary(model2)

#Вывод:наибольшую зарплату получает мужчина (estimate: sex > 0), с высшим образованием (estimate: higher_educ > 0),
#преимущественно женатый (estimate: wed3 < 0), однако этот показатель не вносит наибольший вклад, 
#этот мужчина примерно средних лет (estimate: age ~ 0), тем не менее обычно это не городской житель (estimate: status < 0), 
#что очень странно, т.к. в реальной ситуации у городского жителя преимущественно большая зарплата. 
#Так же у него наблюдаются переработки (estimate: duration > 0). В целом, в модели присутствуют некоторые неточности, 
#но схожести с реальностью присутствуют. 



#5 1)Городские жители, не состоявшие в браке; 2)разведенные женщины, без высшего образования

#1)Данная группа индивидов теряет в зарплате из-за того, что это городские жители (status < 0) да и ещё несостоявшие в браке (wed3 < 0) , 
#в итоге у данной группы индивидов зарплата ниже среднего

#2)Эта группа индивидов получает относительно низкую з/п из-за отсутствия высшего образования, а регрессия по зарплате говорит о том,
#что высшее образование играет значительную роль в ее размере, также зарплата снижается из-за женского пола(estimate: sex > 0),
#то что они разведены, оказывает минимальное значение на их зарплату по модели m (wed2 ~ 0)
















































