 uses crt;
 type mang=array[1..50,1..50] of integer;
 var max,a,front:mang;
     m,luu,n:byte;
     maxd:integer;
     f:text;

 procedure  readfile;
 var  i,j:byte;
 begin
   assign(f,'dan.dat');
   reset(f);
   readln(f,m,n);
   for i:=1 to m do
     for j:=1 to n do read(f,a[i,j]);
     close(f);
     writeln('INPUT:');
     for i:=1 to m do
      begin
       for j:=1 to n do write(a[i,j]:5);writeln;
       end;
  end;

  procedure  tim_hanh_trinh;
  var i,j:byte;
      luu1:array[1..50] of byte;
  begin
    fillchar(max,sizeof(max),0);
    front:=max;
    for i:=1 to n do max[1,i]:=a[1,i];
      for i:=2 to m do
       for j:=1 to n do
        begin  max[i,j]:=max[i-1,j]+a[i,j];front[i,j]:=j;
           if (j<n) and( max[i,j]<max[i-1,j+1]+a[i,j]) then
               begin max[i,j]:=max[i-1,j+1]+a[i,j]; front[i,j]:=j+1;end;
                if (j>1) and (max[i,j]<max[i-1,j-1] + a[i,j]) then
                  begin max[i,j]:=max[i-1,j-1]+a[i,j];front[i,j]:=j-1;end;
             end;
       writeln('OUTPUT:');
      maxd:=0;luu:=0;
      for  j:=1 to n do if max[m,j]>maxd then begin maxd:=max[m,j];luu:=j;end;
      writeln(maxd);maxd:=m;
     while  maxd>0 do
      begin
         luu1[maxd]:= luu;
         luu:=front[maxd,luu];
         dec(maxd);
       end;
       for i:=1 to m do writeln('[',i,'.',luu1[i],']');
  end;

    BEGIN clrscr;
    readfile;
    tim_hanh_trinh;
    readln
    END.
    7 5
    1 2 3 5 8
    4 6 3 6 3
    4 1 0 0 1
    4 5 6 7 9
    4 5 6 9 7
    1 9 7 5 1
    2 6 34 2 8