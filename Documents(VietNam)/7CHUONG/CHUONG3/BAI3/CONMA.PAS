{$M 65000,0,0}
const
     fi='ma.in5';
     fo='ma.out';
     d:array[1..8] of shortint=(-2,-2,-1,1,2,2,1,-1);


       c:array[1..8] of shortint=(-1,1,2,2,1,-1,-2,-2);
var
   m,n,u,v:shortint;k,s:word;
   a:array[-1..102,-1..102] of word;
   f:text;
procedure nhap;
var
   i,j:shortint;
begin
     fillchar(a,sizeof(a),1);
     assign(f,fi);
     reset(f);
     readln(f,m,n);
     readln(f,k);
     readln(f,u,v);
     close(f);
     for i:=1 to m do
     for j:=1 to n do a[i,j]:=0;
     a[u,v]:=1;
end;
procedure nhay(i:word;p,q:shortint);
var
      j:shortint;
begin
    for j:=1 to 8 do
    if  a[p+d[j],q+c[j]]=0 then
        begin
        inc(s);
        a[p+d[j],q+c[j]]:=2;
        if i=k then exit else nhay(i+1,p+d[j],q+c[j]);
        end;
end;
procedure viet;
var
   p,q:shortint;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,s);
     for p:=1 to m do
     for q:=1 to n do
     if a[p,q]>1 then
     writeln(f,p,q:4);
     close(f);
end;
BEGIN
     nhap;
     s:=0;
     nhay(1,u,v);
     viet;
END.