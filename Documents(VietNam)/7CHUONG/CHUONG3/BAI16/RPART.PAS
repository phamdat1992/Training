{$R+}
Uses crt;
const
    fi='Rpart.in7';
    fo='Rpart.out';
var
    a         : array[1..200,1..200] of byte;
    m, n, p, q: longint;
    sl        : longint;
    f         : text;

procedure Docfile;
var
  i, j, k: longint;
begin
    assign(f,fi); reset(f);
    readln(f,m,n , p,q);
    readln(f,k);
    fillchar(a,sizeof(a),0);
    for i:=1 to k do
      begin
        readln(f,j);
        a[ (j-1) div n +1 , (j-1) mod n + 1] := 1 ;
    end;
    close(f);
end;

function Giong(u,v:integer): boolean;
var   i, j: integer;
begin
    giong:= false;
    if (u+p-1 > m) or (v+q-1 > n) then exit;
    for i:=1 to p do
      for j:=1 to q do
        if a[i,j] <> a[ i + (u-1) , j + (v-1) ] then exit;
    giong:= true;
end;

procedure tinhtoan;
var
  i, j : integer;
begin
    sl := 0;
    for i:=1 to m do
      for j:=1 to n do
        if Giong(i,j) then inc(sl);
end;

procedure inkq;
begin
   assign(f,fo); rewrite(f);
   writeln(f,sl);
   close(f);
end;

BEGIN
    Docfile;
    Tinhtoan;
    Inkq;
END.