{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
const
    maxn=10000;
    fi='guest.inp';
    fo='guest.out';
type
    t_array1=array[0..maxn]of integer;
    t_array2=array[0..maxn]of longint;
var f:text;
    max:longint;
    n,first,last:integer;
    cx,loai:array[1..maxn]of boolean;
    c:array[0..maxn]of integer;
    q,vt,con,cha,bac:^t_array1;
    t:^t_array2;

procedure khoitao;
begin
   new(q);
   fillchar(q^,sizeof(q^),0);
   new(vt);
   fillchar(vt^,sizeof(vt^),0);
   new(con);
   fillchar(con^,sizeof(con^),0);
   new(cha);
   fillchar(cha^,sizeof(cha^),0);
   new(bac);
   fillchar(bac^,sizeof(bac^),0);
   new(t);
   fillchar(t^,sizeof(t^),0);
end;

procedure timcuoi;
var i,j:integer;
begin
   assign(f,fi);
   reset(f);
   readln(f,n);
   for i:=1 to n do
      begin
         readln(f,j);
         if j<>0 then inc(c[j]);
      end;
   for i:=1 to n do inc(c[i],c[i-1]);
   close(f);
end;

procedure themcon(i,j:integer);
var run:integer;
begin
   inc(bac^[i]);
   cha^[j]:=i;
   con^[c[i-1]+bac^[i]]:=j;
end;

procedure nhap;
var i,j:integer;
begin
   assign(f,fi);
   reset(f);
   readln(f,n);
   for i:=1 to n do
      begin
         readln(f,j,vt^[i]);
         if j<>0 then themcon(j,i);
      end;
   close(f);
end;

procedure add(i:integer);
begin
   inc(last);
   q^[last]:=i;
end;

function tongvuitinhcon(i:integer):longint;
var j:integer;
    tg:longint;
begin
   tg:=0;
   for j:=c[i-1]+1 to c[i] do tg:=tg+t^[con^[j]];
   tongvuitinhcon:=tg;
end;

procedure tinh(i:integer);
var j:integer;
    tg1,tg2:longint;
begin
   tg1:=tongvuitinhcon(i);
   tg2:=0;
   for j:=c[i-1]+1 to c[i] do tg2:=tg2+tongvuitinhcon(con^[j]);
   if tg1>tg2+vt^[i] then t^[i]:=tg1
   else
      begin
         t^[i]:=tg2+vt^[i];
         loai[i]:=true;
      end;
end;

procedure ditiep(i:integer);
begin
   if (cha^[i]<>0) then
      begin
         dec(bac^[cha^[i]]);
         if bac^[cha^[i]]=0 then add(cha^[i]);
      end;
   tinh(i);
end;

procedure chuanbi;
var i,dx,dem:integer;
begin
   for i:=1 to n do
      if bac^[i]=0 then add(i);
end;

procedure xuly;
begin
   while first<last do
      begin
         inc(first);
         ditiep(q^[first]);
      end;
end;

procedure laycon(i:integer);
var j:integer;
begin
   for j:=c[i-1]+1 to c[i] do add(con^[j]);
end;

procedure tim(i:integer);
var j:integer;
begin
   if loai[i] then
      for j:=c[i-1]+1 to c[i] do laycon(con^[j])
   else
      begin
         move(q^[first+1],q^[first],(last-first)*2);
         dec(last);
         laycon(i);
         dec(first);
      end;
end;

procedure inra;
begin
   while first<last do
      begin
         inc(first);
         tim(q^[first]);
      end;
end;

procedure inkq;
var i,li:integer;
begin
   assign(f,fo);
   rewrite(f);
   for i:=1 to n do
      if t^[i]>max then
         begin
            max:=t^[i];
            li:=i;
         end;
   first:=0;
   last:=0;
   add(li);
   inra;
   writeln(f,last,' ',max);
   for i:=1 to last do writeln(f,q^[i]);
   close(f);
end;

Begin
   khoitao;
   timcuoi;
   nhap;
   chuanbi;
   xuly;
   inkq;
End.