{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 16384,0,655360}

(*
        Bai Toan Nguoi Day hang  (m,n<=50 );
        Thau Toan: Duyet Theo chieu rong Hoac Chieu Sau
        Duoi Day La chuong Trinh Duyet:

                                  Theo Chieu Rong Doi Voi Hang
                                  Theo Chieu Sau  Doi Voi Nguoi

        Lap Trinh Vien :RONAlDO  Khoi Chuyen Toan Tin PBC*)

uses crt;
const b:array[0..4] of shortint=(0,0,-1,0,1);
      c:array[0..4] of shortint=(0,-1,0,1,0);
      fin='day_hang.inp';
      ch:array[0..4] of char=('o','$','#','%','*');
      cha:array[1..4] of char=('t','b','d','n');
type  mang  = array[0..50,0..50] of byte;
      logic = array[0..50,0..50,1..4] of boolean;
      data  = record
       d1,d2,d3,d4:shortint;
      end;
      mang1=array[1..10000] of integer;
var   a,a1,va:mang;
      m,n,x,y,u,x1,y1,v,s,t,d1,d2,dd,u1,v1,tx,ty,tt:integer;
      q:array[1..10000] of data;
      luu:^mang1;
      f:text;
      last,first:integer;
      chuaxet:logic;
      t1:longint  absolute 0:$46c;
      t2:longint;


procedure  readfile;
var   i,j:byte;
begin
     assign(f,fin);
     reset(f);
     readln(f,m,n);
     for i:=1 to m do
         begin
              for j:=1 to n do
                  begin
                       read(f,a[i,j]);
                       if a[i,j]=3 then begin x:=i;y:=j;end;
                       if a[i,j]=1 then begin u:=i;v:=j;end;
                       if a[i,j]=2 then begin s:=i;t:=j;end;
                  end;
              readln(f);
          end;
   close(f);
