const   fi='netconf.inp';
        fo='netconf.out';

var a:array[1..30000] of integer;
    u,i0,j0,l0,sl1,sl2,n:longint;
    f,f1:text;
    time1:longint;
    time2:longint absolute 0:$46c;

procedure  mofile;
begin
     assign(f,fi);
     reset(f);
     assign(f1,fo);
     rewrite(f1);
end;

procedure  dongfile;
begin
      writeln('Time Run :' ,(time2-time1)/18.21:5:3);
      close(f);
      close(f1);
end;

procedure  khoitao;
begin
      time1:=time2;
      fillchar(a,sizeof(a),0);
      u:=0;
      l0:=0;
end;

procedure  baocao;
var  i:longint;
begin
       sl1:=0;sl2:=0;
       if a[j0]<>0 then
         for i:=1 to n do
           begin
                 if a[j0]=-a[i] then inc(sl2);
                 if a[j0]= a[i] then inc(sl1);
           end;
      if sl1>0 then dec(sl1);
      writeln(f1,l0,'  ',j0,'  ',sl1,'  ',sl2);
end;

procedure  hoanhap;
var  i,u,v:longint;
begin
     u:=a[i0];
     v:=a[j0];
     for i:=1 to n do
      begin
            if   a[i]= u then a[i]:=-v;
            if   a[i]=-u then a[i]:=v;
      end;
end;

procedure  xuliquanhe;
begin
      if (a[i0]=0) and (a[j0]=0) then
         begin
                inc(u);
                a[i0]:=u;
                a[j0]:=-u;
         end;
     if (a[i0]<>0) and (a[j0]=0) then a[j0]:=-a[i0];
     if (a[j0]<>0) and (a[i0]=0) then a[i0]:=-a[j0];
     if (a[i0]<>0) and (a[j0]<>0) and (abs(a[i0])<>abs(a[j0]))  then  hoanhap;
end;

procedure  docfile;
begin
      mofile;
      khoitao;
      readln(f,n);
      while not eof(f) do
        begin
             inc(l0);
             readln(f,i0,j0);
             case i0 of
               0:baocao
               else xuliquanhe;
             end;
        end;
      dongfile;
end;

procedure  test;
var  i,m,n,j,i1:longint;
begin
       assign(f,fi);
       rewrite(f);
       n:=15000;
       writeln(f,n);
       m:=200000;
       randomize;
       for i1:=1 to m do
         begin
              i:=random(15000);
              j:=random(15000)+1;
              writeln(f,i,'  ',j);
         end;
      close(f);
end;

begin
{
test
end.
 }
     docfile;
end.

5
1 3
5 2
2 4
4 5
0 2
1 4
1 2
0 4