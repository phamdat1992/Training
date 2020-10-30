uses crt;
type
     toado=record
      x,y:integer;
     end;
     mang=array[1..1000] of toado;
 var a:mang;

 procedure readfile;
 var
 begin
  writeln('INPUT:')
  assign(f,'nhin_hv.inp');
  reset(f);
  readln(f,n);
  writeln(n);
  for i:=1 to n do
   begin
     readln(f,
