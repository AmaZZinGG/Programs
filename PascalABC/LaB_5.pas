var a,b,x,y,u:real;
begin
writeln('Введите значение аргумента x:');
readln(x);
writeln ('Введите значение аргумента y:');
readln(y);
if (sqrt(abs(x))-sqrt(abs(y))<>0) and  ((exp(ln(x)*2))-(exp(ln(y)*2))>0) and ((exp(ln(a)*2))-(exp(ln(b)*2))>1) then
begin
a:=(4-(exp(Ln(x)*2)))*(sin(x/y))/(sqrt(abs(x))-sqrt(abs(y)));
b:=ln((exp(ln(x)*2))-(exp(ln(y)*2)))+sqrt(abs(x/y));
u:= sqrt(abs(a+b));
end
else 
if (sqrt(abs(x))-sqrt(abs(y)) <> 0) and ((exp(ln(x)*2))-(exp(ln(y)*2))>0) and ((exp(ln(a)*2) - exp(ln(b)*2))<=1) then
    begin
    a:=(4-(exp(Ln(x)*2)))*(sin(x/y))/(sqrt(abs(x))-sqrt(abs(y)));
     b:=ln((exp(ln(x)*2))-(exp(ln(y)*2)))+sqrt(abs(x/y));
      u:=a+b;
end;
writeln('x=',x,' y=',y,' a=',a,' b=', b,' u=',u);
end.


//(4-exp(ln(x)*2))*sin(x/y)/(sqrt(abs(x))-sqrt(abs(y)))