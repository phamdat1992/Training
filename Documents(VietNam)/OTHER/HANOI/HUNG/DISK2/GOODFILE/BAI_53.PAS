{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

 (* mot hinh tron duoc chia thanh n hinh quat n<=6,dien cac so vao cac hinh quat
    sao cho kich thuoc cua hinh tron la lon nhat,cac so lon hon k,va kich thuoc
    bat dau tu m,m,k<=20*)

 uses crt;
 type mang=array[0..12] of 0..25;
 var a:mang;
     kt,bestkt,u,kl:word;
     m,n,k:byte;
     dk:array[0..51] of boolean;
     f1:text;

 procedure readfile;
 var f:text;
 begin
   assign(f,'bai_53.inp');
   reset(f);
   readln(f,n,m,k);
   close(f);
 end;

 procedure kich_thuoc;
 var  s:word;
      i,j,k:byte;
      a1:mang;
 begin
  kt:=0;a1:=a;
  for i:=n+1 to 2*n-1 do a1[i]:=a1[i-n];
  for i:=1 to m+(n-1)*n do dk[i]:=false;
  for i:=1 to n do
   for j:=1 to n do
    begin
     s:=0;
     for k:=j to i+j-1 do s:=s+a1[k];
     dk[s]:=true;
    end;
    i:=m;
    while dk[i] do inc(i);
    kt:=i-1;
 end;

{ procedure writefile;
 var i:byte;
 begin
  writeln(f1);
  for i:=1 to n do write(f1,a[i]:5);
 end; }

 procedure ghi_nhan;
 var i,j:integer;
 begin
   kich_thuoc;
    if kt>=bestkt then
     begin
      if kt=bestkt then begin
      writeln(f1);
      for i:=1 to n do write(f1,a[i]:5);end
     else
      begin
       bestkt:=kt;
       rewrite(f1);
       writeln(f1,bestkt);
       for i:=1 to n do write(f1,a[i]:5);
     end;
    end;
end;

 procedure can;
 var i,s,j:integer;
 begin
   u:=1+m+(n-1)*n;
   for i:=1 to u do dk[i]:=false;
   for i:=1 to kl do
   begin
    s:=0;
    for j:=i to kl do
     begin
      s:=s+a[j];
      if s<=u then dk[s]:=true;
     end;
   end;
   i:=n-kl-1;
   i:=i*n-(i*(i+2)) div 2+1;
   u:=m;
   while i<>0 do
    begin
     while dk[u] do inc(u);
     inc(u);
     dec(i);
    end;
  end;

 procedure try;
 var j:word;
 begin
   if kl=n then ghi_nhan
   else
    begin
    can;
    for j:=a[1] to u do
     begin
      inc(kl);
      a[kl]:=j;
      try;
      dec(kl);
     end;
    end;
 end;

 procedure main;
 var i,j:byte;
 begin
 readfile;
 assign(f1,'bai_53.out');
 rewrite(f1);
 bestkt:=m+n-1;
 for i:=k to m do
 begin
  fillchar(a,sizeof(a),0);
  kt:=0;
  kl:=1;
  a[1]:=i;
  try;
 end;
 close(f1);
end;

 begin  clrscr;
 main;
 end.
 6 2 1





