{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

Program Hoa_Tra_My ;
Const
     Fi='Town.Inp';
     Fo='Town.Out';
Type
    MAng1=Array[1..5000]Of Longint;
    Mang2=Array[1..5000]Of longint;
    Mang3=Array[1..5000]Of Longint;
Var
   Maxd:^Mang1;
   f:Text;
   n,i,j:Longint;
   Way,Cao,Dai,Rong:^Mang2;
   Luu,Thu_tu:Array[1..5000]Of Byte;
   Dien_Tich:^Mang3;

Procedure ReadFile;
Var x,y,z,tg:longint;
Begin
     Assign(F,Fi);
     Reset(F);
     Readln(F,N);
     For i:=1 to n do
     begin
          readln(f,x,y,z);
          If X>y then
          begin tg:=x; x:=y; y:=tg;End;
          If Y>z then
          begin tg:=y; y:=z; z:=tg; End;
          If X>y Then
          Begin  tg:=y; y:=x; x:=tg;End;
          cao^[i]:=x;
          dai^[i]:=z;
          rong^[i]:=y;
          dien_tich^[i]:=y*z;

          Thu_tu[i]:=i;
     end;

     Close(F);
End;

Procedure Qsort(l,r:Longint);
Var tg,i,j:longint;
    tg1,x:longint;
Begin
     i:=l;
     j:=r;
     x:=Dien_Tich^[(i+j)div 2];
     Repeat
           While Dien_Tich^[i]<x do inc(i);
           While Dien_Tich^[j]>x do dec(j);
           if i<=j then
           begin
                tg:=cao^[i];cao^[i]:=cao^[j]; cao^[j]:=tg;
                tg:=dai^[i];dai^[i]:=dai^[j];dai^[j]:=tg;
                tg:=rong^[i];rong^[i]:=rong^[j];rong^[j]:=tg;
                tg:=thu_tu[i];thu_tu[i]:=thu_tu[j];thu_tu[j]:=tg;
                tg1:=dien_Tich^[i];dien_tich^[i]:=dien_Tich^[j];dien_tich^[j]:=tg1;
                inc(i) ; dec(j);
           end;
     until i>j;
     if i<r then Qsort(i,r);
     if l<j then Qsort(l,j);
End;

Procedure Init;
Begin
     New(Dien_Tich);
     New(cao);
     New(rong);
     New(Dai);
     New(MAxd);
     New(Way);
     ReadFile;
     fillchar(maxd^,sizeof(maxd^),0);
     Qsort(1,n);
End;

Procedure Fini;
Begin
     Dispose(Maxd);
     Dispose(Dien_Tich);
     Dispose(cao);
     Dispose(rong);
     dispose(dai);
     Dispose(way);
End;

Function trong(i,j:Longint):Boolean;
Begin
     trong:=true;
     If (Dai^[i]<=dai^[j])And(rong^[i]<=rong^[j])then
     exit;
     trong:=false;
end;

Procedure Quy_Hoach_Dong;
Var Max:Longint;
Begin
     maxd^[n]:=cao^[n];
     for i:=n-1 downto 1 do
     Begin
          max:=cao^[i];
          for j:=i+1 to n do
           if trong(i,j) then
            if maxd^[j]+cao^[i]>max then
            begin
                 max:=maxd^[j]+cao^[i];
                 luu[i]:=j;
            end;
           maxd^[i]:=max;
     end;
end;

Procedure Writefile;
Var MAx:Longint;
    Luui:Longint;
Begin
     Assign(F,Fo);
     Rewrite(F);
     Max:=0;
     For i:=1 to n do
     if maxd^[i]<>maxlongint then
      if max<maxd^[i] then
      begin
           max:=Maxd^[i];
           luui:=i;
      end;
     i:=0;
     j:=luui;
     repeat
           inc(i);
           Way^[i]:=j;
           j:=luu[j];
     Until j=0;
     Writeln(F,i);
     For i:=i downto 1 do
     writeln(f,thu_tu[way^[i]],' ',' ',Rong^[Way^[i]],' ',Dai^[Way^[i]],' ',cao^[Way^[i]]);
     Close(F);
End;

Begin
     Init;
     Quy_Hoach_Dong;
     Writefile;
     Fini;
End.
9
7 5 5
4 4 8
1 1 5
4 2 2
5 1 5
4 2 7
2 9 2
1 3 3
5 5 5
