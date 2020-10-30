uses crt;
const  fi='poligon.inp';
       fo='poligon.out';
var    a,b:array[0..50] of integer;
       d,c:array[0..50] of longint;
       m,s,sl:longint;
        f,f1:text;

procedure  readfile;
var i:byte;
begin
     fillchar(a,sizeof(a),0);
     assign(f,fi);
	 reset(f);
         readln(f,m);
         for i:=1 to m do read(f,a[i]);
         readln(f,s);
	 close(f);
end;

procedure new(i:longint);
begin
      c[i]:=c[i]+b[i];
      d[i]:=d[i]+c[i];
end;

procedure  init1;
var i:longint;
begin
     fillchar(b,sizeof(b),0);
     for i:=1 to m do b[i]:=a[i]-2;
     fillchar(c,sizeof(c),0);
     fillchar(d,sizeof(d),0);
     for i:=1 to m do
       begin
            c[i]:=1;
            d[i]:=1;
       end;
     sl:=0;
end;

procedure  init2;
var  i:longint;
begin
      for i:=1 to m do
      while d[i]<s do new(i);
end;

procedure  chuanbi;
begin
      readfile;
      init1;
      init2;
end;

function  min:longint;
var  i,luu,mins:longint;
begin
      mins:=0;
      for i:=1 to m do
        if (mins=0) or (mins>d[i]) then
               mins:=d[i];
    min:=mins;
end;

function  demmin(mins:longint):longint;
var  i,k,dem:longint;
begin
     k:=mins;
     dem:=0;
     for i:=1 to m do
      if d[i]=k then inc(dem);
    demmin:=dem;
end;

procedure  tangmin(u:longint);
var  i:longint;
begin
     for i:=1 to m do
       if d[i]=u then
	        new(i);
end;

procedure  xuli;
var  dd,u,i:longint;
begin
      repeat
             u:=min;
             dd:=demmin(u);
             if dd>1 then
              begin
                    write(f1,u,':  ');
                    for i:=1 to m do if d[i]=u then write(f1,a[i],'  ');
                    writeln(f1);
                    inc(sl);
                    if sl>=5 then  begin close(f1);halt;end;
              end;
             tangmin(u);
      until sl>=5;
end;

procedure  main;
begin
     assign(f1,fo);
     rewrite(f1);
     chuanbi;
     xuli;
     close(f1);
end;

begin  clrscr;
     main;
end.
5
3 4 13 36 124
1