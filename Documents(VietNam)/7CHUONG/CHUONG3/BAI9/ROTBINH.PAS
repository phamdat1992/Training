{$R+}
{  Bai Rot Binh }
const
     fi='rot.in2';
     fo='rot.out';
type
    tt=record x,y:byte;end;
var
   n:byte;
   m:array[0..20] of byte;
   q:array[0..10000] of tt;
   truoc:array[0..100,0..100] of tt;
   f:text;slr:word;
   uc,vc:byte;
   ok:boolean;

procedure nhap;
var
   i:byte;
begin
     fillchar(m,sizeof(m),0);
     assign(f,fi);reset(f);
     readln(f,n);
     for i:=1 to n do read(f,m[i]);
     close(f);
end;

procedure rot;
var
   f,l,i,j:word;
   u,v:byte;
begin
     for i:=0 to 100 do
      for j:=0 to 100 do
       begin
            truoc[i,j].x:=0;
            truoc[i,j].y:=0;
       end;
     f:=1;
     l:=1;
     q[f].x:=100;
     q[f].y:=0;
     truoc[100,0].x:=120;
     truoc[100,0].y:=120;
     while f<=l do
      begin
           u:=q[f].x;
           v:=q[f].y;
           inc(f);
           if u+v=99 then
           begin
                ok:=true;
                uc:=u;
                vc:=v;
                exit;
           end;
           if u+v>0 then
           begin
                i:=0;
                while (i<=n)and(m[i]<u) do
                 begin
                 {Rot tu binh 1 sang binh 2 , nuoc binh 1 trung voi muc}
                      if truoc[m[i],v+u-m[i]].x+truoc[m[i],v+u-m[i]].y=0 then
                      begin
                           inc(l);
                           q[l].x:=m[i];
                           q[l].y:=v+u-m[i];
                           truoc[m[i],v+u-m[i]].x:=u;
                           truoc[m[i],v+u-m[i]].y:=v;
                      end;
                 {Rot tu binh 1 sang binh 3 , nuoc binh 1 trung voi muc}
                      if truoc[m[i],v].x+truoc[m[i],v].y=0 then
                      begin
                           inc(l);
                           q[l].x:=m[i];
                           q[l].y:=v;
                           truoc[m[i],v].x:=u;
                           truoc[m[i],v].y:=v;
                      end;
                      inc(i);
                 end;{While}
                i:=n;
                while (i>=0)and(m[i]>v) do
                 begin
                      if u>=m[i]-v then
                      begin
                      {Rot tu binh 1 sang binh 2 , nuoc binh 2 trung voi muc}
                           if truoc[u+v-m[i],m[i]].x+truoc[u+v-m[i],m[i]].y=0 then
                           begin
                                inc(l);
                                q[l].x:=u+v-m[i];
                                q[l].y:=m[i];
                                truoc[u+v-m[i],m[i]].x:=u;
                                truoc[u+v-m[i],m[i]].y:=v;
                           end;
                      end;
                      dec(i);
                 end;{While i>=0}
                i:=0;
                while (i<=n)and(m[i]<v) do
                 begin
                 {Rot tu binh 2 sang binh 1 , nuoc binh 2 trung voi muc}
                      if truoc[u+v-m[i],m[i]].x+truoc[u+v-m[i],m[i]].y=0 then
                      begin
                           inc(l);
                           q[l].x:=u+v-m[i];
                           q[l].y:=m[i];
                           truoc[u+v-m[i],m[i]].x:=u;
                           truoc[u+v-m[i],m[i]].y:=v;
                      end;
                      {Rot tu binh 2 sang binh 3 , nuoc binh 2 trung voi muc}
                      if truoc[u,m[i]].x+truoc[u,m[i]].y=0 then
                      begin
                           inc(l);
                           q[l].x:=u;
                           q[l].y:=m[i];
                           truoc[u,m[i]].x:=u;
                           truoc[u,m[i]].y:=v;
                      end;
                      inc(i);
                 end;{While}
                i:=n;
                while (i>=1)and(m[i]>u) do
                begin
                     if v>=m[i]-u then
                     begin
                     {Rot tu binh 2 sang binh 1 , nuoc binh 1 trung voi muc}
                          if truoc[m[i],u+v-m[i]].x+truoc[m[i],u+v-m[i]].y=0 then
                          begin
                               inc(l);
                               q[l].x:=m[i];
                               q[l].y:=u+v-m[i];
                               truoc[m[i],u+v-m[i]].x:=u;
                               truoc[m[i],u+v-m[i]].y:=v;
                          end;
                     end;
                     dec(i);
                end;{While i>=1}
           end;{If u+v}
           if u+v<100 then
           begin
                {Rot tu binh 3 sang binh 1}
                if truoc[100-v,v].x+truoc[100-v,v].y=0 then
                begin
                     inc(l);
                     q[l].x:=100-v;
                     q[l].y:=v;
                     truoc[100-v,v].x:=u;
                     truoc[100-v,v].y:=v
                end;
                i:=n;
                while (i>=1)and(m[i]>u) do
                 begin
                      if 100-u-v>=m[i]-u then
                      if truoc[m[i],v].x+truoc[m[i],v].y=0 then
                      begin
                           inc(l);
                           q[l].x:=m[i];
                           q[l].y:=v;
                           truoc[m[i],v].x:=u;
                           truoc[m[i],v].y:=v;
                      end;
                      dec(i);
                 end;
                 {Rot tu binh 3 sang binh 2}
                 if truoc[u,100-u].x+truoc[u,100-u].y=0 then
                 begin
                      inc(l);
                      q[l].x:=u;
                      q[l].y:=100-u;
                      truoc[u,100-u].x:=u;
                      truoc[u,100-u].y:=100-u;
                 end;
                 i:=n;
                 while (i>=1)and(m[i]>v) do
                  begin
                       if 100-u-v>=m[i]-v then
                       if truoc[u,m[i]].x+truoc[u,m[i]].y=0 then
                       begin
                            inc(l);
                            q[l].x:=u;
                            q[l].y:=m[i];
                            truoc[u,m[i]].x:=u;
                            truoc[u,m[i]].y:=v;
                       end;
                       dec(i);
                  end;
         end;{If u+v<100}
     end;{While f<=l}
