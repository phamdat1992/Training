uses crt;
const
     fi='km.in';
     n=100;
     m:array['0'..'9'] of word= (15000,20000,25000,30000,35000,40000,45000,
                                50000,55000,60000);
     k:array['0'..'9'] of word= (500,1000,1500,2000,2500,3000,3500,4000,4500,
                                5000);
var
   f:text;t:char;
   q1,q3,q2:array[1..5000] of word;
   i,j:word;duoc:boolean;
BEGIN
randomize;
for t:='0' to '9' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n:8,m[t]:8,k[t]:8);
    i:=1;
    q1[1]:=1+random(n);q2[1]:=1+random(m[t]);q3[1]:=1000+random(60000);
    writeln(f,q1[i]:6,q2[i]:6,q3[i]:6);
    for i:=2 to k[t] do
        begin
        repeat
        duoc:=true;q2[i]:=1+random(m[t]);
        for j:=1 to i-1 do if q2[j]=q2[i] then begin duoc:=false;break;end;
        until duoc;
        writeln(f,1+random(n):6,q2[i]:6,1000+random(60000):6);
        end;
    for i:=1 to n+1 do
        begin
        for j:=1 to n+1 do
        if i=j then write(f,0:4) else
           begin
           write(f,1+random(500):4);
           end;
        writeln(f);
        end;
    for i:=1 to n+1 do
        begin
        for j:=1 to n+1 do
        if i=j then write(f,0:6) else
           begin
           write(f,1000+random(60000):6);
           end;
        writeln(f);
        end;
    close(f);
    end;
END.