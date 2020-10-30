uses crt;
const  fi='disrec.in421p';
       fo='disrec.out';
var    m,n,l,x,y:longint;
       f:text;

procedure  readfile;
begin
      assign(f,fi);
      reset(f);
         readln(f,m,n,l);
         readln(f,x,y);
      close(f);
end;

procedure  process1(i:integer);
var u,v,d:longint;
begin

      u:=x;v:=y+i;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u,'  ',v);
            dec(u);
            inc(d);
      until d>m+l-i;
      u:=x;v:=y+i;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u,'  ',v);
            inc(u);
            inc(d);
      until d>l-i+1;

      u:=x;v:=y-i;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u-m,'  ',v-n);
            dec(u);
            inc(d);
      until d>l-i;
      u:=x;v:=y-i;
      d:=1;
      repeat
            if ( u mod m= 0) and (v mod n=0) then writeln(f,u-m,'  ',v-n);
            inc(u);
            inc(d);
      until d>m+l-i+1;


      u:=x+i;v:=y;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u,'  ',v);
            dec(v);
            inc(d);
      until d>l-i+1;
      u:=x+i;v:=y;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u,'  ',v);
            dec(v);
            inc(d);
      until d>n+l-i+1;

      u:=x-i;v:=y;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u-m,'  ',v-n);
            dec(v);
            inc(d);
      until d>l-i+1;
      u:=x-i;v:=y;
      d:=1;
      repeat
            if ( u mod m=0) and (v mod n=0) then writeln(f,u-m,'  ',v-n);
            inc(v);
            inc(d);
      until d>n+l-i+1;
end;

procedure process;
var  i,j:longint;
begin
      for i:=x-m to x do
        for j:=y-n to y do
          if (i mod m=0) and (j mod n=0) then writeln(f,i,'  ',j);
end;

procedure process2;
var  i:integer;
begin
     for i:=1 to l do process1(i);
end;

procedure  writefile;
begin
     assign(f,fo);
     rewrite(f);
       process;
       process2;
     close(f);
end;

begin  clrscr;
  readfile;
  writefile;
end.
3 2 2
4 3