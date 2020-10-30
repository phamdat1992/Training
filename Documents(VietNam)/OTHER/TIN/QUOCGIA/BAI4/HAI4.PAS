{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program cho_thue_giay;
 const
      fi                =               'shoes.in0';
      fo                =               'shoes.ou0';
      nmax              =               100;
 type
      data              =               array [1..nmax, 1..nmax] of longint;
      data1             =               array [1..nmax] of longint;
      data2             =               array [1..2*nmax] of longint;
 var
      f                 :               text;
      m, n              :               longint;
      h, s              :               data1;
      a                 :               data;
      ft, pre, q        :               data2;
      px, py            :               data1;
      u, z              :               longint;
      cl                :               longint;
 procedure input;
  var
      i                 :               longint;
  begin
       assign(f,fi);
       reset(f);
       readln(f,m,n);
       for i:=1 to m do
           read(f,s[i]);
       readln(f);
       for i:=1 to n do
           read(f,h[i]);
       close(f);
  end;
 procedure init;
  var
      i, j              :               longint;
  begin
       for i:=1 to m do
           for j:=1 to m do
               begin
                    if j<=n then
                       a[i,j]:=-abs(h[j]-s[i])
                    else
                       a[i,j]:=-maxint;
               end;
       for i:=1 to m do
           begin
                ft[i+m]:=0;
                ft[i]:=a[i,1];
                for j:=2 to m do
                    if a[i,j]>ft[i] then
                       ft[i]:=a[i,j];
           end;
       fillchar(px, sizeof(px), 0);
       fillchar(py, sizeof(py), 0);
  end;
 function tudo:boolean;
  begin
       tudo:=px[u]=0;
  end;
 function timthayduongtangcapghep:boolean;
  var
      first, last, v, w :               longint;
  begin
       fillchar(pre, sizeof(pre), 0);
       first:=1;
       last:=1;
       q[1]:=u;
       pre[u]:=u;
       while first<=last do
             begin
                  v:=q[first];
                  inc(first);
                  if v<=m then
                     begin
                          for w:=m+1 to m+m do
                              if (ft[w]+ft[v]=a[v,w-m]) and (pre[w]=0) then
                                 begin
                                      inc(last);
                                      q[last]:=w;
                                      pre[w]:=v;
                                 end;
                     end
                  else
                     if py[v-m]=0 then
                        begin
                             timthayduongtangcapghep:=true;
                             z:=v;
                             exit;
                        end
                     else
                        begin
                             w:=py[v-m];
                             inc(last);
                             q[last]:=w;
                             pre[w]:=v;
                        end;
             end;
       timthayduongtangcapghep:=false;
  end;
 procedure tangcapghep;
  var
      x, y              :               longint;
      thuocy            :               boolean;
  begin
       y:=z;
       thuocy:=true;
       while y<>u do
             begin
                  x:=pre[y];
                  if thuocy then
                     begin
                          px[x]:=y-m;
                          py[y-m]:=x;
                     end;
                  y:=x;
                  thuocy:=not thuocy;
             end;
  end;
 procedure suanhan;
  var
      x, y, h, d        :               longint;
  begin
       d:=maxint;
       for x:=1 to m do
           if pre[x]<>0 then
              for y:=m+1 to m+m do
                  if pre[y]=0 then
                     begin
                          h:=ft[y]+ft[x]-a[x,y-m];
                          if h<d then
                             d:=h;
                     end;
       for x:=1 to m do
           if pre[x]<>0 then
              ft[x]:=ft[x]-d;
       for y:=m+1 to m+m do
           if pre[y]<>0 then
              ft[y]:=ft[y]+d;
  end;
 procedure xuly;
  var
      i                 :               longint;
  begin
       for u:=1 to m do
           if tudo then
              begin
                   while not timthayduongtangcapghep do
                         suanhan;
                   tangcapghep;
              end;
       cl:=0;
       for i:=1 to n do
           cl:=cl+abs(h[i]-s[py[i]]);
  end;
 procedure output;
  var
      i                 :               longint;
  begin
       assign(f,fo);
       rewrite(f);
       writeln(f,cl);
       for i:=1 to n do
           write(f,py[i],' ');
       close(f);
  end;
 begin
      input;
      init;
      xuly;
      output;
 end.
