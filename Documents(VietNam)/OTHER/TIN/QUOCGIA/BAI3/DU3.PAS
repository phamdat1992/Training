{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program  bai4;
 const fi='count.inp';
       fo='cuont.out';
       max=16000;
       maxl=3;
 type
       pt=0..(max+1);
       pl=1..maxl;
       mang=array[pt]of byte;
       mang1=array[pt]of integer;
       mang2=array[pl]of integer;
 var
       D:mang;
       F:Mang1;
       luu:mang2;
       n,m:integer;
       fd,fg:text;
       time:longint absolute $0000:$0046c;
       ts:longint;
 procedure nhap;
   var i,j:integer;
       l,k:integer;
       maxd:integer;
       lmax:integer;
    begin
       assign(fd,fi); reset(fd);
       assign(fg,fo); rewrite(fg);
       readln(fd,n);
       for i:=1 to n do d[i]:=0;
       for i:=1 to n do f[i]:=i;
       d[n+1]:=1;f[n+1]:=0;d[0]:=1;f[0]:=0;
       maxd:=n;lmax:=n;
        while not seekeof(fd) do
          begin
             l:=0;
             while not seekeoln(fd) do
               begin
                 inc(l);
                 read(fd,luu[l]);
               end;
             if l=3 then
               begin
                  if luu[1]=1 then
                    begin
                      for k:=luu[2] to n do
                         begin
                          if k<luu[2]+luu[3] then
                            begin
                                d[k]:=1;
                                f[k]:=0;
                            end
                           else
                               if d[k]=0 then f[k]:=f[k-1]+1;
                          end;
                       maxd:=0;
                      for k:=1 to luu[2]-1 do if f[k]>maxd then maxd:=f[k];
                      for k:=luu[2]+luu[3] to n do if f[k]>maxd then maxd:=f[k];
                  end
                  else
                  if luu[1]=2 then
                    begin
                      for k:=luu[2] to n do
                       begin
                         if ((k<luu[2]+luu[3])and(k<=n)) then  d[k]:=0;
                         if d[k]=0 then  f[k]:=f[k-1]+1;
                       end;
                      Maxd:=0;
                      for k:=1 to n do
                      if f[k]>maxd then maxd:= f[k];
                    end;
               end
             else
             if l=1 then writeln(fg,maxd);
             readln(fd);
          end;
       close(fd);close(fg);
    end;
 begin
      ts:=time;
     nhap;
     writeln((time-ts)/18.2:0:4);
     readln;
 end.