end;

procedure qtrot;
var
   tamu,tamv:byte;
   i:word;
begin
     for i:=1 to 10000 do
      begin
           q[i].x:=0;
           q[i].y:=0;
      end;
     slr:=0;
     tamu:=uc;
     tamv:=vc;
     while (tamu<>100)or(tamv<>0) do
      begin
           inc(slr);
           q[slr].x:=tamu;
           q[slr].y:=tamv;
           uc:=truoc[tamu,tamv].x;
           vc:=truoc[tamu,tamv].y;
           tamu:=uc;
           tamv:=vc;
      end;
     inc(slr);
     q[slr].x:=tamu;
     q[slr].y:=tamv;
end;

procedure viet;
var
   i    :       word;
   u1,v1,u2,v2:byte;
begin
     writeln(f,slr-1);
     for i:=slr downto 2 do
      begin
           u1:=q[i].x;
           v1:=q[i].y;
           u2:=q[i-1].x;
           v2:=q[i-1].y;
           if (u1=u2)and(v1<v2) then writeln(f,3:4,2:4,v2-v1:4);
           if (u1=u2)and(v1>v2) then writeln(f,2:4,3:4,v1-v2:4);
           if (u1<u2)and(v1=v2) then writeln(f,3:4,1:4,u2-u1:4);
           if (u1>u2)and(v1=v2) then writeln(f,1:4,3:4,u1-u2:4);
           if u1+v1=u2+v2 then
           begin
                if u1>u2 then writeln(f,1:4,2:4,u1-u2:4);
                if u1<u2 then writeln(f,2:4,1:4,u2-u1:4);
           end;
     end;
end;

BEGIN
     nhap;
     ok:=false;
     rot;
     assign(f,fo);
     rewrite(f);
     if ok then
     begin
          writeln(f,'CO');
          qtrot;
          viet;
     end
     else writeln(f,'KHONG');
     close(f);
END.