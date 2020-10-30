{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses
    crt;
const
     fi         =       'dart.inp';
     fo         =       'dart.out';
     maxn       =       100;
type
    link                =       ^node;
    node                =       record
      d                 :       integer;
      w                 :       longint;
      cs                :       integer;
      next              :       link;
    end;
    mangd               =       array[1..maxn] of longint;
    mangtr              =       array[1..maxn,1..2] of longint;
var
   f,g          :       text;
   n            :       longint;
   a            :       array[1..maxn] of link;
   d            :       array[1..2] of mangd;
   tr           :       array[1..2] of mangtr;
   chua         :       array[1..maxn] of boolean;
   min1,min2    :       longint;
   nn           :       longint;
   htd,htc      :       array[1..maxn] of integer;
   ddd,ddc      :       longint;

procedure init;
var
   i            :       longint;
   begin
        for i := 1 to maxn do a[i] := nil;
   end;

function layl( s : string ) : longint;
   begin
        if pos('M',s) <> 0 then layl := 1 else layl := 2;
   end;

procedure add( u,v,w,loai,cs : longint );
var
   l            :       link;
   begin
        new(l);
        if loai = 1 then
        begin
             l^.d := v + n;
             l^.w := w;
             l^.cs := cs;
             l^.next := a[u];
             a[u] := l;
        end else
        begin
             l^.d := v;
             l^.w := w;
             l^.cs := cs;
             l^.next := a[u+n];
             a[u+n] := l;
        end;
   end;

procedure nhap;
var
   u,v,w1,w2,loai,cs            :       longint;
   s                            :       string;
   begin
        assign(f,fi); reset(f);
        readln(f,n);
        cs := 0;
        while not seekeof(f) do
        begin
             inc(cs);
             readln(f,u,v,w1,w2,s);
             loai := layl(s);
             add(u,v,w1,loai,cs);
             add(v,u,w2,3-loai,cs);
        end;
        close(f);
        nn := n;
        n := n * 2;
   end;

function min( s1,s2 : longint ) : longint;
   begin
        if s1 < s2 then min := s1 else min := s2;
   end;

procedure findpath( s : longint; var md : mangd; var mt : mangtr );
var
   i,j,min              :       longint;
   l                    :       link;
   last                 :       longint;
   begin
        for i := 1 to n do
        begin
             chua[i] := true;
             md[i] := maxlongint;
        end;
        chua[s] := false;
        md[s] := 0;
        last := s;
        while ((chua[1]) or (chua[1+nn])) do
        begin
             l := a[last];
             while l <> nil do
             begin
                  j := l^.d;
                  if chua[j] and (md[j] > md[last] + l^.w) then
                  begin
                       md[j] := md[last] + l^.w;
                       mt[j][1] := last;
                       mt[j][2] := l^.cs;
                  end;
                  l := l^.next;
             end;
             min := maxlongint;
             for i := 1 to n do
             if chua[i] and (md[i] < min) then
             begin
                  min := md[i];
                  last := i;
             end;
             if min = maxlongint then exit;
             chua[last] := false;
        end;
   end;

function cs( i : longint ) : longint;
   begin
        if i <= nn then cs := i else cs := i - nn;
   end;

procedure xuly;
   begin
        findpath(nn,d[1],tr[1]);
          min1 := min(d[1][1],d[1][1+nn]);

        findpath(n,d[2],tr[2]);
          min2 := min(d[2][1],d[2][1+nn]);
   end;

procedure ghi2;
var
   i,j            :       longint;
   l              :       link;
   begin
        if min2 = d[2][1] then i := 1 else i := 1 + nn;
        ddd := 1; htd[ddd] := cs(i);
        ddc := 0;
        while i <> n do
        begin
             inc(ddc); htc[ddc] := tr[2][i][2];
             i := tr[2][i][1];
             inc(ddd); htd[ddd] := cs(i);
        end;
        writeln(g,min2);
        for i := ddd downto 1 do write(g,htd[i],' ');   writeln(g);
        for i := ddc downto 1 do write(g,htc[i],' ');   writeln(g);
   end;

procedure ghi1;
var
   i,j            :       longint;
   l              :       link;
   begin
        if min1 = d[1][1] then i := 1 else i := 1 + nn;
        ddd := 1; htd[ddd] := cs(i);
        ddc := 0;
        while i <> nn do
        begin
             inc(ddc); htc[ddc] := tr[1][i][2];
             i := tr[1][i][1];
             inc(ddd); htd[ddd] := cs(i);
        end;
        writeln(g,min1);
        for i := ddd downto 1 do write(g,htd[i],' ');   writeln(g);
        for i := ddc downto 1 do write(g,htc[i],' ');   writeln(g);
   end;

procedure ghi;
   begin
        assign(g,fo); rewrite(g);
        if min1 < min2 then ghi1 else ghi2;
        close(g);
   end;

BEGIN
     clrscr;
     init;
     nhap;
     xuly;
     ghi;
END.