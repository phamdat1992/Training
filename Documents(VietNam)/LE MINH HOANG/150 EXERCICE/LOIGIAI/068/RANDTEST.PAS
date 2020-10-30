uses crt;
const
     n:array['0'..'9'] of word=(10,20,30,40,50,60,70,80,90,100);
     m:array['0'..'9'] of word=(30,60,90,120,150,180,210,240,270,300);
     fi='b5.in';
var
   i,u,v,w:word;t:char;f:text;
begin
randomize;
for t:='0' to '9' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n[t]:10,m[t]:10);
    for i:=1 to m[t] do
        begin
        repeat
        u:=random(n[t])+1;v:=random(n[t])+1;
        until u<>v;
        writeln(f,u:10,v:10,random(9900)+100:10);
        end;
    close(f);
    end;
end.
