uses crt;
const
     fi='parilon.inp';
     fo='parilon.out';
var
    n,i,j,t,tr        :         Integer;
    s                 :         String;
    d                 :         array[1..5000]of integer;
    f                 :         text;

function max(x , y    :         Integer): integer;
begin
     if x>y then max:=x else max:=y;
end;

procedure rf;
begin
     assign(f,fi);
     reset(f);
     readln(f,s);
     close(f);
end;

procedure qhd;
begin
     for j:=1 to n do
     begin
          d[j]:=1;tr:=0;
          for i:=j-1 downto 1 do
           begin
                t:=d[i];
                if s[i]=s[j] then d[i]:=tr+2 else d[i]:=max(d[i],d[i+1]);
                tr:=t;
           end;
     end;
end;


begin
     clrscr;
     rf;
     n:=length(s);
     qhd;
     writeln('      ******');
     writeln(' xau s = ' , s);
     writeln('  Can them ',n-d[1]);
     readln;
end.
abccbfga