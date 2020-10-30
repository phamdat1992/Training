{$R+}
Program DISREC;
Uses crt;
Const
	Fi='disrec.inp';
    Fo='disrec.out';
    Maxn=10;
    maxm=1000;
Type
    kpt = record
        x,y,z,t:integer;
    end;
Var
	n,m,i,j,px,py:integer;
    l:integer;
    kq:array[1..maxm] of kpt;
    f:text;
    Cuoi:integer;

Procedure Readf;
Var
	f:text;
Begin
	Assign(f,fi);
    Reset(f);
    Readln(f,m,n,l,px,py);
    Close(f);
End;

Procedure Init;
Begin
	Readf;

    Assign(f,fo);
    Rewrite(f);
    Cuoi:=0;
End;

Function kc(x1,y1,x2,y2:integer):Real;
Begin
     kc:=abs(sqrt(sqr(x1-x2)+sqr(y1-y2)));
End;

Function dd(i,j:integer):integer;
Var
   min:Real;
Begin
     min:=kc(px,py,i,j);
     If min>kc(px,py,i,j+n) then min:=kc(px,py,i,j+n);
     If min>kc(px,py,i+m,j) then min:=kc(px,py,i+m,j);
     If min>kc(px,py,i+m,j+n) then min:=kc(px,py,i+m,j+n);

     If (px>=i) and (px<=i+m) and (py>=j) and (py<=j+n) then min:=0;

     dd:=trunc(min);
End;

Function trongkq(l,t:integer):boolean;
Var
   i,j:integer;
Begin
     trongkq:=true;
     For i:=1 to cuoi do
     begin
          If (kq[i].x>=l) and (kq[i].x<=l+m)
          and(kq[i].y>=t) and (kq[i].y<=t+n) then exit;

          If (kq[i].z>=l) and (kq[i].z<=l+m)
          and(kq[i].t>=t) and (kq[i].t<=t+n) then exit;

     end;
     Trongkq:=false;
ENd;

Procedure Main;
Var
   u,v,i,j,k:integer;
Begin
{     For i:=0 to l do
     begin}
          For j:=-l to l do
              for k:=-l to l do
              Begin
                   u:=maxint;
                   v:=maxint;
                   If (dd(j+l,k+l)<=l) then
                        If not trongkq(j+l,k+l) then
                        begin
                             u:=j+l;
                             v:=k+l;
                        end;

                   if (dd(j+l,k-l)<=l) then
                        If not trongkq(j+l,k-l) then
                        begin
                             u:=j+l;
                             v:=k-l;
                        end;

                   If (dd(j-l,k+l)<=l) then
                        If not trongkq(j-l,k+l) then
                        begin
                             u:=j-l;
                             v:=k+l;
                        end;

                   If (dd(j-l,k-l)<=l) then
                        If not trongkq(j-l,k-l) then
                        begin
                             u:=j-l;
                             v:=k-l;
                        End;

                   If (u<>maxint) and (v<>maxint) then
                   begin
                        inc(cuoi);
                        kq[cuoi].x:=u;
                        kq[cuoi].y:=v;
                        kq[cuoi].z:=u+m;
                        kq[cuoi].t:=v+n;
                   end;
             End;
{     End;}
End;

Procedure sort;
Var
   i,j:integer;
   tg:kpt;
Begin
     For i:=1 to cuoi-1 do
         for j:=i+1 to cuoi do
             if dd(kq[i].x,kq[i].y)>dd(kq[j].x,kq[j].y) then
             begin
                  tg:=kq[i];
                  kq[i]:=kq[j];
                  kq[j]:=tg;
             end;
ENd;

Procedure Done;
Begin
     Sort;
     For i:=1 to cuoi do writeln(kq[i].x,' ',kq[i].y);
     For i:=1 to cuoi do writeln(f,kq[i].x,' ',kq[i].y);
     Close(F);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
3 2 2
4 3
