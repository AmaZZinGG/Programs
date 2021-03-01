library(lmtest)
data = mtcars


#Пункт 1

#Нормализуем данные для того, чтобы набор данных был схож с нормальным распределением:
#Вычитаем среднее значение и делим результат на его среднеквадратичное отклонение 

#Входные данные:
#mpg - объясняемая переменная. Мили/(US) галлон.
#Disp - объясняющая переменная. Перемещение.
#drat - объясняющая переменная.Коэффициент заднего моста.
#wt - объясняющая переменная. Вес.

#Сразу возьмем логарифмы каждой переменной до нормализации, а затем нормализуем отдельно.

data$Logdisp = log(data$disp)
data$Logdrat = log(data$drat)
data$Logwt = log(data$wt)

#Нормализуем данные

data$mpg = (data$mpg - mean(data$mpg))/sqrt(var(data$mpg))
data$disp = (data$disp - mean(data$disp))/sqrt(var(data$disp))
data$drat = (data$drat - mean(data$drat))/sqrt(var(data$drat))
data$wt = (data$wt - mean(data$wt))/sqrt(var(data$wt))

#Нормализуем логарифмы
data$Logdisp = (data$Logdisp - mean(data$Logdisp))/sqrt(var(data$Logdisp))
data$Logdrat = (data$Logdrat - mean(data$Logdrat))/sqrt(var(data$Logdrat))
data$Logwt = (data$Logwt - mean(data$Logwt))/sqrt(var(data$Logwt))


#Пункт 2

#Проверим гипотезу о линейной независимости наших переменных
#Для этого построим линейную регрессию между параметрами
#Оценивать будем по показателю Multiple\Adjusted R-squared (Коэффициент детерминации) 
#Это значение показывает сколько процентов данных мы смогли описать той или иной моделью 

#Построим модель зависимости пройденного расстояния от коэффициента заднего моста

modeldispdrat = lm(disp ~ drat, data)
modeldispdrat 
summary(modeldispdrat) 

#Multiple R-squared:  0.5044,	Adjusted R-squared:  0.4879 
#Коэффициент детерминации не очень большой, линейной зависимости не существует



#Построим модель зависимости коэффициента заднего моста от веса

modeldratwt = lm(drat ~ wt, data)
modeldratwt 
summary(modeldratwt) 

#Multiple R-squared:  0.5076,	Adjusted R-squared:  0.4912
#Коэффициент детерминации не очень большой, линейной зависимости не существует




#Построим модель зависимости коэффициента заднего моста от веса


modeldispwt = lm(disp ~ wt, data)
modeldispwt 
summary(modeldispwt)


#Multiple R-squared:  0.7885,	Adjusted R-squared:  0.7815 
#Коэффициент детерминации увеличился , но не превышает 0.8 , поэтому не будем выкидывать столбец

#Таким образом, мы подтверждаем гипотезу о линейной независимости переменных


#Пункт3

#Построим простую линейную модель зависимости mpg  от всех описывающих переменных 
#и оценим ее по коэффициенту детерминации и по p-критерию
#p-критерий - это вероятность ошибки при отклонении нулевой гипотезы
#(Предположения того, что линейной зависимости не существует)

model1 = lm(mpg ~ disp + drat + wt, data)
model1 #p-value - (.)()(*)
summary(model1) 
#Multiple R-squared:  0.7835,	Adjusted R-squared:  0.7603

#Результат неплох

#Пункт 4

#Введем в модель логарифмы
#Чтобы избежать взятия логарифмов от отрицательных чисел мы взяли их заранее

#Добавим логарифм от параметра Disp в модель 
model2 = lm(mpg ~ Logdisp + disp + drat + wt, data)
model2 #p-value - (***)(**)()(**)
summary(model2) #Multiple R-squared:  0.8837,	Adjusted R-squared:  0.8665   


#Добавим логарифм от параметра drat в модель 
model3 = lm(mpg ~ Logdrat + drat + disp + wt, data)
model3 #p-value - ()()(.)(*)
summary(model3) #Multiple R-squared:  0.7901,	Adjusted R-squared:  0.759   


#Добавим логарифм от параметра wt в модель 
model4 = lm(mpg ~ Logwt + wt + disp + drat, data)
model4 #p-value - (**)(.)(*)()
summary(model4) #Multiple R-squared:  0.8479,	Adjusted R-squared:  0.8254

#Лучший результат получился у модели model2

#Пункт 5

#Ввести в модель всевозможные произведения из пар регрессоров, в том числе квадраты регрессоров
#Найти одну или несколько наилучших моделей по доле объясненного разброса в данных R^2
  
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

#model8 оказалась моделью с самыми хорошими показателями