end;

 procedure  visit(i,j:byte);
 var  k:byte;
 begin
      for k:=1 to 4 do
          if ((i+b[k]) in [1..m]) and ((j+c[k]) in [1..n]) and (a1[i+b[k],j+c[k]]<2)  then
            if va[i+b[k],j+c[k]]=0 then
               begin
                    va[i+b[k],j+c[k]]:=k;
                    if (i+b[k]<>d1) or (j+c[k]<>d2) then visit(i+b[k],j+c[k])
                    else begin dd:=1;exit;end;
               end;
 end;

 procedure init1;
 begin
            x1:=x;y1:=y;u1:=u;v1:=v;
            new(luu);
            fillchar(luu^,sizeof(luu^),0);
            fillchar(q,sizeof(q),0);
            fillchar(chuaxet,sizeof(chuaxet),true);
            last:=0;first:=0;
 end;

 procedure init;
 var i,j:byte;
 begin
   a1:=a;
   a1[x1,y1]:=0;a1[u1,v1]:=0;
   a1[u,v]:=1;a1[x,y]:=3;
 end;

 function ok(k,p:byte):boolean;
 begin
          init;
          ok:=false;
          dd:=0;
          fillchar(va,sizeof(va),0);
          d1:=k;
          d2:=p;
          va[u,v]:=1;
          visit(u,v);
          if (dd>0) or (va[d1,d2]>0) then  ok:=true;
 end;

 procedure init2;
 var  i:byte;
 begin
     for i:=1 to 4 do
      if ((x+b[i]) in [1..m]) and ((y+c[i]) in [1..n]) and (a[x+b[i],y+c[i]]<>4) then
      if ((x-b[i]) in [1..m]) and ((y-c[i]) in [1..n]) and (a[x-b[i],y-c[i]]<>4) then
       begin
          if ok(x-b[i],y-c[i]) then
           begin
              inc(last);
              q[last].d1:=x+b[i];
              q[last].d2:=y+c[i];
              q[last].d3:=i;
              chuaxet[x+b[i],y+c[i],i]:=false;
           end;
       end;
 end;


 procedure get(i,j,k:byte);
 begin
      inc(last);
      q[last].d1:=i;
      q[last].d2:=j;
      q[last].d3:=k;
      luu^[last]:=first;
 end;

 procedure pop;
 begin
      inc(first);
      tx:=q[first].d1;
      ty:=q[first].d2;
      tt:=q[first].d3;
 end;

 procedure timduong(k,p:byte);
 var  kt:array[1..1000] of 1..4;
      dd1,i:integer;
 begin
          init;dd1:=0;
          fillchar(va,sizeof(va),0);
          d1:=k;
          d2:=p;
          va[u,v]:=10;
          visit(u,v);
          while va[d1,d2]<>10 do
           begin
               inc(dd1);
               kt[dd1]:=va[d1,d2];
               d1:=d1-b[kt[dd1]];
               d2:=d2-c[kt[dd1]];
           end;
           for i:=dd1 downto 1 do write(cha[kt[i]]);
 end;

 procedure xuat;
 var  dem,i:integer;
      sl:array[1..500] of 0..4 ;
 begin
      writeln('**********Solution*******');
      i:=last;dem:=1;
      fillchar(sl,sizeof(sl),0);
      while luu^[i]>0 do
       begin
         inc(dem);
         sl[dem]:=q[i].d3;
         i:=luu^[i];
       end;
       inc(dem);sl[dem]:=q[i].d3;
       u:=u1;v:=v1;x:=x1;y:=y1;
       writeln(dem);
       for i:=dem downto 2 do
         begin
              timduong(x-b[sl[i]],y-c[sl[i]]);
              write(upcase(cha[sl[i]]));
              u:=x;v:=y;
              x:=x+b[sl[i]];y:=y+c[sl[i]];
         end;
         writeln;
 end;

 procedure xuli;
 var  i:shortint;dk:boolean;
 begin
     t2:=t1;
     dk:=true;
     repeat
           pop;
           u:=tx-b[tt];
           v:=ty-c[tt];
           i:=1;
           while dk and (i<=4) do
                 begin
                    x:=tx;y:=ty;
                    if ((x+b[i]) in [1..m]) and ((y+c[i]) in [1..n]) and (a[x+b[i],y+c[i]]<>4) then
                    if ((x-b[i]) in [1..m]) and ((y-c[i]) in [1..n]) and (a[x-b[i],y-c[i]]<>4) then
                      if chuaxet[x+b[i],y+c[i],i] then
                        if ok(x-b[i],y-c[i]) then
                          begin
                               chuaxet[x+b[i],y+c[i],i]:=false;
                               get(x+b[i],y+c[i],i);
                               if (x+b[i]=s) and (y+c[i]=t) then
                                 begin
                                     xuat;
                                     dk:=false;
                                 end;
                          end;
                      inc(i);
                 end;
     until not dk or (last<first);
     if last<first-1 then writeln('***********No Solution********');
                        writeln('Total: ',((t1-t2)/18.21):6:6);
 end;

 begin  clrscr;
      readfile;
      init1;
      init2;
      xuli;
      dispose(luu);
      readln
 end.


5 8
0 0 4 0 4 0 0 0
0 0 4 0 4 0 0 0
0 0 0 0 0 0 0 0
4 3 4 0 4 0 4 0
4 1 4 0 4 2 4 0

 7 11
 0 0 0 0 0 4 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0
 2 0 0 0 0 0 0 0 0 0 0
 4 4 4 4 4 0 4 4 4 4 4
 0 0 0 0 0 0 0 0 0 0 0
 0 3 4 4 4 0 4 4 4 0 4
 0 0 1 0 4 0 0 0 0 0 0

 44 22
 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 4 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0
 4 4 4 4 4 0 4 4 4 0 4 0 0 4 4 4 0 0 4 4 0 4
 0 4 4 4 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 4 4 4 0 0 0 4 4 4 4 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 4 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0
 4 4 4 4 4 0 4 4 4 0 4 0 0 4 4 4 0 0 4 4 0 4
 0 4 4 4 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 4 4 4 0 0 0 4 4 4 4 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 4 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0
 4 4 4 4 4 0 4 4 4 0 4 0 0 4 4 4 0 0 4 4 0 4
 0 4 4 4 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 4 4 4 0 0 0 4 4 4 4 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 0 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 4 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0
 4 4 4 4 4 0 4 4 4 0 4 0 0 4 4 4 0 0 4 4 0 4
 0 4 4 4 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0
 4 0 0 0 3 0 0 0 0 0 0 4 4 4 4 4 0 4 4 4 0 4
 0 0 4 4 4 0 0 4 4 0 4 0 4 4 4 4 0 0 0 0 0 1
 0 0 0 0 0 0 0 0 0 0 0 4 4 4 0 0 0 4 4 4 4 0
