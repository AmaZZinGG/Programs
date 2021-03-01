var
S,y,x0,xk,x,h,eps,elem,n,factorial : real;
begin
   eps := 0.00001;
   
   
   write('ВВЕДИТЕ x0: ');
   read(x0);
   
   write('ВВЕДИТЕ xk: ');
   read(xk);
   
   write('ВВЕДИТЕ h: ');
   read(h);
   
   x:=x0;
   
   writeln(' x        S           y ');
   
   while x <= xk do begin
        // Вычисляем сh на данном шаге, вычислаем по известной формуле
        y := (exp(x)+exp(-x))/2;
        
        n:= 0;
        S:= 0;
        factorial := 1;
        Repeat 
          elem := power(x,2*n)/factorial;
          S := S + elem;
          n := n+1;
          factorial := factorial*(2*n)*(2*n+1);
        // Вычисляем S пока |Sn - Sn+1|>eps 
        until abs(elem) < eps;
        
        
        writeln(x, '      ',S,'        ',Y);
        //следующий шаг
        x := x + h;
    end;
  
end.