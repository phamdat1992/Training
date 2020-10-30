program sinhtruyentin;
uses crt;
const
     n                  =       70;
     randomdinh         =       35;     {n div k - so dinh tren 1 duong di}
     k                  =       5;     {so duong di}
     s                  =       27;     {dinh xuat phat}
     t                  =       15;    {dinh dich}
     tg                 =       0{500};{cong them vao so}
     dl                 =       'TTin.in';  {canh cua do thi <=n*n div 4}
     kq                 =       'Tmp.ou';
     gh                 =       500;

type
    arr1                =       array [1..n, 1..n] of longint;
    arr2                =       array [1..n, 1..n] of boolean;
    arr3                =       array [1..n] of longint;
var
   c                    :       arr1;
   cx                   :       arr2;
   luu                  :       arr3;
   f, g                 :       text;
   i, j, u, v, dinh, m  :       longint;
   tong                 :       longint;
begin
assign(f, dl); rewrite(f); assign(g, kq); rewrite(g);
randomize;

fillchar(c, sizeof(c), 0);
fillchar(cx, sizeof(cx), 1);
writeln(g, k);
for i := 1 to k do
    begin
    dinh := random(randomdinh) + 3;
    fillchar(luu, sizeof(luu), 0);
    luu[1] := s;
    luu[dinh] := t;
    for j := 2 to dinh - 2 do
        begin
        repeat
              u := random(n) + 1;
              until (u <> luu[j-1]) and cx[luu[j-1],u] and (u <> t) and (u <> s);
        luu[j] := u;
        cx[luu[j-1],u] := false;
        end;
    repeat
          u := random(n) + 1;
          until cx[luu[dinh-2],u] and cx[u,t]
                and (u <> luu[dinh-1]) and (u <> t) and (u <> s);
    luu[dinh-1] :=u;
    cx[luu[dinh-2],u] := false; cx[u,t] := false;
    for j := 1 to dinh do
        write(g, luu[j], ' '); writeln(g);
    end;
m := 0;
tong := 0;
for i := 1 to n do
    for j := 1 to n do
        if not cx[i,j] then
           begin
           c[i,j] := random(gh) + 1;
           cx[i,j] := true; cx[j,i] := true; inc(m);
           tong := tong + c[i,j];
           end;
writeln(g, ' ', tong);
writeln(f, n, ' ', m + tg, ' ', s, ' ', t, ' ', k);
for i := 1 to n do
    for j := 1 to n do
        if c[i,j] <> 0 then writeln(f, i, ' ', j, ' ', c[i,j]);
for i := 1 to tg do
    begin
    repeat
          u := random(n) + 1;
          v := random(n) + 1;
          until (u <> v) and (c[u,v] = 0) and (c[v,u] = 0);
    c[u,v] := random(gh) + 1;
    c[v,u] := c[u,v];
    writeln(f, u, ' ', v, ' ', c[u,v]);
    end;
close(f); close(g);
end.