{$R+,B-}
uses crt,dos;
  type ttlk = array [0..31] of byte;
  Const
      fhs='bl3.out';
  var
      sp:array[1..10] of string;
      f,g:text;ok1,ok2:boolean;
      phach,m,x,y,min,minhs,test:byte;gt:ttlk;
      ts1,ts2,fi,ftest:string;
      tt:array [1..10] of ttlk;
procedure nhap;
var
   s:string;
   i,j:byte;c:char;
begin
assign(f,fi);reset(f);
readln(f,m);
for i:=1 to m do readln(f,sp[i]);
close(f);
end;
function gtri (s : string):byte;
var
   i, r, l : word;
    function gtrikngoac (e : string): char;
      var p : word;
    begin
      if e[1] = '(' then delete (e, 1, 1);
      if e[length (e)] = ')' then delete (e, length (e), 1);
      p := pos ('#', e);
      while p > 0 do
        begin
          delete(e, p, 1);
          case e[p] of
            '0': e[p] := '1';
            '1': e[p] := '0';
            '#': delete (e, p, 1);
          end;
          p := pos('#', e);
        end;
      p := pos ('&', e);
      while p > 0 do
        begin
          if (e[p - 1] = '1') and (e[p + 1] = '1')
          then e[p - 1] := '1' else e[p - 1] := '0';
          delete (e, p, 2);
          p := pos ('&', e);
        end;
      p := pos ('+', e);
      while p > 0 do
        begin
          if (e[p - 1] = '0') and (e[p + 1] = '0')
          then e[p - 1] := '0' else e[p - 1] := '1';
          delete (e, p, 2);
          p := pos ('+', e);
        end;
      gtrikngoac := e[1];
    end;
begin
    while length (s) > 1 do
      begin
      r := pos (')', s);
      if r = 0 then begin r := length (s);l:= 1;end
      else
          begin
          l := r;
          while s[l] <> '(' do dec(l);
          end;
      s[l] := gtrikngoac(copy( s, l, r - l + 1));
      delete (s, l + 1, r - l);
      end;
    if s[1]='1' then gtri:=1 else gtri:=0;
end;
function lt(k:byte):byte;
var
   i,tam:byte;
begin
if k=0 then begin lt:=1;exit;end;
tam:=1;
for i:=1 to k do tam:=tam*2;
lt:=tam;
end;
procedure tinhgt(s:string;var gt:ttlk);
var
a:array['a'..'h'] of char;
dem:byte;j,k:char;
   procedure sm1;
   var
      i,i1,dem1,dem2:byte;s6:string;
   begin
      s6:=s;
      for i1:=1 to length(s6) do
          if ('a'<=s6[i1])and(s6[i1]<='h') then s6[i1]:=a[s6[i1]];
      dem1:=dem div 8;dem2:=lt(dem mod 8);
      if gtri(s6)=1 then gt[dem1]:=gt[dem1] or dem2;
   end;
BEGIN
FillChar (gt, SizeOf(gt), 0);dem:=0;
Fillchar(a,sizeof(a),'0');dem:=0;sm1;
j:='h';
while j>='a' do
      begin
      j:='h';while (j>='a')and(a[j]='1') do dec(j);
      if j>='a' then
         begin
         a[j]:='1';
         if j<'h' then for k:=chr(ord(j)+1) to 'h' do a[k]:='0';
         inc(dem);
         sm1;
         end;
      end;
END;
procedure sinhmlk;
var
   i:byte;
begin
fillchar(tt,sizeof(tt),0);
for i:=1 to m do
    begin
    tinhgt(sp[i],gt);
    tt[i]:=gt;
    end;
end;
procedure cham;
var
   kq:array[1..10] of string;
   s1,s2:string;i:byte;
   procedure xet;
   var
      c:integer;so:byte;q:word;t:byte;
   begin
   q:=1;s1:=kq[i];
   while q<>0 do
   begin
   q:=pos('R',s1);val(s1[q+1],so,c);
   if q>0 then
      begin
      delete(s1,q,2);s2:='('+sp[so]+')';
      if length(s1)>0 then insert(s2,s1,q) else s1:=s2;
      end;
   end;
   tinhgt(s1,gt);
   for t:=0 to 31 do if gt[t]<>tt[i][t] then begin ok2:=false;break;end;
   end;
begin
{$I-}assign(f,fhs);reset(f);{$I+}
if ioresult<>0 then
   begin writeln('Khong co file OUT!!!');ok2:=false;close(f);exit;end
else
begin
readln(f,minhs);
for i:=1 to m do readln(f,kq[i]);
close(f);
assign(f,fhs);
erase(f);
ok2:=true;
for i:=1 to m do
    begin
    if kq[i]<>'0' then xet;
    if not(ok2) then
       begin writeln('Bieu dien linh kien ',i,' sai!!!');break;end;
    end;
end;
end;
BEGIN
clrscr;
write('Cham bai so: ');readln(phach);str(phach,ts1);
write('Cham test so: ');readln(test);str(test,ts2);
assign(g,'3'+ts1+ts2+'.txt');rewrite(g);
writeln(g,'Cham bai ',phach,' test so ',test);
fi:='bl3.in'+ts2;
ftest:='bl3.ou'+ts2;
nhap;
assign(f,ftest);reset(f);readln(f,min);close(f);
if minhs=min then ok1:=true else ok1:=false;
sinhmlk;cham;
writeln('Min cua hoc sinh: ',minhs,' - MINTEST = ',min);
writeln(g,'Min cua hoc sinh: ',minhs,' - MINTEST = ',min);
if minhs=min then ok1:=true else ok1:=false;
if ok2 and (minhs<min) and (minhs>0)
then
    begin
    writeln('Cac bieu dien deu dung!!!');
    writeln('Hoc sinh lam tot hon dap an!!!');
    end;
if ok2 and ok1 then
   begin
   writeln('Diem test ',test,' : 8,0');
   writeln(g,'Diem test ',test,' : 8,0');
   end;
if ok2 and not(ok1) and (minhs=min+1) then
   begin
   writeln('Diem test ',test,' : 3,0');
   writeln(g,'Diem test ',test,' : 3,0');
   end;
if (ok2 and not(ok1) and (minhs<>min+1))or not(ok2) then
   begin
   writeln('Diem test ',test,' : 0,0');
   writeln(g,'Diem test ',test,' : 0,0');
   end;
close(g);
readln;
END.
