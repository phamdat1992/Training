uses crt;
const fin='tugiacma.inp';
      fou='tugiacma.out';
type  mang1=array[0..100] of real;
      mang2=array[0..50,0..50] of real;
var  a,b,c:mang1;
     sd1,sd2:mang2;
     m,n,luu1,luu2:byte;
     cr,cd:real;
     f:text;
     smax,pmax:real;


procedure readfile;
var i:byte;
begin
 writeln('INPUT:');
 fillchar(a,sizeof(a),0);
 b:=a;c:=a;
 assign(f,fin);
 reset(f);
 readln(f,m,n);
 writeln(m,'  ',n);
 cd:=0;cr:=0;
 for i:=1 to m do begin read(f,a[i]);cr:=cr+a[i];write(a[i]:4:0);a[i]:=a[i]+a[i-1];end;readln(f);writeln;
 for i:=1 to n do begin read(f,b[i]);cd:=cd+b[i];write(b[i]:4:0);b[i]:=b[i]+b[i-1];end;readln(f);writeln;
 for i:=1 to n do begin read(f,c[i]);write(c[i]:4:0);c[i]:=c[i]+c[i-1];end;writeln;readln(f);
 close(f);
end;

function sosanh(i:byte):byte;
var j:byte;ss1,ss2:real;
begin
 if b[i]>=c[i] then sosanh:=1
 else sosanh:=0;
end;

procedure  lap_mang1;
var i,j:byte;lines:real;
begin
 fillchar(sd1,sizeof(sd1),0);
 fillchar(sd2,sizeof(sd2),0);
 for i:=1 to m do sd1[1,i]:=a[i]-a[i-1];
 for i:=1 to n do
  begin
    lines:=sqrt(sqr(cr)+sqr(abs(b[i]-c[i])));
    for j:=1 to m do
     sd1[i+1,j]:=(a[j]-a[j-1])*lines/cr;
  end;
end;

procedure lap_mang2;
var  i,j:byte;l1,l2,lines:real;
     tg:real;
     b1,b2,k:byte;

begin
  for i:=1 to n do
   begin
     b1:=sosanh(i-1);b2:=sosanh(i);
     l1:=abs(b[i-1]-c[i-1]);
     l2:=abs(b[i]-c[i]);
     for j:=1 to m+1 do
      begin
       tg:=a[m-j+1];
       if (b1=1) and (b2=1) then  sd2[i,j]:=c[i]-c[i-1]+tg*(l2-l1)/cr;
       if (b1=1) and (b2=0) then  sd2[i,j]:=c[i]-c[i-1]-tg*(l1+l2)/cr;
       if (b1=0) and (b2=1) then  sd2[i,j]:=c[i]-c[i-1]+tg*(l1-l2)/cr;
       if (b1=0) and (b2=0) then  sd2[i,j]:=c[i]-c[i-1]+tg*(l1+l2)/cr;
      end;
   end;
end;

function  chu_vi(i,j:byte):real;
var p:real;
begin
  p:=0;
  p:=p+sd2[j,i]+sd1[j,i+1]+sd1[i,j]+sd1[i,j+1];
  chu_vi:=p;
end;

function dien_tich(i,j:byte):real;
var s:real;
begin
  s:=0;
  s:=(a[i]-a[i-1])*(sd2[j,i]+sd2[j,i+1])/2;
  dien_tich:=s;
end;

procedure  xuat;
var i:byte;
begin
 writeln('OUTPUT:');
 writeln('tu giac co dien tich lon nhat:  ',luu1:5,luu2:4);
 writeln('dien tich:                      ',smax:9:2);
 writeln('chu vi   :                      ',2*pmax:9:2);
end;

procedure  xu_li;
var   i,j:byte;s,p:real;
begin
 smax:=0;pmax:=0;
 for i:=1 to m do
  for j:=1 to n do
   begin
   s:=dien_tich(i,j);
   p:=chu_vi(i,j);
   if (s>smax) or ((s=smax) and (pmax<p)) then
     begin
      luu1:=i;
      luu2:=j;
      smax:=s;
      pmax:=p
     end
    end;
 end;


 procedure main;
 begin
  readfile;
  lap_mang1;
  lap_mang2;
  xu_li;
  xuat;
 end;

 BEGIN  CLRSCR;
   main;
   readln
 END.

 4 5
 2 3 4 5
 1 3 6 7 9
 2 2 5 4 13
 3 3
 2 2 2
 3 2 4
 3 2 4
 2 3
 3 3
 4 3 4

 2 7 2
 3 3
 2 2 4
 8 4 2
 8 4 2
 9 10
 3 7 5 9 8 11 12 5 6
 6 9 8 7 5 4 13 16 21 13
 7 6 5 13 16 13 21 9  8 4
 3 4
 6 6 4
 5 24 6 9
 16 9 9 4

















