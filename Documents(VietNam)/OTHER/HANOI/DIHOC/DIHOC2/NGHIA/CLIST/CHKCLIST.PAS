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

function LMod(a, b: longint): longint;
begin
    Lmod:= a mod b;
end;

procedure Cham;
begin
  diem:=0;
  assign(f,fin); reset(f);
  readln(f,n,k,l);
  for i:=1 to n do read(f,list[i]);
  read(f,x);
  close(f);
  k:=k mod n;
  l:=l mod n;
  if k>l then
      x:= (x mod n)*(k-l) mod n
  else
      x:= - (x mod n)*(l-k) mod n;
  k:=0;
  for i:=1 to n do
  begin
    r:= (i+x) mod n;
    if r<=0 then r:=r+n;
    if r>n then r:= r-n;
    k:=k+1;
    listds[k]:=list[r];
  end;
  assign(f, fou); reset(f);
  for i:=1 to n do read(f,list[i]);
  close(f);
  writeln; writeln;
  for i:=1 to n do
    if Listds[i]<>List[i] then
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
