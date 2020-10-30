{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
PROGRAM         Cap_ghep_day_du_som_nhat;

USES            crt;

CONST
                fi              =               'cg1.inp';
                fo              =               'cg1.out';
                max             =               100;

TYPE
                arr1            =               array [1..max,1..max] of boolean;
                time            =               array [1..max,1..max] of integer;
                arr2            =               array [1..max] of integer;
                arr3            =               array [1..2*max] of integer;

VAR
                f1,f2           :               text;
                t               :               time;
                m,n             :               integer;
                tend,tmid       :               integer;
                tleft,tright    :               integer;
                p               :               arr2;
                ok              :               boolean;

procedure       doc_file;
var             i,j,tg:integer;
begin
     assign(f1,fi);
     reset(f1);
               readln(f1,m,n);
               for i:=1 to m do
                   for j:=1 to n do
                   begin
                        read(f1,tg);
                        if tg=-1 then tg:=maxint;
                        t[i,j]:=tg;
                   end;
     close(f1);
     ok:=m>=n;
end;

function        ghep_cap(lim:integer):integer;
var             q:arr3;
                u,z:integer;
                px,py:arr2;
                c:arr1;
                tmax:integer;

                procedure       xac_dinh_dieu_kien;
                var             i,j:integer;
                begin
                     fillchar(c,sizeof(c),false);
                     for i:=1 to m do
                         for j:=1 to n do
                             c[i,j]:=t[i,j]<lim;
                end;

                procedure       init;
                begin
                     fillchar(px,sizeof(px),0);
                     fillchar(py,sizeof(py),0);
                end;

                function        tudo:boolean;
                begin
                     tudo:=px[u]=0;
                end;

                function        tim:boolean;
                var             dau,cuoi,v,w:integer;
                                queue:arr3;
                begin
                     fillchar(q,sizeof(q),0);
                     dau:=1;
                     cuoi:=1;
                     queue[1]:=u;
                     q[u]:=u;
                     tim:=false;
                     while dau<=cuoi do
                     begin
                          v:=queue[dau];
                          inc(dau);
                          if v<=m then
                          begin
                               for w:=m+1 to m+n do
                                   if c[v,w-m] and (q[w]=0) then
                                   begin
                                        inc(cuoi);
                                        queue[cuoi]:=w;
                                        q[w]:=v;
                                   end;
                          end else
                              if py[v-m]=0 then
                              begin
                                   z:=v;
                                   tim:=true;
                                   exit;
                              end else
                                  begin
                                       w:=py[v-m];
                                       inc(cuoi);
                                       queue[cuoi]:=w;
                                       q[w]:=v;
                                  end;
                     end;
                end;

                procedure       tang;
                var             x,y:integer;
                                thuocy:boolean;
                begin
                     y:=z;
                     thuocy:=true;
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

begin
     xac_dinh_dieu_kien;
     init;
     for u:=1 to m do
         if tudo then
            if tim then tang;
     z:=0;
     for u:=1 to n do
         if py[u]>0 then inc(z);
     if z<n then tmax:=maxint
     else begin
               p:=py;
               tmax:=0;
               for u:=1 to n do
               begin
                    z:=t[p[u],u];
                    if tmax<z then tmax:=z;
               end;
          end;
     ghep_cap:=tmax;
end;

procedure       ghi_file;
var             i:integer;
begin
     assign(f2,fo);
     rewrite(f2);
                 if not ok then
                    writeln(f2,'Khong ghep duoc')
                 else begin
                           for i:=1 to n do
                               writeln(f2,p[i],' ',i);
                           writeln(f2,tleft);
                      end;
     close(f2);
end;

BEGIN
     clrscr;
     doc_file;
     if ok then
     begin
          tend:=ghep_cap(maxint);
          ok:=tend<maxint;
          if ok then
          begin
               tleft:=0;
               tright:=tend;
               while tleft<tright do
               begin
                    tmid:=(longint(tleft)+tright+1) div 2;
                    tend:=ghep_cap(tmid);
                    if tend<maxint then tright:=tend
                    else tleft:=tmid;
               end;
          end;
     end;
     ghi_file;
END.