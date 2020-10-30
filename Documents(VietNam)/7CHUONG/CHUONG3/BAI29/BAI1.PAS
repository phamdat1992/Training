{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

program bai1;
uses crt;

const   max             = 1000;
        fi              = 'b1.10';
        fo              = 'b1.out';

type    ta              = array [1..max] of byte;


var     a               : ta;
        n, x            : longint;



procedure input;
   var f  : text;
       ch : char;
       i  : integer;
   begin
        assign(f, fi); reset(f);
        readln(f, x);
        readln(f);
        n := 0;
        while  not seekeoln(f) do
        begin
             read(f, ch);
             n := n + 1;
             a[n] := ord(ch) - 48;
        end;
        close(f);
   end;


procedure ver(var a : ta;  n : integer);
   var i : integer;
       b : ta;
   begin
        for i := 1 to n do b[i] := a[n - i + 1];
        a := b;
   end;

procedure mul(var a : ta; var n : longint; x : longint);
   var i : integer;
       carry : longint;
   begin
        ver(a, n);
        carry:= 0;
        for i := 1 to n do
        begin
             carry := carry + a[i] * x;
             a[i] := carry mod 10;
             carry := carry div 10;
        end;
        while (carry <> 0) do
        begin
             n := n + 1;
             a[n] := carry mod 10;
             carry := carry div 10;
        end;
        ver(a, n);
   end;

procedure kiemtra;
  var f : text;
      i : integer;
      ch : char;
  begin
       assign(f, fo); reset(f);
       i := 0;
       while not seekeoln(f) do
       begin
            read(f, ch);
            i := i + 1;
            if (ord(ch)-48 <> a[i]) or (i > n) then
            begin
                 writeln('error', i:8);
                 close(f);
                 halt;
            end;
       end;
       close(f);
       writeln('OK');
  end;


procedure taotest;
   var i : integer;
       f, f1 : text;
       b : ta;
       m : integer;
   begin
        x := 131071;
        n := 990;
        assign(f, 'b1.990'); rewrite(f);
        writeln(f, x);
        a[1] := random (9)+1;

        for i := 2 to n do a[i] := random (10);

        m := n;
        b := a;
        mul(a, n, x);
        for i := 1 to n do write(f, a[i]);
        writeln(f);
        for i := 1 to m do write(f, b[i]);

        close(f);
        halt;
   end;


begin
     taotest;
     clrscr;
     input;
     kiemtra;
end.