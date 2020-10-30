uses crt;
const  fi='san.inp';
       fo='san.out';
type   toado=record
          x,y:real;
       end;
var    a:array[0..2000] of toado;
       n,luu,m:integer;
       b:array[1..2000] of word;
       ok:array[1..2000] of boolean;
       f:text;
procedure init;
begin
      fillchar(a,sizeof(a),0);
      fillchar(b,sizeof(b),0);
end;

procedure  readfile;
var  i:word;
begin
      luu:=0;
      assign(f,fi);
      reset(f);
          readln(f,n);
          for i:=1 to n do
		        readln(f,a[i].x,a[i].y);
      close(f);
end;

 function theta(i,j:integer):real;
 var  px1,px2,py1,py2,t:real;
 begin
 px1:=a[j].x-a[i].x;
 py1:=a[j].y-a[i].y;
 px2:=abs(px1);py2:=abs(py1);
 if (px1=0) and (py1=0) then t:=0
 else
  begin
    t:=py1/(px2+py2);
    if px1<0 then t:=2-t
    else  if py1<0 then t:=4+t;
  end;
  theta:=t*90.0;
  end;

procedure  boc_goi;
var  mins,maxs:real;
     dem,i:integer;
begin
    luu:=1;
    for i:=2 to n do
    if a[i].y< a[luu].y then  luu:=i;
    dem:=1;b[dem]:=luu;a[n+1]:=a[luu]; maxs:=0;
    repeat
        inc(dem);
        mins:=maxs;
        maxs:=360;
        for i:=1 to n+1 do
           if (theta(luu,i)<=maxs) and (theta(luu,i)>mins) then
             begin
	               maxs:=theta(luu,i);
			       b[dem]:=i;
             end;
       luu:=b[dem];
    until (a[luu].x=a[n+1].x) and (a[luu].y=a[n+1].y);
    m:=dem;
end;

procedure  duong_thang( var ta,tb,tc:real;td1,td2:toado);
begin
      ta:=td2.y-td1.y;
      tb:=td1.x-td2.x;
      tc:=td2.x*td1.y-td2.y*td1.x;
end;

function kc1(ta,tb,tc:real;td:toado):real;
begin
       kc1:=abs(td.x*ta+td.y*tb+tc)/sqrt(sqr(ta)+sqr(tb))
end;

function  kc2(ta,tb,tc:real;ti,tj:toado):real;
var  w,z:real;
begin
      w:=sqr(ti.x-tj.x)+sqr(ti.y-tj.y);
      kc2:=sqrt(w-sqr(kc1(ta,tb,tc,ti)));
end;

function chon(ta,tb,tc:real;ttro:toado):byte;
var   max,u:real;
      i,luu:integer;
begin
      max:=0;luu:=0;
      for i:=1 to m-1 do
        if ok[b[i]] then
         begin
               u:=kc2(ta,tb,tc,a[b[i]],ttro);
               if u>max then
             begin
                  max:=u;
                  luu:=b[i];
             end;
        end;
        chon:=luu;
end;

procedure  xuli(i:integer);
var  dd,k:integer;
     ch1,ch2:toado;
     w,z,ax,bx,cx:real;
     td:array[0..5] of toado;
begin
      fillchar(ok,sizeof(ok),true);
      duong_thang(ax,bx,cx,a[i],a[i+1]);
      ok[b[i]]:=false;ok[b[i+1]]:=false;
      dd:=1;
      ch1:=a[b[i]];ch2:=a[b[i+1]];
      write(a[b[i+1]].x:4:1,'  ',a[b[i+1]].y:4:1,'  ',a[b[i]].x:4:1,'  ',a[b[i]].y:4:1);readln;
        repeat
               k:=chon(ax,bx,cx,ch2);
               ok[k]:=false;
               write(k,'  ',a[k].x:4:1,'  ',a[k].y:4:1);readln;
               w:=kc2(ax,bx,cx,a[k],ch2);
               z:=sqrt(sqr(ch2.x-ch1.x)+sqr(ch2.y -ch1.y));
               write(w:4:1,'  ',z:4:1);readln;
               write(CH1.x:4:1,'  ',CH1.y:4:1,'  ',CH2.x:4:1,'  ',CH2.y:4:1);readln;
               td[dd].x:=ch1.x+(ch2.x-ch1.x)*(z+w)/w;
               td[dd].y:=ch1.y+(ch2.y-ch1.y)*(z+w)/w;
               writeln(td[k].x:4:1,'  ',td[k].y:5:1);readln;
               duong_thang(ax,bx,cx,td[dd],a[k]);
               ch1:=td[dd];
               ch2:=a[k];
               inc(dd);
        until  dd>4;
        writeln('djd');
        for i:=1 to 4 do
              writeln(td[i].x:4:1,'  ',td[i].y:4:1);
end;

procedure  main;
var  i:byte;
begin
     for i:=1 to m-1 do xuli(i);
end;

begin  clrscr;
  init;
  readfile;
  boc_goi;
  main;
end.

6
0 0
3 2
4 4
5 2
8 0
4 -1
