const b=1;
const a=1;
var x0,xk,h,x,f:real;
begin

writeln('������� ������ ��������� x0 ');
readln(x0);
writeln('������� ����� ��������� xk');
readln(xk);
writeln('������� ��� h');
readln(h);
writeln('������� �������� ������� ������� ');
writeln('�� ��������� [',x0,';',xk,'] � ����� ',h);
writeln('---------------');
writeln('|  x  |  f(x) |');
writeln('---------------');

while x0 <= xk do
begin
 if x0<-2 then f:=(cos(x0)/sin(x0))+a*sqrt(abs(x0+2))
 else if x0=-2 then f:=((exp(ln(a)*2))-(exp(ln(b)*2)))*cos(Pi)
 else f:=(exp(ln(x0-2)*3))*sin(pi*x0/2);
 writeln('|',x0:5:2,'|',f:7:3,'|');
 x0:=x0+h;
end;
writeln('---------------');
end.