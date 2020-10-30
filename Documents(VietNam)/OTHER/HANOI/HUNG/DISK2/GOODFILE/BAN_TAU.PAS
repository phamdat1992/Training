uses crt,graph;
var  n,k,cnt:byte;
     a:array[1..100,1..100] of byte;
procedure input;
begin
 clrscr;
 write('vao kich thuoc dai duong:');
 readln(n);
 write('vao chieu dai tau:');
 readlN(k);
 fillchar(a,sizeof(a),0);
end;

procedure  O(x1,y1,x2,y2:integer;c1,c2,c3,c4:byte);
begin
 setfillstyle(1,c1);
 bar(x1,y1,x2,y2);
 setfillstyle(1,c2);
 bar(x1+1,y1+1,x2-1,y2-1);
 setfillstyle(1,c3);
 bar(x1+3,y1+3,x2-3,y2-3);
 setcolor(c4);
 line(x2-1,y1+1,x2-1,y2+1);
 line(x1+1,y2-1,x2-1,y2-1);
 line(x2-2,y1+2,x2-2,y2-2);
 line(x1+2,y2-2,x2-2,y2-2);
end;

procedure drw(i,j,t:byte);
begin
 case t of
  1:O((i-1)*30+10,(j-1)*30+10,i*30+10,j*30+10,0,7,9,1);
  2:O((i-1)*30+10,(j-1)*30+10,i*30+10,j*30+10,0,1,9,7);
  3:O((i-1)*30+10,(j-1)*30+10,i*30+10,j*30+10,0,4,12,7);
 end;
end;

procedure draw;
var i,j:byte;
begin
 O(0,0,639,479,0,8,7,15);
 for i:=1 to n do
  for j:=1 to n do drw(i,j,1);
end;

procedure init;
var gd,gm:integer;
begin
 gd:=detect;
 initgraph(gd,gm,'c:\tp\bgi');
end;

procedure solve;
var i,j:byte;
begin
 i:=k;
 cnt:=0;
 repeat
  for j:=1 to i do
   if (j<=n) and (i+1-j<=n) then
    begin
     a[j,i+1-j]:=1;
     inc(cnt);
    end;
   inc(i,k);
 until i>2*n;
end;

procedure play;
var  ans:char;
     i,j:byte;
     s1,s2:string;
begin
  randomize;
  repeat
   o(10,400,629,430,0,3,11,7);
   o(10,440,629,470,0,3,11,7);
   delay(100);
    repeat
      i:=random(n+1);
      j:=random(n+1);
    until a[i,j]=1;
    dec(cnt);
    a[i,j]:=2;
    drw(i,j,2);
    str(i,s1);
    str(j,s2);
    setcolor(4);
    outtextxy(30,410,'('+s1+'   '+s2+')');
    outtextxy(30,450,'tau o day phai khong:');
    for k:=1 to 10 do begin sound(200+100*k);delay(100);end;nosound;
    ans:=upcase(readkey);
    drw(i,j,1);
   until (ans='Y') or (cnt=0);
   o(10,350,629,390,0,3,11,7);
   setcolor(4);
   if cnt >0 then
   begin
   drw(i,j,3);
   setcolor(4);
   outtextxy(30,370,'tau da bi ha! moi ban tiep tuc thu gian voi tro choi');
   end
   else
    outtextxy(30,370,'khong co tau! moi ban tiep tuc thu gian voi tro choi:');
   readln;
   closegraph;
  end;

  begin  clrscr;
   input;
   init;
   draw;
   solve;
   play;
  end.


