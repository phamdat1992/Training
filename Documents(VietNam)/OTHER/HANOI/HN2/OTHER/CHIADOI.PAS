  uses crt;
  type  mang=array[0..30,0..30] of integer;
  var a,t,fb:array[1..2] of mang;
      m,n,i:byte;
      f:text;
      tongd,tong,tong1:integer;
      luu,luu1:array[0..30] of byte;

  procedure  readfile;
  var  i,j:byte;
       tong:integer;
  begin
     tong:=0;
     assign(f,'chiadoi.inp');
     reset(f);
     writeln('INPUT:');
     readln(f,m,n);
     for i:=1 to m do
     begin
     for j:=1 to n do begin read(f,a[1][i,j]);inc(tong,a[1][i,j]);write(a[1][i,j]:4);end;
     writeln;
     end;
     close(f);
     READLN;
     for i:=1 to m do
     begin for j:=1 to n do
     begin a[2][i,j]:=a[1][i,n-j+1]; write(a[2][i,j]:4);end;writeln;
     end;
     tongd:=tong div 2;
     tong1:=tong;
   end;

  procedure taomang(d:byte);
  var i,j,k:byte;
  begin
     fillchar(t,sizeof(t),0);
     for i:=1 to m do
      begin
         for j:=0 to n do
           for k:=1 to j do inc(t[d][i,j],a[d][i,k]);
      end;
  end;

  procedure  xuli(d:byte);
  var i,j,k:byte;
  begin
    fillchar(fb[d],sizeof(fb[d]),0);
    fillchar(luu,sizeof(luu),0);
     for i:=1 to m do
      for j:=1 to n do
       for k:=0 to n do
        if (fb[d][i-1,j]+t[d][i,k]<=tongd) then
         if (fb[d][i,j]=0) or (fb[d][i,j]<fb[d][i-1,j]+t[d][i,k]) then
          begin
                 fb[d][i,j]:=fb[d][i-1,j]+t[d][i,k];
                 luu[i]:=k;
          end;
   end;

  BEGIN  clrscr;
  readfile;
  taomang(1);
  xuli(1);
  luu1:=luu;
  taomang(2);
  xuli(2);
  CLRSCR;
  WRITELN('OUPUT:');
  write('chenh lech nho nhat la:');
   if abs(2*fb[1][m,n]-tong1) >abs(2*fb[2][m,n]-tong1) then
   begin
    write(abs(2*fb[2][m,n]-tong1):4);
    writeln;
    for i:=1 to m do
     writeln(luu[i]);
    end
    else
    begin
     write(abs((2*fb[1][m,n])-tong1):4);
     writeln;
    for i:=1 to m do writeln(luu1[i]) ;
    end;
  readln
  END.

  10 10
  2 2 1 2 1 2 1 2 5 9
  1 2 1 2 8 8 6 8 2 0
  2 2 5 4 3 8 5 1 6 2
  1 1 8 7 5 7 3 6 1 8
  2 2 1 2 1 2 1 2 5 9
  1 2 1 2 8 8 6 8 2 0
  2 2 5 4 3 8 5 1 6 2
  1 6 3 5 4 7 8 2 4 6
  5 9 3 5 7 4 6 5 1 7
  5 3 7 9 5 1 6 4 8 2