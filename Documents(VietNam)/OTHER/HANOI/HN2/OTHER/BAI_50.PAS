{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

  uses crt;
  type mang=array[1..5] of shortint;
       mang1=array[1..5,1..5] of shortint;
  var  fb:array[1..5,1..5] of shortint;
       a:array[1..800] of mang;
       dem,l1,l2,d,k:integer;
       f,f1:text;
       t1:longint absolute 0:$46c;
       t2:longint;

  procedure  readfile;
  var  i:integer;
  begin
        k:=1;dem:=0;
        fillchar(a,sizeof(a),0);
        fillchar(fb,sizeof(fb),0);
        assign(f,'bai_50.inp');
        reset(f);
        readln(f,l1,l2);
   end;

procedure  writearray;
var i,j:byte;
begin
 for i:=1 to 5 do
  if fb[1,i]<>fb[i,1] then
   begin
   inc(d);
   writeln('mang thu  ',d );
 for i:=1 to 5 do
  begin
    for j:=1 to 5 do write(fb[j,i]:3);
    writeln;
  end;
  exit;
  end;
end;

function  nto(b:mang):boolean;
var i,tong:longint;
begin
  nto:=false;
  tong:=0;
  for i:=1 to 5 do
  tong:=(tong*10)+b[i];
  for i:=2 to trunc(sqrt(tong)) do
     if  tong mod i=0 then exit;
  nto:=true;
 end;

 function ngto(tong:longint):boolean;
 var i:longint;
 begin
 ngto:=false;
 for i:=2 to trunc(sqrt(tong)) do
     if  tong mod i=0 then exit;
  ngto:=true;
 end;

 procedure taomang;
 var b:mang;
     i:byte;
     f1:text;
 begin
  assign(f1,'bai_50.data');
  rewrite(f1);
  for b[1]:=1 to 9 do
   for b[2]:=0 to 9 do
    for b[3]:=0 to 9 do
      for b[4]:=0 to 9 do
       for b[5]:=0 to 9 do
         if (b[1]+b[2]+b[3]+b[4]+b[5]=l2) and nto(b) then
          begin
              inc(dem);a[dem]:=b;
              for i:=1 to 5 do write(f1,a[dem][i]);writeln(f1);
          end;
     close(f1);
  end;

   procedure  xuat;
   var  i,j:1..5;
   begin
     inc(d);
     writeln('mang thu  ',d);
     for i:=1 to 5 do
      begin  for j:=1 to 5 do  write(fb[i,j]:3);
      writeln;
      end;
     writeln;
     writearray;
   end;

  function  logic(i:byte):boolean;
  var j:byte;s1,s2:longint;
  begin
   s1:=0;
   for j:=1 to 5 do
    s1:=s1*10+a[i][j];
   s2:=0;
   for j:=1 to 5 do
    s2:=s2*10+fb[1,j];
   if s1>=s2 then logic:=true
   else logic:=false;
  end;

  procedure dien(i:byte);
  var j:byte;
  begin
   if k mod 2=0 then
    begin
    for j:=1 to 5 do
     fb[j,k div 2]:=a[i][j];
     end
   else
   begin
    for j:=1 to 5 do
     fb[(k+1) div 2,j]:=a[i][j];
   end;
  end;

  procedure xoa;
  var j:byte;
  begin
    if k mod 2=0 then
     begin
      for j:=5 downto 5-k div 2 do
       fb[j,k div 2]:=0;
      if k=4 then fb[3,3]:=0;
     end
    else
     begin
       if k<=3 then
        for j:=2 to 5 do fb[(k+1) div 2,j]:=0;
       if k=5 then
        for j:=3 to 5 do fb[3,j]:=0;
     end;
  end;

  function ok(i:byte):boolean;
  var  j,luu:byte;s:longint;
  begin
   ok:=false;
     if k=2 then
   if not logic(i) then exit;
   if k<=2 then
   for j:=1 to 5 do if a[i][j]=0 then exit;
   if k mod 2=0 then
    begin
     for j:=1 to k div 2 do
       if fb[j,k div 2]<>a[i][j] then exit;
        if k=4 then
         begin
          fb[3,3]:=l2-fb[1,5]-fb[2,4]-a[i][4]-fb[5,1];
          if fb[3,3]<0 then begin fb[3,3]:=0;exit;end
	  else
	  begin
    	   s:=0;
           fb[4,2]:=a[i,4];
          for j:=1 to 5 do
           s:=s*10+fb[6-j,j];
          if not(ngto(s)) then begin fb[4,2]:=0;fb[3,3]:=0;exit;end;
          end;
         end;
     end
   else
    begin
     if k<=3 then luu:=1
     else luu:=3;
     for j:=1 to luu do
      if fb[(k+1) div 2,j]<>a[i][j] then exit;
    end;
   ok:=true;
end;

 function chap_nhan:boolean;
 var  i,j,s1,s2:byte;
 begin
  chap_nhan:=false;
  for i:=1 to 5 do
   begin
    s1:=0;s2:=0;
    for j:=1 to 5 do
     begin
        s1:=s1+fb[i,j];
        s2:=s2+fb[j,i];
    end;
    if (s1>l2) or (s2>l2) then exit;
   end;
   chap_nhan:=true;
 end;

 procedure giai_toa;
 begin
  fb[4,5]:=0;fb[5,4]:=0;fb[5,5]:=0;fb[4,4]:=0;
 end;

  procedure ghi_nhan;
  var x,y,z,t,j:integer;
      s:array[1..5] of longint;
  begin
     fillchar(s,sizeof(s),0);
     x:=0;y:=0;z:=0;t:=0;
     for j:=1 to 3 do
      begin
        x:=x+fb[4,j]; y:=y+fb[j,5];
        z:=z+fb[j,j]; t:=t+fb[j,4];
      end;
      x:=l2-x;y:=l2-y;z:=l2-z;t:=l2-t;
      if (x-y+z>=0) and not(odd(x-y+z)) then
       begin
         j:=(x-y+z) div 2;
         y:=x-j;
         z:=z-j;
         t:=t-j;
         x:=j;
     if (x>=0) and (y>0) and (z>0) and (t>0) then
      begin
         fb[4,4]:=x;fb[4,5]:=y;
         fb[5,4]:=t;fb[5,5]:=z;
         for j:=1 to 5 do
          begin
           s[1]:=s[1]*10+fb[j,j];
           s[2]:=s[2]*10+fb[4,j];
           s[3]:=s[3]*10+fb[5,j];
           s[4]:=s[4]*10+fb[j,4];
           s[5]:=s[5]*10+fb[j,5];
          end;
          for j:=1 to 5 do
           if not (ngto(s[j])) then
            begin
             giai_toa;
             exit;
            end;
        xuat;
       end;
      end;
   end;

   procedure  try;
   var  i,d,d1:byte;
   begin
     for i:=1 to dem do
       if ok(i) then
         begin
              dien(i);
              inc(k);
             if chap_nhan then
	     begin
	     if k>6 then ghi_nhan
             else
              try;
             end;
             dec(k);
             xoa;
         end;
   end;
  begin  clrscr;
  writeln('PROGRAM RUNNING:');
  assign(f1,'bai_50.out');
  rewrite(f1);
  readfile;
  taomang;
  t2:=t1;
  fillchar(fb,sizeof(fb),0);
  fb[1,1]:=l1;
  try;
  if d=0 then writeln('khong dien duoc mang');
  writeln('PROGRAM FINISHED:');
  writeln('TIME RUN: ',((T1-T2)/18.21):0:6);
  close(f1);
  readln;
  end.



