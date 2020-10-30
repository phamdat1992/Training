program tongtro;
var
stack: array[1..100] of record chu:char; so:real end;
i,j,l,n,k:integer;
R: real;
{dientro: array[1..100] of char;}
dientro: char;
gtdientro: array[char] of real;
s:string;
f :text;

procedure Nhap;
begin
     assign(f,'tongtro.inp');
     reset(f);
     readln(f,s);
     readln(f,n);
     for i:=1 to n do
     readln(f, dientro, gtdientro[dientro]);
     l:= 0; {chieu cao stack }
endnd;

procedure Put(x:char;y:real);
begin
inc(l);
stack[l].chu := x;
stack[l].so := y;
end;

Procedure Get(var x:char; var y:real);
begin
x:= stack[l].chu ;
y:= stack[l].so ;
Dec(l);
end;

procedure Xuly;
var th1,th2,pt1,dau1:char;
    th3,th4,pt2,dau2:real;
    k :integer;
    x :char;
procedure Lay(var x:char);
begin
   x:= s[k];
   inc(k);
end;

function tinh(th1:real;pt:char;th2:real):real;
begin
   case pt of
   '*': tinh := th1 + th2;
   '+': tinh := 1/(1/th1 + 1/th2);
   else begin
            writeln('Dau sai');
            tinh := 0;
            halt;
         end
   end;
end;

begin
    k:= 1;
    while k <= length(s) do
       begin
          lay(x);
          case x of
          #32: lay(x);
          ')': begin
                  get(th1,th3);
                  get(pt1,pt2);
                  get(th2,th4);
                  get(dau1,dau2);
                  if dau1 <> '('  then
                     begin
                        writeln('Thieu dau ngoac mo');
                        halt;
                     end
                  else
                     begin
                        put('@',tinh(th3,pt1,th4)); { ket qua dua vao bien @ tu phep toan  neu khong push('@')}
                     end
               end;
          'A'..'z':
               put(x,gtdientro[x]);
          else
               put(x,0);
          end;
       end;
     if l = 1 then
        writeln('Tong tro = ' , stack[1].so:10:3)
     else
        writeln('Khong dung cu phap');
end;

begin
    Nhap;
    Xuly;
    readln;
end.