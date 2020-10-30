const
     fi1='td1.inp';
     fi2='td2.inp';
     fo='td.out';
type
    tg=record
     x,y:longint;
    end;
var
   f,g:text;
   n:longint;
   mt:boolean;
   m1,m2:longint;g11,g12,g21,g22:longint;
   td:array[1..60,1..60] of tg;
function ucln(a,b:longint):longint;
var
   c,d:longint;
begin
     c:=a;
     while c>0 do begin d:=c;c:=b mod c;b:=d;end;
     ucln:=b;
end;

procedure nhap;
var
   i,j,u,v:longint;x,y,z:longint;
begin
     for u:=1 to 60 do
      for v:=1 to 60 do
       if u=v then
       begin
            td[u,u].x:=1;
            td[u,u].y:=1;
       end
       else
       begin
            td[u,v].x:=0;
            td[u,v].y:=0;
       end;
       assign(f,fi1);
       reset(f);
       n:=0;
       mt:=false;
       while not(seekeof(f)) do
       begin
            readln(f,u,v,x,y);
            if td[u,v].x*y<>td[u,v].y*x then
            begin
                 m1:=u;
                 m2:=v;
                 g11:=x;
                 g12:=y;
                 g21:=td[u,v].x;
                 g22:=td[u,v].y;
                 mt:=true;
                 close(f);
                 exit;
            end;
            z:=ucln(x,y);
            td[u,v].x:=x div z;
            td[u,v].y:=y div z;
            td[v,u].x:=y div z;
            td[v,u].y:=x div z;
            if u>n then n:=u;
            if v>n then n:=v;
      end;
      close(f);
end;

function khong(a:tg):boolean;
begin
     khong:=(a.x=0)and(a.y=0);
end;

function kk(a:tg):boolean;
begin
     kk:=(a.x<>0);
end;

procedure floyld;
var
       i,j,k:longint;
   w,x,y,z,t:longint;
begin
     for k:=1 to n do
      for i:=1 to n do
       for j:=1 to n do
        begin
             if kk(td[i,k]) and kk(td[k,j]) then
             begin
                  x:=td[i,k].x;
                  y:=td[i,k].y;
                  z:=td[k,j].x;
                  t:=td[k,j].y;
       {x*z hang i doi t*y hang j}
                 if kk(td[i,j]) and(x*z*td[i,j].y<>t*y*td[i,j].x) then
                 begin
                      m1:=i;
                      m2:=j;
                      g11:=x*z;
                      g12:=y*t;
                      g21:=td[i,j].x;
                      g22:=td[i,j].y;
                      mt:=true;
                      exit;
                 end
                 else if khong(td[i,j]) then
                 begin
                      w:=ucln(x*z,y*t);
                      td[i,j].x:=(x*z) div w;
                      td[i,j].y:=(t*y) div w;
                 end;
          end;
    end;
end;

procedure ghi;
var
   x,y,z:longint;
begin
     writeln(g,0);
     assign(f,fi2);
     reset(f);
     while not(seekeof(f)) do
      begin
           readln(f,x,y);
           if (td[x,y].x<>0)and(td[x,y].y<>0) then z:=ucln(td[x,y].x,td[x,y].y)
           else z:=1;
           writeln(g,td[x,y].x div z :10,td[x,y].y div z :10);
      end;
      close(f);
end;
procedure xet;
begin
     assign(g,fo);
     rewrite(g);
     if not(mt) then floyld;
     if mt then
     begin
          writeln(g,1);
          writeln(g,m1:10,m2:10,g11:10,g12:10);
          writeln(g,m1:10,m2:10,g21:10,g22:10);
          close(g);
          exit;
     end
     else ghi;
     close(g);
end;
BEGIN
     nhap;
     xet;
END.