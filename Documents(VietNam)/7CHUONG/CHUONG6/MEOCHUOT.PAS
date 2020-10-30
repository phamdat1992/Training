{ tro choi meo va chuot}

Uses crt,dos;
Type mang=array[1..50,1..50] of byte;
Var
  x,y,wherecx,wherecy,n:integer;
  a:mang;
  xong:boolean;
  dm,dc,nc,nm:boolean;


Procedure Nhap;
Var
 x,y,i,j:integer;
 ch:char;
Begin
 Write('Vao do dai ban co   :  '); ReadLn(n);
  For i:=1 to n do
  For j:=1 to n do
   a[i,j]:=0;
  For i:=1 to 4 do
   Begin write('Vao toa do meo ',i,'  :  ');ReadLn(x,y);a[x,y]:=1;End;
  Write('Vao toa do chuot  :  ');ReadLn(x,y);a[x,y]:=2;
  Write('Nguoi cam con gi  ?  ');ReadLn(ch);ch:=upcase(ch);
  Nc:=ch='C';Nm:=ch='M';
  Write('Di truoc hay sau  (t,s) ?  ');ReadLn(ch);ch:=upcase(ch);
  dm:=((ch='T') and nm) or ((ch='S') and nc) ;dc:=dm;dm:=not(dc);
End;


Procedure Timc;
Var i,j:integer;
Begin
 For i:=1 to n do
  For j:=1 to n do
  If a[i,j]=2 then Begin wherecx:=i;wherecy:=j;End;
End;

Function Min(a1,b1:integer):integer;
Begin
 If a1<=b1 then min:=a1
 Else min:=b1;
End;



Procedure Timm;
Var
 i,j,luu,moi,luux,luuy:integer;
Begin
 timc;x:=wherecx;y:=wherecy;luu:=maxint;
 For i:=1 to N do
  For j:=1 to N do
   If a[i,j]=1 then
    Begin
     moi:=min(abs(i-x),abs(j-y));
     If luu>moi then Begin luu:=moi;luux:=i;luuy:=j;End;
    End;
  a[luux,luuy]:=0;
 If abs(luux-x)>=abs(luuy-y) then
   Begin y:=luuy;If luux>x then x:=luux-1 Else x:=luux+1;End
  Else Begin x:=luux;If luuy>y then y:=luuy-1 Else y:=luuy+1;End
End;



Procedure Dimeo;
Begin
 If nm then
  Begin
   Gotoxy(30,12);Write('Di meo o o nao  :  ');ReadLn(x,y); a[x,y]:=0;
   Gotoxy(30,13);Write('Den o nao       :  ');ReadLn(x,y);
  End
 Else  timm;

 xong:=(a[x,y]=2);
 a[x,y]:=1;
End;




Function tot(i,j,s:integer):boolean;
Begin

 Case s of
  1:tot:=((i-j)>=(x-y)) and ((i+j)<=(x+y));
  2:tot:=((i-j)>=(x-y)) and ((i+j)>=(x+y));
  3:tot:=((i-j)<=(x-y)) and ((i+j)>=(x+y));
  4:tot:=((i-j)<=(x-y)) and ((i+j)<=(x+y));
 End;
End;


Function Vung(s:integer):boolean;
Var
 i,j:integer;
Begin
 vung:=true;
 For i:=1 to N do
  For j:=1 to N do
   If a[i,j]=1 then
    If tot(i,j,s) then  Begin vung:=false;Exit;End;
End;

Procedure Doi(s:integer);
Begin
 Case s of
  1:Begin x:=x  ;y:=y-1;End;
  2:Begin x:=x+1;y:=y  ;End;
  3:Begin x:=x  ;y:=y+1;End;
  4:Begin x:=x-1;y:=y  ;End;
 End;

End;


Procedure Timcc;
Var
 i:integer;
Begin
 timc;x:=wherecx;y:=wherecy;
 For i:=1 to 4 do If vung(i) then Begin doi(i);Exit;End;
 Randomize;
 doi(random(4)+1);
End;


Procedure Dichuot;
Begin
 Timc; a[Wherecx,wherecy] :=0;
 If nc then
  Begin Gotoxy(30,12);Write('Di chuot den dau  ?  ');ReadLn(x,y); End

 Else Timcc;
 xong:=(a[x,y]=1)  or ((x=1) or (y=1) or (x=N) or (y=N));

 a[x,y]:=2;
End;


Procedure Xuat;
Var i,j:integer;
Begin
 Clrscr;
 For i:=1 to n do
  For j:=1 to n do
  Begin
   Gotoxy(i*2,j);
   Case a[i,j] of
    0:Write(#3);
    1:Write('M');
    2:Write('C');
    End;
  End;
  Dc:=not(dc);Dm:=not(Dm);

End;

Procedure choi;
Begin
 Clrscr;
 Xuat;
 Repeat
  If dm then Begin Dimeo; Xuat;End;
 If xong then Begin Write('Meo');Exit;End;
  If dc then Begin Dichuot;Xuat;End;
 Until xong;
 Write('Chuot');
End;


Procedure Test;
Begin
 Clrscr;
 Nhap;
 Choi;
End;


BEGIN
 Test;
End.