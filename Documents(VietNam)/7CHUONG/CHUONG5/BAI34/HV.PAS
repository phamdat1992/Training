{$R+}
uses crt;
const
     fi='hv.inp';
     fo='hv.out';
     gt:array[0..12] of longint=(1,1,2,6,24,120,720,5040,40320,362880,3628800,39916800,479001600);
type
    hv=array[1..15] of longint;
var
   n:longint;
   f,g:text;
   h,h1,h2:hv;
   s,s1,s2:longint;
   chua:array[1..15] of boolean;

function sh(h:hv):longint;
var
   i,j,k,tam:longint;
begin
     tam:=0;
     for i:=1 to n do
      begin
           j:=0;
           for k:=1 to i-1 do
           if h[k]<h[i] then inc(j);
           inc(tam,gt[n-i]*(h[i]-1-j));
      end;
     sh:=tam+1;
end;

procedure tinh;
var
   dem,dem1,i,j,k:longint;
begin
     fillchar(chua,sizeof(chua),true);
     i:=0;
     dem:=0;
     dem1:=dem;
     while (i<n)and(dem<s) do
      begin
           inc(i);
           inc(dem,gt[n-1]);
      end;
     if dem=s then
     begin
          h[1]:=i;
          k:=1;
          for j:=n downto 1 do
          if j<>i then
          begin
               inc(k);
               h[k]:=j;
          end;
          exit;
     end;
     h[1]:=i;
     chua[i]:=false;
     if dem1<dem then dec(s,dem-gt[n-1]);
     for k:=2 to n-1 do
      begin
           i:=0;
           dem:=0;
           dem1:=dem;
           while (i<=n)and(dem<s) do
           begin
                repeat
                      inc(i);
                until chua[i];
                if i<=n then inc(dem,gt[n-k]);
           end;
           if dem=s then
           begin
                h[k]:=i;
                if k<n then
                for j:=n downto 1 do
                if chua[j] then
                begin
                     inc(k);
                     h[k]:=j;
                end;
                exit;
           end;
           h[k]:=i;
           chua[i]:=false;
           if dem1<dem then dec(s,dem-gt[n-k]);
      end;
      for j:=1 to n do if chua[j] then
      begin
           h[n]:=j;
           exit;
      end;
end;

procedure lam;
var
   x,spt:longint;
begin
     assign(f,fi);
     reset(f);
     assign(g,fo);
     rewrite(g);
     while not(seekeof(f)) do
      begin
           n:=0;
           while not(seekeoln(f)) do
            begin
                 inc(n);
                 read(f,h[n]);
            end;
            readln(f);
            if n>2 then writeln(g,sh(h))
            else
            begin
                 n:=h[1];
                 s:=h[2];
                 tinh;
                 for x:=1 to n do write(g,h[x]:3);
                 writeln(g);
            end;
      end;
      close(f);
      close(g);
end;

BEGIN

clrscr;
lam;
END.