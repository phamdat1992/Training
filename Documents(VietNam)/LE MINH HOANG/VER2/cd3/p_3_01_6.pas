program Analyse6;
const
  max = 100;
var
  n: Integer;
  F: array[0..max, 0..max] of LongInt;

function GetF(m, v: Integer): LongInt;
begin
  if F[m, v] = -1 then		{N?u F[m, v] chua bi?t th� di t�nh F[m, v]}
    begin
      if m = 0 then 	{Ph?n neo c?a h�m d? quy}
        if v = 0 then F[m, v] := 1
        else F[m, v] := 0
      else					{Ph?n d? quy}
        if m > v then F[m, v] := GetF(m - 1, v)
        else F[m, v] := GetF(m - 1, v) + GetF(m, v - m);
    end;
  GetF := F[m, v];				{G�n k?t qu? h�m b?ng F[m, v]}
end;

begin
  Write('n = '); ReadLn(n);
  FillChar(f, SizeOf(f), $FF); {Kh?i t?o m?ng f b?ng gi� tr? -1}
  WriteLn(GetF(n, n), ' Analyses');
end.
