uses crt;
var a:array[0..250,0..250] of byte;
    n:byte;

procedure  xuat;
var i:byte;luu,min:integer;
begin
 min:=250;
 for i:=1 to n do
  begin
    if (a[i,n]>0) and (a[i,n]<min) then begin min:=a[i,n];luu:=-i;end;
    if (a[n,i]>0) and (a[n,i]<min) then begin  min:=a[n,i];luu:=i;end;
   end;
   writeln(min);
end;

procedure xuli;
var    i,j:byte;
begin
 fillchar(a,sizeof(a),0);
 for i:=1 to n do  begin  a[i,1]:=i-1;a[1,i]:=i-1;end;
 for i:=1 to n do
  for j:=1 to n do
   if i<>j then
    begin
    if (i>j) and (a[i-j,j]>0) then a[i,j]:=a[i-j,j]+1;
    if (i<j) and (a[i,j-i]>0) then a[i,j]:=a[i,j-i]+1;
    end;
end;

begin  clrscr;
 write('n=');
 readln(n);
 xuli;
 xuat;
 readln
end.
