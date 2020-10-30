{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM            Luong_cuc_dai;

USES               crt;

CONST              fi           =          'luong.inp';
                   fo           =          'luong2.out';
                   nmax         =          100;

TYPE

                   arr1         =          array [1..nmax,1..nmax] of integer;
                   arr2         =          array [1..nmax] of byte;
                   arr3         =          array [1..nmax] of boolean;

VAR
                   f1,f2        :          text;
                   c,f          :          arr1;
                   n            :          integer;

procedure       mo_file;
begin
     assign(f1,fi);reset(f1);
     assign(f2,fo);rewrite(f2);
end;

procedure       dong_file;
begin
     close(f1);
     close(f2);
end;

procedure       doc_file;
var             i,j:integer;
begin
     readln(f1,n);
     for i:=1 to n do
         for j:=1 to n do
             read(f1,c[i,j]);
end;

procedure       ghi_file;
var             i,j:integer;
                fmax:integer;
begin
     for i:=1 to n do
         for j:=1 to n do
             if f[i,j]>0 then
                writeln(f2,i:4,j:4,f[i,j]:8);
     fmax:=0;
     for i:=1 to n do
         inc(fmax,f[1,i]);
     writeln(f2,'----------------',#10#13,fmax);
end;

procedure       chuan_bi;
var             i,j:integer;
begin
     for i:=1 to n do
         for j:=1 to n do
             f[i,j]:=0;
end;

function        du(u,v:integer):integer;
begin
     if f[v,u]>0 then du:=f[v,u]
     else du:=c[u,v]-f[u,v];
end;

function        tim(var p:arr2):boolean;
var             i,dau,cuoi,x,y : integer;
                pre,queue      : arr2;
                xet            : arr3;

                procedure      find;
                var            x,no,i:integer;
                begin
                     x:=n;
                     no:=n;
                     while (x<>0) do
                     begin
                          p[no]:=x;
                          dec(no);
                          x:=pre[x];
                     end;
                     for i:=1 to n-no do
                         p[i]:=p[i+no];
                end;

                procedure       them(y,x:integer);
                begin
                     if not xet[y] then exit;
                     inc(cuoi);
                     queue[cuoi]:=y;
                     xet[y]:=false;
                     pre[y]:=x;
                end;

begin
     for i:=1 to n do xet[i]:=true;
     dau:=1;
     cuoi:=0;
     them(1,0);
     while dau<=cuoi do
     begin
          x:=queue[dau];
          inc(dau);
          for y:=1 to n do
              if du(x,y)>0 then them(y,x);
          if not xet[n] then break;
     end;
     tim:=not xet[n];
     if not xet[n] then find;
end;

procedure       tang(var p:arr2);
var             d,i:integer;

                function    getmin:integer;
                var         i,min:integer;
                begin
                     i:=1;
                     min:=maxint;
                     while p[i]<>n do
                     begin
                          if min>du(p[i],p[i+1]) then
                             min:=du(p[i],p[i+1]);
                          inc(i);
                     end;
                     getmin:=min;
                end;

begin
     d:=getmin;
     i:=1;
     while p[i]<>n do
     begin
          if f[p[i],p[i+1]]>=0 then
             inc(f[p[i],p[i+1]],d)
          else dec(f[p[i+1],p[i]],d);
          inc(i);
     end;
end;

procedure       xu_ly;
var             p:arr2;
begin
     while tim(p) do tang(p);
end;

BEGIN
     clrscr;
     mo_file;
     doc_file;
     chuan_bi;
     xu_ly;
     ghi_file;
     dong_file;
END.
                { " Bui Le Huyen - KCT - Dai hoc Vinh " }