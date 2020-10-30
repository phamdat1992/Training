 uses crt;
 type  mang=array[1..50,1..50] of byte;
     const
     lim1:array[1..4] of shortint=(0,-1,0,1);
     lim2:array[1..4] of shortint=(-1,0,1,0);
     ch  :array[1..4] of char=('W','N','E','S');
 var a,va:mang;
     b,tx:array[1..50,1..50,1..4] of byte;
     q:array[1..500,1..2] of byte;
     sl:array[1..20] of byte;
     qh:array[0..10,0..10] of boolean;
     m,n,last,pop,dem :byte;
     f:text;

 procedure  readfile;
 var  i,j:byte;
 begin
   fillchar(b,sizeof(b),0);
   assign(f,'castle.inp');
   reset(f);
   fillchar(qh,sizeof(qh),false);
   readln(f,m,n);
   writeln('INPUT:');
   writeln(m:4,n:4);
   for i:=1 to m do
    begin
    for j:=1 to n do begin  read(f,a[i,j]);write(a[i,j]:4);end;
    writeln;
    end;
   close(f);
  end;

  procedure tao_mang;
  var  i,j,d:byte;
  begin
   for i:=1 to m do
    for j:=1 to n do
     begin
        if a[i,j] mod 2=1 then b[i,j,1]:=1;
        if (a[i,j] mod 4=2) or (a[i,j] mod 4=3) then b[i,j,2]:=1;
        if (a[i,j]>=12) or ((a[i,j]>=4) and(a[i,j]<=7)) then b[i,j,3]:=1;
        if a[i,j]>=8 then b[i,j,4]:=1;
      end;
   end;

   procedure get(i,j:byte);
   begin
     inc(last);
     q[last,1]:=i;
     q[last,2]:=j;
   end;

   procedure visit;
   var x,y,i,j:byte;
   begin
    pop:=0;
    repeat
     inc(pop); x:=q[pop,1];
     y:=q[pop,2];va[x,y]:=dem;
     for i:=1 to 4 do
     begin
       if i<3 then j:=2+i
       else j:=i-2;
       if (x+lim1[i]>0) and (x+lim1[i]<=m) and(y+lim2[i]>0) and(y+lim2[i]<=n) then
       begin
       if (b[x,y,i]=0) and(b[x+lim1[i],y+lim2[i],j]=0) and (va[x+lim1[i],y+lim2[i]]=0)
       then  get(x+lim1[i],y+lim2[i]);
       if (b[x,y,i]=1) and (va[x+lim1[i],y+lim2[i]]<>dem) and (va[x+lim1[i],y+lim2[i]]>0) then
       begin
         qh[dem,va[x+lim1[i],y+lim2[i]]]:=true;
         tx[dem,va[x+lim1[i],y+lim2[i]],1]:=x;
         tx[dem,va[x+lim1[i],y+lim2[i]],2]:=y;
         tx[dem,va[x+lim1[i],y+lim2[i]],3]:=i;
       end;
     end;
    end;
     until pop>=last;
     sl[dem]:=last;
   end;

   procedure loang;
   var  i,j,maxd,luu1,luu2:byte;
   begin
     dem:=0;
     fillchar(va,sizeof(va),0);
     for i:=1 to m do
      for j:=1 to n do
       if va[i,j]=0 then
         begin
                inc(dem);last:=1;
                q[last,1]:=i;q[last,2]:=j;
                visit;
          end;
          writeln('OUTPUT:');
          maxd:=0;
          for i:=1 to dem do
           if sl[i]>maxd then  maxd:=sl[i];
          writeln(dem);
          writeln(maxd);
          maxd:=0;
          for i:=1 to dem do
           for j:=1 to dem do
            if (qh[i,j]=true) and(sl[i]+sl[j]>maxd) then
            begin
            maxd:=sl[i]+sl[j];
            luu1:=i;
            luu2:=j;
            end;
            writeln(tx[luu1,luu2,1],'  ',tx[luu1,luu2,2],'  ',ch[tx[luu1,luu2,3]]);
   end;

   begin  clrscr;
   readfile;
   tao_mang;
   loang;
   readln
   end.
   4 7
   11 6  11 6  3  10 6
   7  9  6  13 5  7 5
   1  10 12 15  13 5  5
   13 11 14 11  10 12 13

