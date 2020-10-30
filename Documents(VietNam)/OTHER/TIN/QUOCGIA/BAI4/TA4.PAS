{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65000,0,655360}
program Thue_giay;
const fi='Shoes.inp';
      fo='Shoes.out';
      nmax=100;
type  data1=array[1..nmax,1..nmax]of integer;
      data2=array[1..nmax]of integer;
      data3=array[1..nmax]of byte;
      data4=array[1..2*nmax]of longint;
var   n,m:byte;
      c:data1;
      s,h:data2;
      p:data3;
      min:longint;
      f:text;
      i,j,k:integer;
procedure input;
begin
     assign(f,fi);
     reset(f);
     readln(f,m,n);
     for i:=1 to m do read(f,s[i]);
     for i:=1 to n do read(f,h[i]);
     close(f);
end;
procedure init;
begin
     fillchar(c,sizeof(c),0);
     for i:=1 to n do
         for j:=1 to m do c[i,j]:=abs(h[i]-s[j]);
end;
procedure cgmin;
var px,py:data3;
    pre,fx:data4;
    u,z:integer;
procedure start;
begin
     fillchar(px,sizeof(px),0);
     fillchar(py,sizeof(py),0);
     fillchar(fx,sizeof(fx),0);
     for i:=1 to n do
         begin
         fx[i]:=c[i,1];
         for j:=2 to m do
             if c[i,j]>fx[i] then fx[i]:=c[i,j];
         end;
end;
procedure dao_ts;
begin
     for i:=1 to n do
         for j:=1 to m do c[i,j]:=-c[i,j];
end;
function find_path:boolean;
var q:data4;
    first,last:integer;
begin
     find_path:=false;
     fillchar(pre,sizeof(pre),0);
     fillchar(q,sizeof(q),0);
     q[1]:=u;pre[u]:=u;first:=1;last:=1;
     repeat
           i:=q[first];inc(first);
           if i<n+1 then
              begin
              for j:=n+1 to n+m do
                  if pre[j]=0 then
                   if fx[i]+fx[j]=c[i,j-n] then
                     begin
                     inc(last);q[last]:=j;pre[j]:=i;
                     if py[j-n]=0 then
                        begin
                        find_path:=true;
                        z:=j;
                        exit;
                        end;
                     end;
              end
                 else
                     begin
                     j:=py[i-n];
                     inc(last);q[last]:=j;pre[j]:=i;
                     end;
     until first>last;
end;
procedure repair;
var d,h:longint;
begin
     d:=maxint;
     for i:=1 to n do
         if pre[i]>0 then
            for j:=n+1 to n+m do
                if pre[j]=0 then
                   begin
                   h:=fx[i]+fx[j];
                   h:=h-c[i,j-n];
                   if d>h then d:=h;
                   end;
     for i:=1 to n do
         if pre[i]>0 then dec(fx[i],d);
     for j:=n+1 to n+m do
         if pre[j]>0 then inc(fx[j],d);
end;
procedure inc_cg;
var thuocy:boolean;
begin
     thuocy:=true;i:=z;
     repeat
           j:=i;i:=pre[j];
           if thuocy then
              begin
                   px[i]:=j-n;
                   py[j-n]:=i;
              end;
           thuocy:=not thuocy;
     until i=u;
end;
begin
     dao_ts;
     start;
     for u:=1 to n do
         begin
              while not find_path do repair;
              inc_cg;
         end;
     p:=px;
     dao_ts;
end;
procedure xuli;
begin
     cgmin;
     min:=0;
     for i:=1 to n do min:=min+c[i,p[i]];
end;
procedure output;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,min);
     for i:=1 to n do write(f,p[i],' ');
     close(f);
end;
begin
     input;
     init;
     xuli;
     output;
end.