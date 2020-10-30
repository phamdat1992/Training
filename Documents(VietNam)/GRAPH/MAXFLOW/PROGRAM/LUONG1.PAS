{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM         Luong;

USES            crt;

CONST
                fi              =               'luong.inp';
                fo              =               'luong1.out';
                mmax            =               100;

TYPE
                arr1            =               array [1..mmax,1..mmax] of integer;
                arr2            =               array [1..mmax] of integer;

VAR
                f1,f2           :               text;
                m,s,t           :               integer;
                a,f             :               arr1;
                p,e             :               arr2;
                queue           :               arr2;
                find            :               boolean;

procedure       doc_file;
var             i,j:integer;
begin
     assign(f1,fi);
     reset(f1);
               readln(f1,m);
               for i:=1 to m do
                   for j:=1 to m do
                       read(f1,a[i,j]);
     close(f1);
     s:=1;
     t:=m;
end;

function        getmin(a,b:integer):integer;
begin
     getmin:=a;
     if a>b then getmin:=b;
end;

procedure       tim_duong;
var             dau,cuoi,u,v:integer;
begin
     fillchar(queue,sizeof(queue),0);
     fillchar(p,sizeof(p),0);
     dau:=1;
     cuoi:=1;
     queue[1]:=s;
     p[s]:=s;
     find:=true;
     e[s]:=maxint;
     while dau<=cuoi do
     begin
          u:=queue[dau];
          inc(dau);
          for v:=1 to m do
              if p[v]=0 then
              begin
                   if (a[u,v]>0) and (f[u,v]<a[u,v]) then
                   begin
                        p[v]:=u;
                        e[v]:=getmin(e[u],a[u,v]-f[u,v]);
                        inc(cuoi);
                        queue[cuoi]:=v;
                        if v=t then exit;
                   end;
                   if (a[v,u]>0) and (f[v,u]>0) then
                   begin
                        p[v]:=-u;
                        e[v]:=getmin(e[u],f[v,u]);
                        inc(cuoi);
                        queue[cuoi]:=v;
                        if v=t then exit;
                   end;
              end;
     end;
     find:=false;
end;

procedure       tang_luong;
var             u,v:integer;
begin
     u:=t;
     v:=p[t];
     while u<>s do
     begin
          if v>0 then f[v,u]:=f[v,u]+e[t]
          else
          begin
               v:=-v;
               f[u,v]:=f[u,v]-e[t];
          end;
          u:=v;
          v:=p[u];
     end;
end;

procedure       tim_luong;
var             stop:boolean;
begin
     fillchar(f,sizeof(f),0);
     stop:=false;
     while not stop do
     begin
          tim_duong;
          if find then tang_luong
          else stop:=true;
     end;
end;

procedure       ghi_file;
var             fmax,i,j:integer;
begin
     assign(f2,fo);
     rewrite(f2);
                 tim_luong;
                 for i:=1 to m do
                     for j:=1 to m do
                         if f[i,j]>0 then
                            writeln(f2,i:4,j:4,f[i,j]:8);
                 fmax:=0;
                 for i:=1 to m do
                     fmax:=fmax+f[s,i];
                 writeln(f2,'----------------',#10#13,fmax);
     close(f2);
end;

BEGIN
     clrscr;
     doc_file;
     ghi_file;
END.