(*  Cham bai CLIST *)
uses crt;
const
   fin: string = 'CLIST.INP';
   fou: string = 'CLIST.OUT';
var
   list, ListDS: array[0..200] of integer;
   a,b,c: longint;
   f: text;
   x, n, k, l, i, ofs, r: longint;
   chon: char;
   diem: integer;

procedure Solve;
var
    ct, i, j, u : longint;
begin
    k := k mod n;
    l := l mod n;
    u := k - l;
    x := x  mod n;
    x := (x * abs(u)) mod n;
    ct := 1;
    if u > 0 then
      ct := (ct + x) mod n
    else
    begin
        ct := ct - x;
        if ct <= 0 then ct := ct + n;
    end;
    if ct = 0 then ct := n;
    j:=1;
    for i := ct to n do
    begin
         listds[j]:=list[i];
         j:=j+1;
    end;
    for i := 1 to ct - 1 do
    begin
         listds[j]:=list[i];
         j:=j+1;
    end;
end;

procedure Cham;
begin
   diem:=0;
   assign(f,fin); reset(f);
   readln(f,n,k,l);
   for i:=1 to n do read(f,list[i]);
   read(f,x);
   close(f);
   Solve;
   assign(f, fou); reset(f);
   for i:=1 to n do read(f,list[i]);
   close(f);
   writeln; writeln;
   for i:=1 to n do
     if List[i]<>Listds[i] then
     begin
         writeln('?????????????????????????????????????');
         writeln('             E R R O R !');
         writeln('?????????????????????????????????????');
         exit;
     end;
   diem:=1;
   writeln('*************************************');
   writeln('          C O R R E C T !');
   writeln('*************************************');
end;


BEGIN
   clrscr;
   writeln('                   CHUONG TRINH CHAM BAI: CLIST');
   writeln('                   ============================');
   write  ('                    Cho ten file: CLIST.IN');
   chon:=readkey; writeln(chon);
   fin:='CLIST.IN'+chon;
   Cham;
   writeln; writeln;
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('                             Diem: ',diem);
   writeln('                    $$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   readln;
END.
