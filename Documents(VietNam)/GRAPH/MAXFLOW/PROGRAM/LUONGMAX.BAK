{Cho do thi co huong G=(V,E) co huong ,trong so nguyen khong am
voi hai dinh nguon S va dich T.
Hay tim luong cuc dai tren mang
INPUT: FL.INP
N S T
i1 j1 c1  (i1 noi den j1 trong so c1)
i2 j2 c2
.......
OUT: FL.OUT
-Gia tri luong max
-Matran gia tri
Thuat toan: (phuong an don gian)
begin
 khoi tao luong f=0;
 stop:=false;
 while not stop do
    begin
        timduongtangluong;
        if timthay then tangluong them 1 theo duong tang luong
        else stop:=true;
    end;
end.
 }

program thu;
uses crt;
const fi='lm.inp';
      fo='fl.out';
var a,c,f1:array[1..100,1..100]of integer;
    b:array[1..100]of boolean;
    pred:array[1..100]of integer;
    n,s,t,val:integer;
    find:boolean;

procedure ddl;
var i,j,m:integer;
    f:text;
begin
   assign(f,fi);
   reset(f);
   readln(f,n,s,t);
   while not eof(f) do
        begin
           readln(f,i,j,m);
           a[i,j]:=1;
           c[i,j]:=m;
        end;
    fillchar(f1,sizeof(f1),0);
    val:=0;
end;

procedure inkq;
var i,j:integer;
f:text;
begin
   {writeln('gia tri max cua luong:',val:3);
   writeln('luong cuc dai la:');
   for i:=1 to n do
      begin
         for j:=1 to n do
           write(f1[i,j]:3);
           writeln;
      end;
   fillchar(f1,sizeof(f1),0);}
   assign(f,fo); rewrite(f);
   writeln(f, val);
   for i:=1 to n do
     begin
       for j:=1 to n do
       write(f,f1[i,j]:3);
       writeln(f);
     end;
     close(f);
end;

procedure timduong;
var  queue:array[1..100]of integer;
     top,last,i,j,p:integer;
begin
  find:=false;top:=1;
  last:=1;queue[1]:=s;
  b[s]:=false;pred[s]:=0;
   while (top<=last) do
      begin
        p:=queue[top];inc(top);
        for i:=1 to n do
         if (b[i]) then
           begin
            if (f1[p,i]<c[p,i]) then
              begin
                inc(last);b[i]:=false;
                pred[i]:=p;queue[last]:=i;
                if i=t then begin find:=true;exit;end;
              end;
            if (f1[i,p]>0) and (c[i,p]>0) then
              begin
                inc(last);b[i]:=false;
                pred[i]:=p;queue[last]:=i;
                if i=t then begin find:=true;exit;end;
              end;
           end;
      end;
end;

procedure tangluong;
var u,v:integer;
begin
  u:=t;
  while u<>s do
       begin
          v:=u;
          u:=pred[u];
          if f1[u,v]<c[u,v] then inc(f1[u,v]);
          if f1[v,u]>0 then dec(f1[v,u]);
       end;
end;

procedure xuli;
var st:boolean;
    i:integer;
begin
  st:=false;
  while not st do
     begin
        fillchar(b,sizeof(b),true);
        timduong;
        if find then tangluong
         else st:=true;
     end;
   for i:=1 to n do val:=val+f1[s,i];
   inkq;
end;
BEGIN
     clrscr;
     ddl;
     xuli;
     readln
END.
