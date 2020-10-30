uses crt;
const fi='netconf.inp';
      fo='netconf.out';
var q:array[1..30000] of integer;
    n,i,j,u:integer;
    f1,f2:text;
    l:longint;
    timenow:longint absolute 00:$46c;
    timesave:longint;

procedure chuanbi;
begin
     fillchar(q,sizeof(q),0);
     l:=0;
     assign(f1,fi);reset(f1);
     readln(f1,n);
     assign(f2,fo);rewrite(f2);
end;

procedure baocao(j:integer);
var k,s1,s2:integer;
begin
     s2:=0;
     if q[j]<>0 then

        for k:=1 to n do

            if q[k]=-q[j] then inc(s2);

     s1:=0;
     if q[j]<>0 then

        for k:=1 to n do

            if q[k]=q[j] then inc(s1);

     if s1>0 then s1:=s1-1;

     writeln(f2,l,' ',j,' ',s1,' ',s2);
end;

procedure hoalop(a,b:integer);
var k:integer;
begin
     for k:=1 to n do
     begin
          if q[k]=b then q[k]:=-a;
          if q[k]=-b then q[k]:=a;
     end;
end;

procedure xuli(i,j:integer);
begin
     if(q[i]=0)and(q[j]=0)then
     begin
          inc(u);
          q[i]:=u;
          q[j]:=-u;
     end;

     if(q[i]<>0)and(q[j]=0)then q[j]:=-q[i];

     if(q[i]=0)and(q[j]<>0)then q[i]:=-q[j];

     if(q[i]<>0)and(q[j]<>0)
     and(abs(q[i])<>abs(q[j]))then hoalop(q[i],q[j]);
end;

procedure ketthuc;
begin
     close(f1);close(f2);
end;

procedure sinhtest;
var i,j,k:integer;
    f:text;
begin
     assign(f,fi);rewrite(f);
     n:=15000;
     writeln(f,n);

     for i:=1 to n do
     begin
          j:=random(1000);
          k:=random(1000);

          if random(10)=10 then writeln(f,0,' ',j)
          else
          writeln(f,j,' ',k);

     end;

     close(f);
end;
           {
begin
       sinhtest;
end.
      }
BEGIN
     timesave:=timenow;
     clrscr;
     chuanbi;
     while not eof(f1) do
     begin
          inc(l);
          readln(f1,i,j);
          if i=0 then baocao(j)
          else xuli(i,j);
     end;
     ketthuc;
     writeln('Time Run : ',(timenow-timesave)/18.21:10:10);
END.
