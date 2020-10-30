Program Job_Processing;
Uses crt;
Type Mang = Array[1..30] of Integer;
Var A,B:array[1..30] of Byte;
    C:Mang;
    D:array[1..1000] of Integer;
    n,mm,ma,mb,dem:integer;

Procedure KhoiTri;
  Begin
       Fillchar(c,sizeof(c),0);
       mm:=Maxint-1;
  End;

Procedure Dulieu;
  Var f:text;
      i:integer;
  Begin
       Assign(f,'Job\Input-6.txt');
       Reset(f);
       Readln(f,n);
       Readln(f,ma);
       For i:=1 to ma do Read(f,a[i]);
       Readln(f,mb);
       For i:=1 to mb do Read(f,b[i]);
       Close(f);
  End;

Function FindMin:integer;
  Var k,i,min:integer;
      T:Array[1..30] of Integer;
  Begin
       K:=0;
       For i:=1 to ma do
           if (k=0) or (c[i]+a[i]<Min) then
              begin Min:=c[i]+a[i]; k:=i; End;
       FindMin:=k;
  End;

Function FindMax:Integer;
  Var i,max:integer;
  Begin
       Max:=0;
       For i:=1 to ma do
           if C[i]>max then Max:=c[i];
       FindMax:=Max;
  End;

Procedure BLCauA;
  Var i,k:integer;
  Begin
       For i:=1 to n do
           begin
                k:=FindMin;
                C[k]:=C[k]+A[k];
           end;
       Writeln('Thoi gian can thiet Cau A : ',FindMax);
       For i:=1 to ma do C[i]:=C[i] div a[i];
  End;

Procedure SapXep;
  Var i,j,p,q:integer;
  Begin
       For i:=1 to n-1 do
           begin
                p:=i;
                For j:=i+1 to n do
                    if D[j]<D[p] then P:=j;
                Q:=D[i];
                D[i]:=D[p];
                D[p]:=q;
           end;
  End;

Procedure GanMang;
  Var i,j,k:integer;
  Begin
       K:=0;
       For i:=1 to ma do
           For j:=1 to C[i] do
               begin
                    inc(k);
                    D[k]:=j*a[i];
               end;
       SapXep;
       Fillchar(c,sizeof(c),0);
  End;

Function Max(k1,k2:integer):Integer;
  Begin
       if k1>k2 then max:=k1 else Max:=k2;
  End;

Procedure MangMin(Var T:mang;Var Tg:integer);
  Var i,min:integer;
  Begin
{       Write(dem:4);          }
       Min:=MaxInt;
       For i:=1 to Mb do
           if (Max(D[dem],c[i])+B[i]<min) then
              begin
                   Min:=Max(D[dem],c[i])+B[i];
                   Tg:=1; T[tg]:=i;
              end
           else
               if (Max(D[dem],c[i])+B[i]=min) then
                  begin
                       Inc(Tg); T[tg]:=i;
                  end
  End;

{Function TimMin:integer;
  Var kt:array[1..30] of Boolean;
      dem1,i,j,k,min:integer;
  Begin
       Fillchar(Kt,sizeof(kt),true);
       Dem1:=Dem+1;
       k:=0;
       if Dem1<n then
          for j:=1 to Tg do
              begin
                   if (k=0) or (Min<Max(D[dem1],c[T[j]])+B[T[j]]) then
                      begin
                           k:=j;
                           Min:=Max(D[dem1],c[T[j]])+B[T[j]];
                      end
              end
       else k:=1;
       TimMin:=T[K];
  End;}

Function FindMaxB:integer;
  Var i,max:Integer;
  Begin
       Max:=0;
       For i:=1 to Mb do
           if Max<c[i] then Max:=C[i];
       FindMaxB:=Max;
  End;

{Procedure BLCauB;
  Var i,j,k:integer;
  Begin
       Dem:=0;
       For i:=1 to n do
           begin
                Inc(dem);
                MangMin;
                For j:=1 to Tg do write(T[j]:3); Writeln;
                K:=TimMin;
                C[k]:=Max(C[k],D[dem])+B[k];
                Write(k:5,c[k]:4); writeln;
                if Tg>2 then readkey;
           end;
       Writeln('Thoi gian can thiet Cau B : ',FindMaxB);
  End;                 }

Procedure DeQui(k:integer);
  Var h,p,i,m,Tg,j:integer;
      T:Mang;
  Begin
       if k>n then
          begin
               M:=FindMaxB;
               if M<MM then
                  begin
                  MM:=M;
               WRiteln('dsf',m:5);
               end;
          end
       else
           begin
                MangMin(T,Tg);
               { Write(tg:2);}
                {For j:=1 to Tg do write(T[j]:3); Writeln(tg:5);
                For j:=1 to Mb do write(C[j]:3); Writeln;
                Readkey;}
                if (tg<>2) then
                   For i:=1 to Tg do
                       begin
                         h:=T[i];
                         P:=C[h];
                         C[h]:=Max(C[h],D[dem])+B[h];
                         Inc(dem);
                         Dequi(k+1);
                         Dec(dem);
                         C[h]:=p;
                       end
                else
                    begin
                         if Max(C[t[1]],D[dem+1])+B[t[1]]<Max(C[t[2]],D[dem+1])+B[t[2]] then
                            h:=T[1]
                         else h:=t[2];
                         C[h]:=Max(C[h],D[dem])+B[h];
                         Inc(dem);
                         Dequi(k+1);
                         Dec(dem);
                         C[h]:=p;
                    end;
           end;
  End;

Procedure ProMain;
  Begin
       BLCauA;
       GanMang;
{       BLCauB; }
        Dem:=1;
       Dequi(1);
       Writeln;
       Write('MMMMM : ',MM);
  End;

Begin
     Clrscr;
     KhoiTri;
     Dulieu;
     ProMain;
     Readln;
End.

10
4
2 3 4 5
3
3 6 5

10
1
1
2
2 3

