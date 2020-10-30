program TongtroVer2;
uses crt;
{ Dung cach trien khai de quy }
var
n,k:integer;
gtdientro: array[char] of real;
s:string;
kitu,dientro :char;
f :text;
het:boolean;

procedure Dockt;
begin
    if k <= length(s) then
       begin
          kitu := s[k];
          inc(k)
       end
    else
       het := true;
end;

procedure Nhap;
var i :integer;
begin
     assign(f,'tongtro.inp');
     reset(f);
     readln(f,s);
     readln(f,n);
     for i:=1 to n do
     readln(f, dientro, gtdientro[dientro]);
     k := 1;
     Dockt;
     clrscr;
end;

function Mach:real;
var r1,r2 : real; dau : char;
begin
     if het then exit;
     case kitu of
     'A'..'z' :
         begin
            mach := gtdientro[kitu];

         end;
     '(':begin
            if not het then
                dockt
            else
                exit;
            r1:= mach;
            dau := kitu;
            if not het then
                dockt
            else
                exit;
            r2 := mach;
            case dau of
            '*' : mach := r2 + r1;
            '+' : mach := 1 / (1/r1 + 1/r2);
            else
                begin
                     writeln('Sai cu phap - dau phep toan =', dau);
                     halt
                 end
            end;
         end;
     else
         begin
             writeln('Loi cu phap - ki tu la');
             halt
         end
     end;
     if not het then  {Lenh nay de tra loi diem tiep can cho xu ly tiep theo}
         dockt
     else
        exit

end;


begin
     Nhap;
     Write('Tong tro cua mach dien la: ',Mach:10:4);
     readln;
end.