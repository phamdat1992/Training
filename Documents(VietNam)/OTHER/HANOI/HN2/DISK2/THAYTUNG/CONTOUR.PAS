uses crt;
const  fi='contour.inp';
       fo='coutour.out';
var    x,y:array[0..10001] of integer;
       c:array[1..10000] of char;
       n,h,dd:integer;
       f,f1:text;

procedure  khoitao;
begin
      fillchar(x,sizeof(x),0);
      fillchar(y,sizeof(y),0);
      fillchar(c,sizeof(c),0);
end;

procedure  docfile;
var  i:longint;
begin
     assign(f,fi);
     reset(f);
       readln(f,dd);
       n:=0;
       while not eof(f) do
        begin
              inc(n);
              readln(f,x[n],y[n]);
        end;
     close(f);
end;

procedure  themdinh;
begin
      x[0]:=x[n];y[0]:=y[n];
      x[n+1]:=x[1];y[n+1]:=y[1];
end;

function  min:integer;
var i,luu:integer;
begin
      luu:=1;
      for i:=2 to n do
       if (x[i]<x[luu]) or ((x[i] =x[luu]) and (y[i]>y[luu])) then luu:=i;
      min:=luu;
end;

procedure  huong;
var  i:longint;
begin
     i:=min;
     h:=1;
     if y[i+1]>y[i] then h:=-1;
end;

procedure  mofile;
begin
     assign(f1,fo);
     rewrite(f1);
end;

procedure  dongfile;
begin
     close(f1);
end;

procedure  chuanbi;
begin
      khoitao;
      docfile;
      mofile;
      themdinh;
      huong;
end;

procedure  duongdi;
var  i:integer;
begin
      for i:=1 to n do
      begin
            if (x[i]=x[i+1]) and (y[i]>y[i+1])  then c[i]:='D';
            if (x[i]=x[i+1]) and (y[i]<y[i+1])  then c[i]:='U';
            if (y[i]=y[i+1]) and (x[i]>x[i+1])  then c[i]:='R';
            if (y[i]=y[i+1]) and  (x[i]<x[i+1])  then c[i]:='L';
      end;
end;

procedure  xuli;
var  i:longint;
begin
      for i:=1 to n do
        begin
              if (c[i]='D')  and (c[i-1]='L') then writeln(f1,x[i]+h*dd,'  ',y[i]+h*dd);
              if (c[i]='D')  and (c[i-1]='R') then writeln(f1,x[i]-h*dd,'  ',y[i]+h*dd);

              if (c[i]='U')  and (c[i-1]='R') then writeln(f1,x[i]-h*dd,'  ',y[i]-h*dd);
              if (c[i]='U')  and (c[i-1]='L') then writeln(f1,x[i]-h*dd,'  ',y[i]+h*dd);

              if (c[i]='R')  and (c[i-1]='D')  then writeln(f1,x[i]+h*dd,'  ',y[i]+h*dd);
              if (c[i]='R')  and (c[i-1]='U')  then writeln(f1,x[i]-h*dd,'  ',y[i]-h*dd);

              if (c[i]='L')  and (c[i-1]='D')  then writeln(f1,x[i]+h*dd,'  ',y[i]-h*dd);
              if (c[i]='L')  and (c[i-1]='D')  then writeln(f1,x[i]-h*dd,'  ',y[i]+h*dd);
        end;
end;

begin  clrscr;
    chuanbi;
    duongdi;
    xuli;
    dongfile;
end.

1
2 4
2 -3
-4 -3
-4 -1
-2 1
-2 4
