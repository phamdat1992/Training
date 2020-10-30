uses crt;
const
     fi='obstacle.in';
     m=30;w=5;
var
   f:text;t:char;
   i,j,x,y,z,p,q:word;
BEGIN
randomize;
for t:='0' to '0' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,m);
    p:=13;
    for i:=1 to 5 do
        begin
        q:=10;
        for j:=1 to 6 do
            begin
            x:=1+random(p);y:=1+random(q);writeln(f,x:4,y:4,w:4);
            inc(q,15);
            end;
        inc(p,18);
        end;
    close(f);
    end;
END.