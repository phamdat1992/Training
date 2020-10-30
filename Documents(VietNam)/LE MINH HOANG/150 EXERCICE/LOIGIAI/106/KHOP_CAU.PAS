{$A+,B-,D+,E-,F+,G+,I+,L+,N-,O+,P-,Q+,R+,S+,T+,V-,X+}
{$M 65520,0,655360}
program Song_lien;

uses    crt;

const   FI              = 'graph.in1';
        FO              = 'graph.ou1';
        NMAX            = 1000;
        MMAX            = 10000;

type    pnode           = ^tnode;
        tnode           = record
                                x : integer;
                                next : pnode;
                          end;

var     timenow          : longint absolute $0:$46C;
        start            : longint;

        lcau, lkhop      : integer;
        a                : array[0..NMAX] of pnode;
        khop             : array[1..NMAX] of boolean;
        cx, cy           : array[1..MMAX] of integer;
        val              : array[0..NMAX] of integer;
        n, m             : integer;

(****************************************************************************)

procedure AddtoList(x : integer; var l : pnode);
   var    p : pnode;
   begin
        new(p);
        p^.x := x;
        p^.next := l;
        l := p;
   end;

procedure DelfromList(x : integer; var l : pnode);
   var    p, t : pnode;
   begin
        p := l;
        if p^.x = x then begin l := p^.next; dispose(p); exit; end;
        while p^.x <> x do
         begin
              t := p;
              p := p^.next;
         end;
        t^.next := p^.next;
        dispose(p);
   end;

procedure DelList(var l : pnode);
   var    p : pnode;
   begin
        p := l;
        while p <> nil do
         begin
              p := l^.next;
              dispose(l);
              l := p;
         end;
   end;

procedure prepare;
   var    i : integer;
   begin
        start := timenow;
        clrscr;
        for i := 1 to NMAX do a[i] := nil;
   end;

procedure finish;
   var    i : integer;
   begin
        for i := 1 to NMAX do DelList(a[i]);
        writeln;
        writeln(' time : ', (timenow - start) / 18.23 :0:2, ' second.');
   end;

procedure readdata;
   var    f : text;
          i, x, y : integer;
   begin
        assign(f, FI);  reset(f);
        readln(f, n, m);
        for i := 1 to m do
         begin
              readln(f, x, y);
              AddtoList(x, a[y]);
              AddtoList(y, a[x]);
         end;
        close(f);
   end;

procedure outputres;
   var    f : text;
          i : integer;
   begin
        lkhop := 0;
        for i := 1 to n do if khop[i] then inc(lkhop);
        assign(f, FO); rewrite(f);
        writeln(f, lkhop, ' ', lcau);
        for i := 1 to n do if khop[i] then writeln(f, i);
        for i := 1 to lcau do writeln(f, cx[i], ' ', cy[i]);
        close(f);
        writeln(lkhop);
        writeln(lcau);
   end;

function min2(x, y : integer) : integer;
   begin
        if x < y then min2 := x else min2 := y;
   end;

(****************************************************************************)
procedure solve;
  var     goc, count, child : integer;

 procedure init;
   var    i : integer;
   begin
        fillchar(val, sizeof(val), 0);
        fillchar(khop, sizeof(khop), false);
        lcau := 0;
   end;

 function  visit(x : integer) : integer;
   var     p : pnode;
           min, temp : integer;
   begin
        inc(count); val[x] := count; min := count;
        p := a[x];
        while p <> nil do
         begin
              if val[p^.x] = 0 then
               begin
                    DelfromList(x, a[p^.x]);
                    if x = goc then inc(child);
                    temp := visit(p^.x);
                    if min > temp then min := temp;
                    if temp >= val[x] then
                     begin
                          khop[x] := true;
                          if temp > val[x] then
                           begin
                            inc(lcau);
                            cx[lcau] := x; cy[lcau] := p^.x;
                           end;
                      end;
                    AddtoList(x, a[p^.x]);
               end
              else if min > val[p^.x] then min := val[p^.x];
              p := p^.next;
         end;
        visit := min;
   end;

   begin
        init;
        for goc := 1 to n do if val[goc] = 0 then
         begin
              count := 0;
              child := 0;
              visit(goc);
              khop[goc] := child > 1;
         end;
   end;

(****************************************************************************)

begin
     prepare;
     readdata;
     solve;
     outputres;
     finish;
end.