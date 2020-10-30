(*  Solving the problem DETAILS  *)
uses crt;
const
   fin: string = 'DETAILS.IN9';
   fou: string = 'DETAILS.OUT';
type
    arr1d = array[1..200] of integer;
var
   a: array[1..200] of ^arr1d;
   tho, viec, truoc: arr1d;
   lich: arr1d;
   k,m,n,x0,y0,max:integer;
   i, ttest, tmin, tmax, topt: integer;
   PathFound, stop: boolean;
   f: text;

procedure Sinh;
var i, j:integer;
begin
    randomize;
    write(' Cho n = ');readln(n);
    assign(f,fin); rewrite(f);
    writeln(f,n);
    for i:=1 to n do
    begin
        for j:=1 to n-1 do
        begin
            a[i]^[j]:= random(2000)+random(3000)+5;
            write(f,a[i]^[j],' ');
        end;
        writeln(f, a[i]^[n]);
    end;
    close(f);
end;


procedure Nhapdl;
var i, j: integer;
begin
    assign(f, fin); reset(f);
    readln(f, n);
    for i:=1 to n do
       for j:=1 to n do
       begin
           read(f, a[i]^[j]);
       end;
    close(f);
{    writeln(' MA TRAN THOI GIAN n = ',n);
    for i:=1 to n do
    begin
        for j:=1 to n do write(a[i]^[j]:2);
        writeln;
    end;
}
end;

procedure Tang;
var   t,x,y:integer;
begin
    max:=max+1;
    y:=y0;
    while truoc[y]<>x0 do
    begin
        x:=truoc[y];
        tho[y]:=x;
        t:=viec[x];
        viec[x]:=y;
        y:=t;
    end;
    tho[y]:=x0; viec[x0]:=y;
end;


procedure FindPath(x:integer);
var y:integer;
begin
    for y:=1 to n do
       if (truoc[y]=0) and (a[x]^[y] <= ttest) then
       begin
           truoc[y]:=x;
           if tho[y]=0 then
           begin
               y0:=y;
               Pathfound:=true;
               exit;
           end
           else FindPath(Tho[y]);
           if PathFound then exit;
       end;
end;

procedure Matching;
var x,y:integer;
begin
    for x:=1 to n do Viec[x]:=0;
    for y:=1 to n do Tho[y]:=0;
    max:=0;
    stop:=false;
    while not stop do
    begin
        PathFound:=false;
        for y:=1 to n do truoc[y]:=0;
        x:=1;
        while not Pathfound and (x<=n) do
        begin
           if viec[x]=0 then
           begin
               x0:=x;
               FindPath(x);
           end;
           x:=x+1;
        end;
       if pathfound then Tang else stop:=true;
    end;
end;

procedure Inkq;
var x,i,j:integer;
begin
    assign(f, fou); rewrite(f);
    writeln(f, topt);
    for i:=1 to n-1 do write(f, lich[i],' ');
    writeln(f, lich[n]);
    close(f);
end;


BEGIN
    for i:=1 to 200 do new(a[i]);
{    Sinh; exit;}
    Nhapdl;
{    writeln('Initialization is success'); readln;}
    (*  Tim can tren  *)
    for i:=1 to n do lich[i]:=i;
    tmax:=0;
    for i:=1 to n do
       if tmax< a[i]^[lich[i]] then tmax:=a[i]^[lich[i]];
    topt:= tmax;
    tmin:=0;

    repeat
       ttest:= (tmax+tmin) div 2;
       if ttest<tmax then
       begin
          Matching;
          if max=n then
          begin
             lich:=viec;
             tmax:=0;
             for i:=1 to n do
                if tmax < a[i]^[lich[i]] then tmax:=a[i]^[lich[i]];
             topt:= tmax;
          end
          else tmin:= ttest;
       end;
    until tmax-tmin<=1;
    Inkq;
END.

