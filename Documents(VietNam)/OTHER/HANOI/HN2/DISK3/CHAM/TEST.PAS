program Cham_bai_bang_chu_ky_quac;
uses crt;
var
bangma: array['a'..'z'] of char;
sobang: array[1..5] of integer;
f,g:text;
test: char;
testnum,tongdiem,n,i: integer;
tentep,s: string;

function mahoa(y: string):string;
var s: string;
    l:integer;
begin
    s:= '';
    for l := 1 to length(y) do
        s := s + bangma[y[l]];
    mahoa := s;
end;

procedure chuanhoa(var s:string); {loaibo khoang trong}
begin
    while (pos(s,' ') > 0) do
        delete(s,pos(s,' '),1);
end;

function Kiemtra :boolean;
var m,i:integer;
    k:boolean;
    s1,s2: string;
begin
    k := true;
    while not eof(f) and k do
       begin

          readln(f,m); {doc so ten}
          writeln(m);
          s1 := '';
          for i:= 1 to m do
             begin
                readln(f,s2);
{                write(s2:15);          }
                s2:= mahoa(s2);
{                writeln('  ->  ',s2);}
                if s1 <= s2 then
                   s1:= s2
                else
                   begin
                   k := false;
                   writeln('????':20);
                   end;
             end
       end;
    kiemtra := k
end;


begin
    clrscr;
    writeln('Test bai bang chu o dat nuoc ky quac');
    writeln('************************************');
    writeln;
    sobang[1]:= 2;
    sobang[2]:= 0;
    sobang[3]:= 1;
    sobang[4]:= 2;
    sobang[5]:= 1; {so lieu lon}

    repeat
       write('Ban cham test so: ');
       test := readkey;    writeln(test);
       testnum := ord(test) - 48;
    until (test >= '1') and (test <= '5');
    writeln('************************************');
    writeln;
    tentep := 'tudien.in'+ test;
    assign(f,tentep); Reset(f);
    assign(g, 'tudien.out');
    {$I-}
    Reset(g);
    {$I+}
  if IOResult <> 0 then
   begin
       Writeln('Khong tim thay tep tudien.out. 0 diem');
       tongdiem := 0;
    end
 else
    begin
       readln(g,n);
       if sobang[testnum] = n then
            begin
                writeln('Dung so luong nghiem, duoc 2 diem');
                tongdiem := 2;
                if n > 0 then {co nghiem}
                  begin {lap bang ma}
                    readln(g,s);
                    chuanhoa(s);  {xoa bo khoang trong}
                    for i:= 1 to length(s) do
                        bangma[s[i]]:= chr(96+i);
                    if kiemtra then
                        begin
                            writeln('Dung thu tu, duoc them 3 diem');
                            tongdiem:= tongdiem + 3
                        end
                    else
                        writeln('Thu tu kiem tra sai');
                 end
              end
         else
             writeln('Sai so luong bang');

       writeln('Diem tong cong = ',tongdiem);
       erase(g);
    end;
    readln;
end.


