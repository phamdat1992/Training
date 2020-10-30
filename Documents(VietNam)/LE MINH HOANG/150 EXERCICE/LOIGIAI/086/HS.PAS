{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const max = 200;
      fi  = 'city.in6';
      fo  = 'city.out';

type  tdat = array[1..max] of longint;
      ta   = array[1..max] of ^tdat;
      tp   = array[1..max] of byte;
      tpre = array[1..max] of ^tp;
      tcx  = array[1..max, 1..max] of boolean;

var   n      :  integer;
      sum,sd    :  longint;
      a      :  ta;
      pre    :  tpre; 
      cx     :  tcx;
      ftime  :  longint;
      ltime  :  longint absolute 0:$46c;

procedure nhapdl;
 var f              :      text;
     i, u, v, x, m  :      integer;
 begin
      assign(f, fi); reset(f);
      readln(f, n, m);
      for i := 1 to n do
      begin
           new(a[i]);
           fillchar(a[i]^, sizeof(a[i]^), 0);
      end;
      for i := 1 to m do
      begin
           readln(f, u, v, x);
           if (a[u]^[v] = 0) or (a[u]^[v] > x) then
           begin
                a[u]^[v] := x;
                a[v]^[u] := x;
           end;
      end;
      close(f);
 end;

procedure inkq;
 var f           :      text;
     i, j        :      integer;
 begin
      assign(f, fo); rewrite(f);
      writeln(f, sd, ' ' , sum);
      for i := 1 to n - 1 do
          for j := i + 1 to n do
              if not cx[i, j] then writeln(f, i,' ', j);
      close(f);
 end;

procedure init;
 var i, j, k   :        integer;
 begin
      for i := 1 to n do
      begin
           new(pre[i]);
           fillchar(pre[i]^, sizeof(pre[i]^), 0);
      end;
      for i := 1 to n - 1 do
          for j := i + 1 to n do
              if a[i]^[j] = 0 then
              begin
                   a[i]^[j] := maxlongint div 2;
                   a[j]^[i] := maxlongint div 2;
              end;
      for k := 1 to n do
          for i := 1 to n do
              for j := 1 to n do
                  if (i <> k) and (k <> j) and (j <> i) and (a[i]^[j] >= a[i]^[k] + a[k]^[j]) then
                  begin
                       a[i]^[j] := a[i]^[k] + a[k]^[j];
                       pre[i]^[j] := k;
                  end;
 end;

procedure landuong(i, j : integer);
 var k    : integer;
 begin
      if pre[i]^[j] = 0 then
      begin
           if cx[i, j] then
           begin
                inc(sum, a[i]^[j]);
                inc(sd);
           end;
           cx[i, j] := false;
           cx[j, i] := false;
           exit;
      end;
      k := pre[i]^[j];
      landuong(i, k);
      landuong(k, j);
 end;

procedure xuly;
 var i, j, k       : integer;
 begin
      fillchar(cx, sizeof(cx), true);
      sum := 0; sd := 0;
      for i := 1 to n - 1 do
          for j := i + 1 to n do landuong(i, j);
 end;

procedure destroy;
 var i            :     integer;
 begin
      for i := 1 to n do
      begin
           dispose(a[i]);
           dispose(pre[i]);
      end;
 end;

BEGIN
     ftime := ltime;
     nhapdl;
     init;
     xuly;
     inkq;
     destroy;
     writeln(ltime - ftime);
END.