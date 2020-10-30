{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

program apower;
uses crt;
const
        fi      =       'APOWER.INP';
        fo      =       'APOWER.OUT';
var
        a       :       array[0..10000]of longint;
        m,n     :       integer;
        g,f     :       text;
        time    :       longint;
        timesave:       longint absolute 0:$46c;

procedure       xuli    ( m , n  : integer);
var
   i,k        :       longint;
   j          :       longint;
begin
     for i:=1 to 10000 do a[i]:=maxlongint;
     if n<>1 then a[1]:=2;
     j:=n;
     i:=1;
     repeat
           a[j]:=i;
           inc(i);
           j:=j*10+n;
     until (j>m*n);
     if a[m]<>maxlongint then
     begin
          writeln(g,a[m]);
          exit;
     end;
     writeln(j);
     for i:=1 to m*n do
     if a[i]<>maxlongint then
      for k:=1 to m*n do
      if a[k]<>maxlongint then
       begin
            if k>=i then if a[i]+a[k]<a[k-i] then a[k-i]:=a[i]+a[k];
            if i>k then if a[i]+a[k]<a[i-k] then a[i-k]:=a[i]+a[k];
            if i*k<=j then
            if (a[i*k]>a[i]+a[k]) then a[i*k]:=a[i]+a[k];
            if i+k<=j then if  a[i]+a[k]<a[i+k] then a[i+k]:=a[i]+a[k];
            if i mod k=0 then
            if a[i]+a[k]<a[i div k] then a[i div k]:=a[i]+a[k];
            if k mod i=0 then
            if a[i]+a[k]<a[ k div i] then a[k div i]:=a[i]+a[k];
       end;
     writeln(g,a[m]);
end;

procedure       readfile;
begin
     clrscr;
     assign(f,fi); reset(f);
     assign(g,fo); rewrite(g);
     time:=timesave;
     while not seekeof(f) do
     begin
          readln(f,m,n);
          xuli(m,n);
     end;
     writeln((timesave-time)/18.21:0:1);
     close(f); close(g);
end;

begin
     readfile;
end.