program sinhtestmahoa_Burrows_wheeler;
const
     dl         =       'mahoa.in0';
     kq         =       'ketqua.out';
     n          =       100;
     maxn       =       100;
type
    string100   =       string[maxn];
    arr1        =       array [1..maxn] of string[maxn];
var
   a            :       arr1;
   f            :       text;
   i, j         :       integer;
   khoang       :       integer;
   s            :       string100;

procedure QuickSort(Lo, Hi: Integer);
{Sap xep day cac string a[i]}
var
   y            :       string100;
          procedure Sort(l, r: Integer);
          var
          i, j          :       integer;
          x             :       string100;
          begin
          i := l; j := r; x := a[(l+r) DIV 2];
          repeat
                while a[i] < x do i := i + 1;
                while x < a[j] do j := j - 1;
                if i <= j then
                   begin
                   y := a[i]; a[i] := a[j]; a[j] := y;
                   i := i + 1; j := j - 1;
                   end;
                until i > j;
          if l < j then Sort(l, j);
          if i < r then Sort(i, r);
          end;
begin {QuickSort};
  Sort(Lo,Hi);
end;

begin
assign(f, dl);
rewrite(f);
randomize;
a[1][0] := chr(n);
for i := 1 to n do
    begin
    khoang := random(2);
    case khoang of
         0: j := random(10) + 48;   {j la so}
         1: j := random(26) + 65;   {j la chu cai viet hoa}
         2: j := random(26) + 97;   {j la chu cai thuong}
         end;
    a[1][i] := chr(j);
    end;

s := a[1];
for i := 2 to n do
    begin
    a[i] := copy(a[i-1],2,n-1);
    a[i] := a[i] + a[i-1][1];
    end;
quicksort(1,n);
for j := 1 to n do
    if s = a[j] then break;
for i := 1 to n do write(f, a[i][n]);
writeln(f);
writeln(f, j);
close(f);

{
writeln(s);}
assign(f, kq);
append(f);
writeln(f, s);
close(f);
{}
end.