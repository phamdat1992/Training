{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM            Cap_ghep_day_du_min;

CONST              fi           =          'capghep.inp';
                   fo           =          'capghep.out';
                   nmax         =          100;


TYPE
                arr1            =          array [1..nmax,1..nmax] of integer;
                arr2            =          array [1..nmax] of integer;
                arr3            =          array [1..nmax*2] of integer;

VAR
                f1,f2           :          text;
                a               :          arr1;
                f,q             :          arr2;
                px,py           :          arr3;
                n               :          byte;
                u               :          byte;
                z               :          byte;

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
var             i,j:byte;
begin
     readln(f1,n);
     for i:=1 to n do
         for j:=1 to n do
             read(f1,a[i,j]);
end;

procedure       ghi_file;
var             t:integer;
                i:byte;
begin
     t:=0;
     for i:=1 to n do
         t:=t+a[i,px[i]];
     writeln(f2,t);
     for i:=1 to n do
         writeln(f2,i,' ',px[i]);
end;

function        tudo:boolean;
begin
     tudo:=px[u]=0;
end;

procedure       khoi_tao;
var             i,j:byte;
                xx:integer;
begin
     fillchar(f,sizeof(f),0);
     for i:=1 to n do
     begin
          xx:=a[i,1];
          for j:=2 to n do
              if a[i,j]>xx then
                 xx:=a[i,j];
          f[i]:=xx;
     end;
     fillchar(px,sizeof(px),0);
     fillchar(py,sizeof(py),0);
end;

function        timduong:boolean;
var             dau,cuoi:integer;
                v,w:byte;
                queue:arr3;
begin
     timduong:=false;
     fillchar(q,sizeof(q),0);
     q[u]:=u;
     dau:=1;
     cuoi:=1;
     queue[dau]:=u;
     while dau<=cuoi do
     begin
          v:=queue[dau];
          inc(dau);
          if v<n+1 then
          begin
               for w:=n+1 to n+n do
                   if (f[v]+f[w]=a[v,w-n]) and (q[w]=0) then
                   begin
                        inc(cuoi);
                        queue[cuoi]:=w;
                        q[w]:=v;
                   end;
          end else
                  if py[v-n]=0 then
                  begin
                       z:=v;
                       timduong:=true;
                       exit;
                  end else begin
                                w:=py[v-n];
                                inc(cuoi);
                                queue[cuoi]:=w;
                                q[w]:=v;
                           end;
     end;
end;

procedure       tang_cap_ghep;
var             x,y:byte;
                thuocy:boolean;
begin
     thuocy:=true;
     y:=z;
     while y<>u do
     begin
          x:=q[y];
          if thuocy then
          begin
               px[x]:=y-n;
               py[y-n]:=x;
          end;
          y:=x;
          thuocy:=not thuocy;
     end;
end;

procedure       sua_nhan;
var             i,j:byte;
                d,h:integer;
begin
     d:=maxint;
     for i:=1 to n do
         if q[i]>0 then
            for j:=n+1 to n+n do
                if q[j]=0 then
                begin
                     h:=f[i]+f[j]-a[i,j-n];
                     if h<d then d:=h;
                end;
     for i:=1 to n do
         if q[i]>0 then f[i]:=f[i]-d;
     for j:=n+1 to n+n do
         if q[j]>0 then f[j]:=f[j]+d;
end;

BEGIN
     mo_file;
     doc_file;
     for u:=1 to n do
         if tudo then
         begin
              while not timduong do sua_nhan;
              tang_cap_ghep;
         end;
     ghi_file;
     dong_file;
END.
                { " Bui Le Huyen - KCT - Dai hoc Vinh " }