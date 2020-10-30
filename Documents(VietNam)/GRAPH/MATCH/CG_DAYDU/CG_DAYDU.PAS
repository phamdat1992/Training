{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM            Cap_ghep_day_du;

CONST              fi           =          'capghep.inp';
                   fo           =          'capghep.out';
                   nmax         =          150;


TYPE
                arr1            =          array [1..nmax,1..nmax] of byte;
                arr2            =          array [1..nmax] of integer;
                arr3            =          array [1..nmax*2] of integer;

VAR
                f1,f2           :          text;
                a               :          arr1;
                q               :          arr2;
                px,py           :          arr3;
                m,n             :          byte;
                u               :          integer;
                z               :          integer;

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
     readln(f1,m,n);
     for i:=1 to m do
         for j:=1 to n do
             read(f1,a[i,j]);
end;

procedure       ghi_file;
var             i:byte;
                t:integer;
begin
     t:=0;
     for i:=1 to m do
         if px[i]>0 then
            inc(t);
     writeln(f2,t);
     for i:=1 to m do
         if px[i]>0 then
            writeln(f2,i,' ',px[i]);
end;

function        tudo:boolean;
begin
     tudo:=px[u]=0;
end;

procedure       khoi_tao;
begin
     fillchar(px,sizeof(px),0);
     fillchar(py,sizeof(py),0);
end;

function        timduong:boolean;
var             dau,cuoi:integer;
                queue:arr3;
                v,w:integer;
begin
     timduong:=false;
     dau:=1;
     cuoi:=1;
     queue[1]:=u;
     fillchar(q,sizeof(q),0);
     q[u]:=u;
     while dau<=cuoi do
     begin
          v:=queue[dau];
          inc(dau);
          if v<m+1 then
          begin
               for w:=m+1 to m+n do
                   if (a[v,w-m]=1) and (q[w]=0) then
                   begin
                        inc(cuoi);
                        queue[cuoi]:=w;
                        q[w]:=v;
                   end;
          end else
                  if py[v-m]=0 then
                  begin
                       z:=v;
                       timduong:=true;
                       exit;
                  end else begin
                                w:=py[v-m];
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
               px[x]:=y-m;
               py[y-m]:=x;
          end;
          y:=x;
          thuocy:=not thuocy;
     end;
end;

BEGIN
     mo_file;
     doc_file;
     khoi_tao;
     for u:=1 to m do
         if tudo then
            if timduong then tang_cap_ghep;
     ghi_file;
     dong_file;
END.
                { " Bui Le Huyen - KCT - Dai hoc Vinh " }