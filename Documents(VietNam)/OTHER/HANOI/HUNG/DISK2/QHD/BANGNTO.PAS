{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S=,T-,V+,X+}
{$M 16384,0,655360}
 uses crt;
 type mang=array[1..50,1..50] of integer;
 var  a,b,q,va:mang;
 sl1:array[1..40] of byte;
      f:text;
      n,maxd,maxxa,last,dem,d1,maxxa1:byte;
      luu1:array[1..2,0..4] of byte;

 procedure  readfile;
 var   i,j,d,d2:byte;
 begin
 maxxa:=0;
  assign(f,'inp.bnt');
  reset(f);
  readln(f,n);
  writeln(n);
  maxd:=0;
  for i:=1 to n do
   for j:=1 to n do
   begin
   read(f,a[i,j]);
   if a[i,j]>maxd then maxd:=a[i,j];
   end;
  close(f);
  for i:=1 to n do
   begin for j:=1 to n  do  write(a[i,j]:4);writeln;
   end;
   maxxa1:=0;
  end;

  procedure tao_mang;
  type mangs=array[0..40] of byte;
  var  i,j:byte;
       s:mangs;
       t:array[0..40] of mangs;
       dd:set of byte;
       const
       nt:array[1..12] of byte=(2,3,5,7,11,13,17,19,23,29,31,37);

     function  oko(i,j:byte):boolean;
     var k2,k1,k:byte;
     dd1:boolean;
     begin
       oko:=false;k:=1;dd1:=true;
      while (k<=t[j][0]) and dd1 do
       begin
             if t[j][k]=i then dd1:=false;
             inc(k);
       end;
      if dd1=false then
       for k2:=1 to t[j][0] do
        for k1:=1 to t[j][0] do
        if k1<>k2 then
         if t[j][k2]=t[j][k1] then exit;
       oko:=true;
     end;
     begin
       fillchar(b,sizeof(b),0);fillchar(s,sizeof(s),0);
       fillchar(t,sizeof(t),0);s[0]:=0; s[1]:=0; s[2]:=1;
       t[2][0]:=1;t[2][1]:=2;s[3]:=1; t[3][0]:=1;t[3][1]:=3;
       for i:=4 to maxd  do
        for j:=1 to 12 do
         if nt[j]<=i-2 then
          if oko(nt[j],i-nt[j]) then
           if s[i]<s[i-nt[j]]+1 then
            begin
                  s[i]:=s[i-nt[j]]+1;t[i]:=t[i-nt[j]];
                  inc(t[i][0]);      t[i][t[i][0]]:=nt[j];
             end;
       readln;clrscr;
       writeln('output:');
       writeln('mang chuyen la:');
       for i:=1 to n do
        begin
        for j:=1 to n do begin b[i,j]:=s[a[i,j]];write(b[i,j]:4);end;
        writeln;
        end;
   end;


  procedure  get(i,j:byte);
  begin
    inc(last); q[last,1]:=i;q[last,2]:=j;
   end;

  procedure  visit;
  var k1,k2,i,j,pop,xmax,xmin,ymax,ymin:integer;
   begin
    xmax:=1;ymax:=1;xmin:=1000;ymin:=1000;pop:=0;
    repeat
    inc(pop);i:=q[pop,1];j:=q[pop,2];
    if i>xmax then xmax:=i; if i<xmin then xmin:=i;
    if j<ymin then ymin:=j; if j>ymax then ymax:=j;
    for k1:=-1 to 1 do
     for k2:=-1 to 1 do
      if (i+k1<=n) and (j+k2<=n) and (i+k1>0) and (j+k2>0) and ((k1<>0) or (k2<>0))
      and (b[i+k1,j+k2]=b[i,j]) and(va[i+k1,j+k2]=0) then
      begin
      get(i+k1,j+k2);va[i+k1,j+k2]:=dem;
      end;
     until pop>=last;
     sl1[dem]:=last;
      if (xmax-xmin+1)*(ymax-ymin+1)=sl1[dem] then
        if sl1[dem]> maxxa1 then
       begin
       luu1[1,1]:=xmax;luu1[1,2]:=xmin;
       luu1[1,3]:=ymax;luu1[1,4]:=ymin;
       luu1[1,0]:=dem;maxxa1:=sl1[dem];
       end;
       if sl1[dem]>maxxa then
        begin
            luu1[2,1]:=xmax; luu1[2,2]:=xmin;
            luu1[2,3]:=ymax; luu1[2,4]:=ymin;
            luu1[2,0]:=dem;  maxxa:=sl1[dem];
        end;
  end;


  procedure dem_lien_thong ;
  var i,j,t,k1,k2:integer;
  begin
    dem:=0;d1:=0;
    for i:=1 to n do
     for j:=1 to n do
      if (va[i,j]=0) then
        begin
          inc(dem);last:=1;
          q[last,1]:=i; q[last,2]:=j;
          va[i,j]:=dem;visit;
       end;
       write('OUTPUT 1:');
       writeln('so mien trong hinh la:',dem);
       for i:=1 to n do
        begin
        for j:=1 to n do
          write(va[i,j]:4);
          writeln;
         end;
         readln;d1:=0;
        writeln('OUTPUT 2:');
        writeln(' mien la hinh chu nhat la lon nhat la:',luu1[1,0]);
        writeln('so o la:',sl1[luu1[1,0]]);
        writeln(' toa do la :[',luu1[1,1],'.',luu1[1,3],']',' [',luu1[1,2],'.',luu1[1,4],']');
         writeln('OUTPUT 3:');
         writeln('mien co nhieu o nhat la mien :',luu1[2,0]);
         writeln('so o thuoc mien la:',sl1[luu1[2,0]]);
         writeln('cac o thuoc mien la:');
         d1:=0;
         for i:=1 to n do
           for j:=1 to n do
            if va[i,j]=luu1[2,0] then
            begin
            inc(d1);write(' [',i,'.',j,']  ');
            if d1 mod 4=0 then writeln;
            end;
         writeln('no duoc bao boi hinh chu nhat co toa do dinh tren phai va duoi traila:');
        writeln('[',luu1[2,1],luu1[2,3],']','[',luu1[2,2],luu1[2,4],']');
   end;

  BEGIN  clrscr;
  readfile;
  tao_mang;
  dem_lien_thong;
  readln
  END.
  6
  5 6 7 8 9 6
  4 5 6 12 13 14
  2 3 4 5 8 9
 34 3 5 4 6 10
  2 3 6 5 4 7
  3 6 5 4 7 7















