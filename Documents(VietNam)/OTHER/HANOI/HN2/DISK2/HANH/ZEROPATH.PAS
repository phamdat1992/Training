{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

const  fi='zeropath.inp';
       fo='zeropath.out';
var    q:array[0..15000] of word;
       ok:array[0..15000] of boolean;
       n,last,first:word;
       dem:longint;
       f:text;

procedure  readfile;
begin
      assign(f,fi);
      reset(f);
      readln(f,n);
      close(f);
end;

procedure  init;
begin
      fillchar(q,sizeof(q),0);
      fillchar(ok,sizeof(ok),true);
      last:=1;
      first:=0;
      q[last]:=n;
      dem:=1;
end;

procedure  xuli(i:word);
var   j,k,j1:word;
begin
       for j1:=2 to trunc(sqrt(i)) do
         if i mod j1 =0 then
           begin
                 j:=j1;
                 k:= i div j;
                 j:=j-1;
                 k:=k+1;
                  if ok[j*k] then
                   begin
                         ok[j*k]:=false;
                         inc(last);
                         q[last]:=j*k;
                   end;
           end;
end;

procedure  process;
var  u:word;
begin
      repeat
             inc(first);
             u:=q[first];
             xuli(u);
      until  first>last;
      q[1]:=0;
end;

procedure  sort(l,r:word);
var  i,j,x,tg:word;
begin
      i:=l;j:=r;x:=q[(i+j) div 2+1];
      repeat
      while q[i]<x do inc(i);
      while q[j]>x do dec(j);
      if i<=j then
        begin
              tg:=q[i];
              q[i]:=q[j];
              q[j]:=tg;
              inc(i);
              dec(j);
        end;
       until i>j;
       if i<r then sort(i,r);
       if j>l then sort(l,j);
end;


procedure  main;
var  i:word;
begin
      init;
      readfile;
      last:=1;
      first:=0;
      q[last]:=n;
      dem:=1;
      assign(f,fo);
      rewrite(f);
        process;
         sort(1,last);
         writeln(last);
         writeln(f,last);
         for i:=1 to last do write(f,q[i],'  ');
      close(f);
end;

begin
    main;
end.
12