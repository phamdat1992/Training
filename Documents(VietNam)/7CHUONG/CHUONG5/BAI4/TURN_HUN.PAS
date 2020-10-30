program turn_around;
uses crt;
const
     fi='turn.inp';
     fo='turn.out';
var
   a:array[1..50]of byte;
   c:Array[1..20,1..20]of byte;
   n,k,i,j:Integer;
   f:text;

procedure readf;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do read(f,a[i]);
     close(f);
end;

procedure xuli;
var dem:Integer;
begin
     i:=1;
     repeat
           if (i+1)*i>=2*n then break else inc(i);
     until false;
     k:=i;
     writeln(k);
     dem:=0;
     for i := k downto 1 do
      for j := 1 to i do
       begin
            inc(dem);
            if dem > n then break;
            c[k-i+1, (j-1) * 2 + (k-i+1)] := a[dem];
       end;
     for i:=1  to k do
     begin
          for j:=1 to 2*k do write(c[i,j], ' ');writeln;
     end;
end;

procedure try(i:byte);
var j:Byte;
begin
end;

begin
     clrscr;
     readf;
     xuli;
end.
9
1 2 3 4 5 6 7 8 9
