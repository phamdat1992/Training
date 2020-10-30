uses crt;
var a,luu:array[1..10000] of word;
    f,f1:text;
    contro,tong,n,dem:word;
    dk:array[1..1000] of boolean;
    fb:array[0..10000] of word;

procedure readfile;
var i:word;
begin
 tong:=0;contro:=0;
 writeln('INPUT:');
 assign(f,'ghep_go.inp');
 reset(f);
 readln(f,n);
 writeln(n);
 for i:=1 to n do
  begin
    read(f,a[i]);
    write(a[i],'  ');
    if a[i]>contro then contro:=a[i];
    inc(tong,a[i]);
  end;
  close(f);
end;

function  find:boolean;
function ok(i,j:word):boolean;
 var k:word;
 begin
   ok:=false;
   k:=j-a[i];
  while k>0 do
    begin
     if luu[k]=i then exit;
     k:=k-a[luu[k]];
    end;
    ok:=true;
  end;

 procedure init;
 begin
  fillchar(fb,sizeof(fb),0);
  fb[0]:=1;
 end;

 procedure xuat;
 var k:integer;
 begin
  k:=contro;
  while k>0 do
   begin
    inc(dem);
    dk[luu[k]]:=false;
    write(f1,a[luu[k]],'  ');
    k:=k-a[luu[k]];
   end;
   writeln(f1);
 end;

 procedure kiemtra;
 var i,j:integer;
 begin
   init;
   for i:=1 to contro do
    for j:=1 to n do
     if (a[j]<=i) and ok(j,i) and dk[j] and (fb[i-a[j]]>0) then
      if (fb[i]=0) or (fb[i]>fb[i-a[j]]+1) then
       begin
        fb[i]:=fb[i-a[j]]+1;
        luu[i]:=j;
       end;
  end;

begin
 kiemtra;
 if fb[contro]>1 then
  begin
   xuat;
   find:=true;
  end
 else find:=false;
end;

procedure xu_li;
var logic,oko:boolean;
begin
 readfile;
 while (contro<=tong) and oko do
  begin
    dem:=0;
    if tong mod contro=0 then
    begin
    rewrite(f1);
    writeln(f1,contro);
    writeln(f1,tong div contro);
    fillchar(dk,sizeof(dk),true);
    logic:=true;
    while logic and (dem<n) do
     begin
      logic:=find;
     end;
    if dem>=n then oko:=false;
    end;
    if oko then inc(contro);
  end;
end;

begin  clrscr;
assign(f1,'ghep_go.out');
xu_li;
close(f1);
end.

INPUT
30
1 1 1 1 1 2 2 2 3 3 2 2 5 2 1 4 5 2 1 4 6 3 5 4 3 2 1 4 5 6
OUTPUT
6
14
6
6
1  5
1  5
1  5
1  5
2  4
2  4
2  4
3  3
2  4
3  3
2  2  2
1  1  1  1  2

INPUT
30
1 1 2 1 2 2 2 3 3 3 2 2 5 2 1 4 5 2 1 4 6 3 5 4 3 2 1 4 5 6
OUTPUT
29
3
2  5  5  5  6  6
2  3  3  4  4  4  4  5
1  1  1  1  1  1  2  2  2  2  2  2  2  3  3  3
