Program duong_giao_thong;
Uses crt;
Const
     Fi='duong.inp';
     Fo='duong.out';
	 maxn=100;
Var
   A:array[1..maxn,1..maxn] of integer;
   chuaxet:array[1..maxn] of boolean;
   ra,bo:array[1..maxn] of boolean;
   kq:array[1..maxn] of integer;
   canh:array[1..maxn,1..2] of integer;
   i,j,m,n:integer;
   s,t:integer;
   dem:integer;
   socanh:integer;
   p:boolean;
   min:integer;
   sc:integer;
Procedure readf;
Var
   f:text;
   c:char;
Begin
     Assign(f,fi);
     Reset(f);
     Readln(f,n);
     For i:=1 to n do
     begin
          for j:=i+1 to n do
          begin
               read(f,c);
               if c='1' then
               begin
                    a[i,j]:=1;
                    a[j,i]:=1;
               end;
          end;
          readln(f);
     end;
End;

Procedure init;
begin
     Fillchar(a,sizeof(a),0);
     Fillchar(chuaxet,sizeof(chuaxet),True);
     Fillchar(canh,sizeof(canh),0);
     Fillchar(bo,sizeof(bo),False);
     Readf;
     s:=1;
     t:=n;
     dem:=1;
     kq[dem]:=s;
     socanh:=0;
     p:=false;
     min:=maxint;
     sc:=0;
End;

Function thuoc(q,p:integer):boolean;
Var
   i,j:integer;
Begin
     thuoc:=true;
     For i:=1 to socanh do
         if (canh[i,1]=q) and (canh[i,2]=p)
         or (canh[i,1]=p) and (canh[i,2]=q) then exit;
     thuoc:=false;
End;

Procedure update;
var
   i:integer;
begin
     for i:=1 to dem-1 do
         if not thuoc(kq[i],kq[i+1]) then
         begin
              inc(socanh);
              canh[socanh,1]:=kq[i];
              canh[socanh,2]:=kq[i+1];
         end;

end;

Procedure timcanh(i:integer);
Var
   j:integer;
Begin
     if i>=t then
     begin
          update;
          exit;
     end;

     For j:=1 to n do
     if (a[i,j]<>0) and chuaxet[j] then
     begin
          chuaxet[j]:=false;
          inc(dem);
          kq[dem]:=j;
          timcanh(j);
          dem:=dem-1;
          chuaxet[j]:=true;
     end;
End;

Procedure timlienthong(i:integer);
Var
   j:integer;
Begin
     if i>=t then
     begin
          p:=true;
          exit;
     end;

     For j:=1 to n do
     if (a[i,j]<>0) and chuaxet[j] and (p=false) then
     begin
          chuaxet[j]:=false;
          timlienthong(j);
          chuaxet[j]:=true;
     end;
End;

Function vanco:boolean;
Begin
     p:=false;
     Fillchar(chuaxet,sizeof(chuaxet),True);
     timlienthong(s);
     vanco:=p;
end;

Procedure loaibo(i,j:integer);
begin
     a[i,j]:=0;
     a[j,i]:=0;
end;

Procedure themvao(i,j:integer);
Begin
     a[i,j]:=1;
     a[j,i]:=1;
end;


Procedure capnhat;
Var
   i:integer;
   so:integer;
Begin
     so:=0;
     for i:=1 to socanh do
         if bo[i] then inc(so);

     If min>so then
     begin
          min:=so;
          ra:=bo;
     end;
End;

Procedure duyet(i:integer);
Var
   j:integer;
Begin
     If (not vanco) or (i>=socanh) then
     begin
          capnhat;
          exit;
     end;

     For j:=1 to socanh do
     if not bo[j] then
     begin
          bo[j]:=true;
          inc(sc);
          loaibo(canh[j,1],canh[j,2]);
          duyet(i+1);
          dec(sc);
          bo[j]:=false;
          themvao(canh[j,1],canh[j,2]);
     end;
End;

Procedure Main;
Begin
     chuaxet[s]:=false;
     timcanh(s);

     For i:=1 to socanh do writeln(canh[i,1]:5,canh[i,2]:5);
     writeln(vanco);
     duyet(1);
End;

Procedure done;
Var
   i:integer;
   f:text;
Begin
     Assign(f,fo);
     Rewrite(f);
     Writeln(f,min);
     for i:=1 to socanh do
         if ra[i] then
         begin
              writeln(f,canh[i,1],' ',canh[i,2]);
              writeln('Bo canh: ',canh[i,1]:5,canh[i,2]:5);
         end;
     close(f);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
6
11000
0010
101
01
1
