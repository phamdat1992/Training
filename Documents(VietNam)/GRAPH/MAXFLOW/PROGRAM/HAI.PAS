{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program mang_truyen_tin;
 const
      fi                =               'net.inp';
      fo                =               'net.out';
      nmax              =               100;
 type
      data1             =               array [1..nmax, 1..nmax] of byte;
      data2             =               array [1..nmax] of integer;
      data3             =               array [1..nmax, 1..nmax] of byte;
 var
      f                 :               text;
      a, fx             :               data1;
      q, pre            :               data2;
      count             :               integer;
      chon              :               data3;
      cat               :               data3;
      dem               :               integer;
      tl, tr, tm, te    :               integer;
      n, s, t, k        :               integer;
 procedure input;
  var
      u, v, i, c        :               integer;
  begin
       assign(f,fi);
       reset(f);
       readln(f,n);
       readln(f,k);
       for i:=1 to k do
           begin
                readln(f,u,v,c);
                a[u,v]:=c;
                a[v,u]:=c;
           end;
       readln(f,s,t);
       close(f);
  end;
 procedure init;
  begin
       tl:=0;
  end;
 function find_path:boolean;
  var
      first, last, u, v :               integer;
  begin
       fillchar(pre, sizeof(pre), 0);
       first:=1;
       last:=1;
       pre[s]:=s;
       q[1]:=s;
       while first<=last do
             begin
                  u:=q[first];
                  inc(first);
                  for v:=1 to n do
                      if (pre[v]=0) then
                         begin
                              if (a[u,v]>0) and (fx[u,v]<a[u,v]) then
                                 begin
                                      inc(last);
                                      q[last]:=v;
                                      pre[v]:=u;
                                 end;
                              if (a[v,u]>0) and (fx[v,u]>0) then
                                 begin
                                      inc(last);
                                      q[last]:=v;
                                      pre[v]:=-u;
                                 end;
                         end;
             end;
       find_path:=not (pre[t]=0);
  end;
 procedure tang_luong;
  var
      min, nho          :               integer;
  begin
       min:=maxint;
       nho:=t;
       while nho<>s do
             begin
                  if pre[nho]>0 then
                     begin
                          if (a[pre[nho],nho]-fx[pre[nho],nho])<min then
                             min:=a[pre[nho],nho]-fx[pre[nho],nho];
                     end
                  else
                     begin
                          if fx[nho,abs(pre[nho])]<min then
                             min:=fx[nho,abs(pre[nho])];
                     end;
                  nho:=abs(pre[nho]);
             end;
       nho:=t;
       while nho<>s do
             begin
                  if pre[nho]>0 then
                     inc(fx[pre[nho],nho],min)
                  else
                     dec(fx[nho,abs(pre[nho])],min);
                  nho:=abs(pre[nho]);
             end;
  end;
 function find_path_inc_flow:boolean;
  var
      u, v, first, last :               integer;
  begin
       fillchar(pre, sizeof(pre), 0);
       first:=1;
       last:=1;
       q[1]:=s;
       pre[s]:=s;
       while first<=last do
             begin
                  u:=q[first];
                  inc(first);
                  for v:=1 to n do
                      if pre[v]=0 then
                         begin
                              if (a[u,v]>0) and (fx[u,v]<tm) then
                                 begin
                                      inc(last);
                                      q[last]:=v;
                                      pre[v]:=u;
                                 end;
                              if (a[v,u]>0) and (fx[v,u]>0) then
                                 begin
                                      inc(last);
                                      q[last]:=v;
                                      pre[v]:=-u;
                                 end;
                         end;
             end;
       find_path_inc_flow:=not (pre[t]=0);
  end;
 procedure inc_flow;
  var
      min, nho          :               integer;
  begin
       min:=maxint;
       nho:=t;
       while nho<>s do
             begin
                  if pre[nho]>0 then
                     begin
                          if (tm-fx[pre[nho],nho])<min then
                             min:=tm-fx[pre[nho],nho];
                     end
                  else
                     begin
                          if fx[nho,abs(pre[nho])]<min then
                             min:=fx[nho,abs(pre[nho])];
                     end;
                  nho:=abs(pre[nho]);
             end;
       nho:=t;
       while nho<>s do
             begin
                  if pre[nho]>0 then
                     inc(fx[pre[nho],nho],min)
                  else
                     dec(fx[nho,abs(pre[nho])],min);
                  nho:=abs(pre[nho]);
             end;
  end;
 function luong:boolean;
  var
      i, j              :               integer;
  begin
       count:=0;
       fillchar(fx, sizeof(fx), 0);
       fillchar(chon, sizeof(chon), 0);
       while find_path_inc_flow do
             inc_flow;
       te:=0;
       for i:=1 to n do
           if pre[i]<>0 then
              for j:=1 to n do
                  if pre[j]=0 then
                     begin
                          if a[i,j]>te then
                             te:=a[i,j];
                          if a[i,j]>0 then
                             begin
                                  inc(count);
                                  chon[i,j]:=1;
                             end;
                     end;
       luong:=false;
       if tr>te then
          begin
               luong:=true;
               cat:=chon;
               dem:=count;
          end
       else
          if (tr=te) and (count<dem) then
             begin
                  dem:=count;
                  cat:=chon;
             end;
  end;
 procedure xuly;
  var
      i, j              :               integer;
  begin
       fillchar(fx, sizeof(fx), 0);
       while find_path do
             tang_luong;
       tr:=0;
       dem:=0;
       fillchar(cat, sizeof(cat), 0);
       for i:=1 to n do
           if pre[i]<>0 then
              for j:=1 to n do
                  if pre[j]=0 then
                     begin
                          if a[i,j]>tr then
                             tr:=a[i,j];
                          if a[i,j]>0 then
                             begin
                                  inc(dem);
                                  cat[i,j]:=1;
                             end;
                     end;
       tm:=(tl+tr) div 2 +1;
       repeat
             if luong then
                begin
                     tr:=te;
                     tm:=(tl+tr) div 2 +1;
                end
             else
                begin
                     tl:=tm;
                     tm:=(tl+tr) div 2 +1;
                end;
       until (tl=tr);
  end;
 procedure output;
  var
      i, j              :               integer;
  begin
       assign(f,fo);
       rewrite(f);
       writeln(f,dem);
       for i:=1 to n do
           for j:=1 to n do
               if cat[i,j]=1 then
                  writeln(f,i,' ',j);
       close(f);
  end;
 begin
      input;
      init;
      xuly;
      output;
 end.
