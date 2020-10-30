{$R+}
uses crt;
const
     fhs='value.out';
     fi='value.in1';
     fo='value.out';
     nhan:array['a'..'c','a'..'c'] of char
     =(('b','b','a'),
       ('c','b','a'),
       ('a','c','c'));
var
   a,b,c:array[1..1000] of char;kt:char;
   d,m,n:word;f,g,h:text;s:longint;
function chu(c:char):boolean;
begin
chu:=(c<='c')and(c>='a');
end;
function ngoac(c:char):boolean;
begin
ngoac:=(c='(')or(c=')')
end;
function hl(c:char):boolean;
begin
hl:=chu(c) or ngoac(c);
end;
procedure cham;
var
   i,j:word;con:boolean;
begin
j:=0;
for i:=1 to n do if ('a'<=b[i])and(b[i]<='c') then
    begin
    inc(j);
    if a[j]<>b[i] then begin writeln('Ket qua sai: khong trung voi xau ban dau!!!');exit;end;
    end;
repeat
con:=false;
for i:=1 to n do if ')'=b[i] then begin con:=true;break;end;
if con then
   begin
   if (i<=3)or(b[i-3]<>'(') then
      begin writeln('Ket qua sai: so dau ngoac khong khop!!!');exit;end;
   if not(chu(b[i-2])) or not(chu(b[i-1])) then
      begin writeln('Ket qua sai: giua hai dau ngoac khong la chu!!!');exit;end;
   b[i-3]:=nhan[b[i-2],b[i-1]];n:=n-3;
   if n>=2 then for j:=i-2 to n do b[j]:=b[j+3];
   end;
until n<=2;
if n=2 then
   begin
   if not(chu(b[1])) or not(chu(b[2])) then
      begin writeln('Ket qua sai: hai ky tu rut gon cuoi cung khong la chu!!!');exit;end;
   if nhan[b[1],b[2]]<>'a' then begin writeln('Ket qua sai!!!');exit;end
   else begin writeln('Ket qua dung!!!');exit;end;
   end;
if n=1 then
   if b[1]<>'a' then begin writeln('Ket qua sai!!!');exit;end
   else writeln('Ket qua dung!!!');
end;
procedure nhap;
begin
assign(f,fi);reset(f);

assign(g,fhs);reset(g);
assign(h,fo);reset(h);
while not(seekeof(f)) do
      begin
      m:=0;
      while not(eoln(f)) do
            begin
            inc(m);read(f,a[m]);
            end;
      readln(f);
      read(h,kt);readln(h);
      n:=0;s:=0;
      while not(eoln(g)) do
            begin
            inc(n);read(g,b[n]);
            if ((kt='0')and(b[1]<>'0'))or((kt<>'0')and(b[1]='0')) then
               begin writeln('Ket qua sai');s:=0;break;end;
            if (kt='0')and(b[1]='0') then
               begin writeln('Ket qua dung!!!');break;end;
            if not(hl(b[n])) then
               begin writeln('Ket qua sai: ky tu khong hop le!!!');s:=0;break;end;
            if b[n]='(' then inc(s);
            if b[n]=')' then dec(s);
            end;
      readln(g);
      while b[n]=' ' do dec(n);
      if s<>0 then writeln('Ket qua sai: so dau ngoac khong khop!!!')
      else
          if (kt<>'0')and(b[1]<>'0') then cham;
      end;
close(f);close(g);close(h);erase(g);
end;
BEGIN
clrscr;nhap;readln;
END.