const
     fi='input.tx2';
     fo='output.txt';
var
   n:word;
   s1,s2,s3,s:word;
   td:array[1..10000,1..2] of word;
   a:array[1..1000] of byte;
   f:text;
procedure nhap;
var
   x:byte;
begin
assign(f,fi);reset(f);
readln(f,n);
s1:=0;s2:=0;s3:=0;n:=0;
while not(seekeof(f)) do
      begin
      readln(f,x);inc(n);
      a[n]:=x;
      case x of
      1:inc(s1);
      2:inc(s2);
      end;
      end;
inc(s2,s1);
close(f);
end;

procedure lam;
var
   i,j,k:word;t:byte;co:boolean;
begin
s:=0;
for i:=1 to s1 do
 begin
    if a[i]=2 then
	   for j:=s1+1 to s2 do
           if a[j]=1 then
           begin
                inc(s);
                td[s,1]:=i;
                td[s,2]:=j;
                t:=a[i];
                a[i]:=a[j];
                a[j]:=t;
                break;
           end;
    if a[i]=3 then
       for j:=s2+1 to n do
           if a[j]=1 then
           begin
                inc(s);
                td[s,1]:=i;
                td[s,2]:=j;
                t:=a[i];
                a[i]:=a[j];
                a[j]:=t;
                break;
           end;
 end;

for i:=s1+1 to s2 do
    if a[i]=3 then
       for j:=s2+1 to n do
           if a[j]=2 then
           begin
                inc(s);
                td[s,1]:=i;
                td[s,2]:=j;
                t:=a[i];
                a[i]:=a[j];
                a[j]:=t;
                break;
           end;

for i:=1 to s1 do
    begin
         if a[i]=2 then
            begin
            for j:=s1+1 to s2 do
                if a[j]=3 then break;
            for k:=s2+1 to n do if a[k]=1 then
            begin
                 inc(s);
                 td[s,1]:=i;
                 td[s,2]:=k;

                 t:=a[i];
                 a[i]:=a[k];
                 a[k]:=t;

                 inc(s);
                 td[s,1]:=j;
                 td[s,2]:=k;
                 t:=a[j];
                 a[j]:=a[k];
                 a[k]:=t;
                 break;
            end;
       end;
    if a[i]=3 then
       begin
            for j:=s1+1 to s2 do
                if a[j]=1 then break;
            for k:=s2+1 to n do
                if a[k]=2 then
                begin
                     inc(s);td[s,1]:=i;td[s,2]:=j;t:=a[i];a[i]:=a[j];a[j]:=t;
                     inc(s);td[s,1]:=j;td[s,2]:=k;t:=a[j];a[j]:=a[k];a[k]:=t;break;
                end;
       end;
    end;
end;

procedure viet;
var
   i:word;
begin
assign(f,fo);rewrite(f);
writeln(f,s);
for i:=1 to s do writeln(f,td[i,1]:8,td[i,2]:8);
close(f);
end;
BEGIN
nhap;lam;viet;
END.