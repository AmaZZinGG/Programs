function Min(const x, y: Real): Real;// ������� Min ����������� ���������� �� ���� ����������
begin
    if (x < y)
    then
        Result := x
    else
        Result := y;
    Min := Result;
end;
function Max(const x, y: Real): Real;// ������� Max ����������� ���������� ����� �� ���� ����������
begin
    if (x > y)
    then
        Result := x
    else
        Result := y;
    Max := Result;
end;
var
    x, y, z, d: Real;
begin
    Write('x='); ReadLn(x);
    Write('y='); ReadLn(y);
    Write('z='); ReadLn(z);
    Write('d='); ReadLn(d);
    WriteLn('Result=',  Min(Min(Max(x, y), Max(x, z)), Max(z, d)));
end.