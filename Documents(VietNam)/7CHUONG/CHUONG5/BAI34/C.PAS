{$R+}
uses crt;
const
     fhs='hv.out';
     fi='hv.inp';
     fo='hv.kt';
var
   f,g,h:text;
   sai,n:longint;
   h1:array[1..15] of longint;
   x,y,z,spt:longint;
   kk:longint;
BEGIN
     kk:=0;
clrscr;
writeln;
writeln('         CO TAT CA 60 KET QUA');
writeln;

assign(f,fi);reset(f);
assign(g,fo);reset(g);
assign(h,fhs);reset(h);
while not(seekeof(f)) do
      begin
      n:=0;
      inc(kk);
      while not(seekeoln(f)) do
            begin
            inc(n);
            read(f,h1[n]);
            end;
      readln(f);
      if n>2 then
         begin
         readln(g,x);readln(h,y);if x<>y then
         begin
                inc(sai);
                writeln('hoan vi o vi tri ',x,'la o ',y);
         end
         end
      else
          begin
          n:=h1[1];
          for z:=1 to n do
              begin
              read(g,x);read(h,y);
              if x<>y then begin
              writeln(' sai o ',kk);
              inc(sai);break;end;
              end;
          end;
      readln(g);readln(h);
      end;
close(f);close(g);close(h);erase(h);
writeln('         SO KET QUA SAI: ',sai);
readln;
END.