Program Den_mau;
Uses crt;
Var
   Mang: Array[1..200,1..200] of shortint;
   M,n,k:Integer;
   i,j:integer;
   p:integer;
   f:text;
   Mau,a,b:integer;

Procedure khoitao;
Begin
     For i:=1 to 200 do
      for j:=1 to 200 do mang[i,j]:=-1;
     Mau:=0;
End;

Procedure Readfile;
Var a,b:integer;
Begin
     Assign(f,'color.inp');
     Reset(f);
     Readln(f,m,n,k);

     For i:=1 to k do
     Begin
          Readln(f,a,b);
          Mang[a,b]:=0;
     End;

     For i:=1 to m do
     Begin
      Writeln;
      For j:=1 to n do
      Write(Mang[i,j]:4);
     End;
     Writeln;
End;

Procedure xuly;
Var a,b,c:integer;
    Demdong,demcot:Integer;
    d:boolean;
    taphop: set of 1..127;
    ok:shortint;
Begin
     Demdong:=0;
     demcot:=0;
     For i:=1 to m do
     Begin
          taphop:=[];
          d:=false;
      For j:=1 to n do
      Begin
      if Mang[i,j]=0 then
           begin
                For a:=1 to m do
                 for b:=1 to n do
                 if (mang[a,j]=0) and (mang[i,b]=0) then  mang[i,j]:=mau;

                For a:=1 to m do
                 for b:=1 to n do
                 if (mang[a,j]>=0) and (mang[i,b]>=0) then d:=true;
                If d=True then
                Begin
                     inc(mau);
                     mang[i,j]:=mau;
                End


                Begin
                     For a:=1 to m do
                     if (mang[a,j]>0) then taphop:=taphop+[mang[a,j]];
                     for b:=1 to n do
                     If (mang[i,b]>0) then taphop:=taphop+[mang[i,b]];
                     For c:=1 to mau do if not (c in taphop) then ok:=c;
                     mang[i,j]:=c;
                End;
           end;
      End;
      end;
    For i:=1 to m do
     Begin
      Writeln;
      For j:=1 to n do
      Write(Mang[i,j]:4);
     End;
End;

BEGIN
     Clrscr;
     KhoiTao;
     Readfile;
     Xuly;
END.
4 5 13
1 1
1 2
1 5
3 1
4 1
3 2
2 3
3 3
4 3
2 4
4 4
2 5
4 5
