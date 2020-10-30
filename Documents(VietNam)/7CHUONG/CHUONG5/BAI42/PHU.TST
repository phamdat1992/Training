uses crt;
var
   a,b,P,Q: longint;
   f:text;
   fn: string;
   i,j,n: longint;
begin
    clrscr;
    writeln('Tao test Bai phu nho nhat');
    write('So doan: ');readln(n);
    repeat
    write('P, Q = ');readln(p,q);
    until (q-p<5001) and (q>p);
    write('Ghi ra file PHU.IN');readln(fn);
    fn:='PHU.IN'+fn;
    assign(f,fn); rewrite(f);
    writeln(f,n,' ',P,' ',Q);
    randomize; a:=-3000;
    for i:=1 to n do
    begin
        a:=a+i*2;
        b:=a+random(1000)+1;
        writeln(f,a,' ',b);
    end;
    close(f);
    writeln('Da ghi xong du lieu ra file: ',fn);readln;
end.
