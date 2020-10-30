program Analyse5;
var
  n: Integer;

function GetF(m, v: Integer): LongInt;
begin
  if m = 0 then 	{Ph?n neo c?a hàm d? quy}
    if v = 0 then GetF := 1
    else GetF := 0
  else					{Ph?n d? quy}
    if m > v then GetF := GetF(m - 1, v)
    else GetF := GetF(m - 1, v) + GetF(m, v - m);
end;

begin
  Write('n = '); ReadLn(n);
  WriteLn(GetF(n, n), ' Analyses');
end.
