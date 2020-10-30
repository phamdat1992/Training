{$M 65000,0,650000}
{$R+}
Program soxo_dientoan;
Uses crt;
Const
     Fi='xoso.inp';
     Fo='xoso.out';
     Maxn=100;
     maxk=50;
Var
   a:array[1..maxn,1..maxk] of byte;
   diem:array[1..maxn] of byte;
   luu:array[0..maxk] of byte;

   s : set of byte;
   s2: set of byte;

   i,j,m,n,k:byte;
   f2:text;
Procedure Readf;
Var
   f:text;
Begin
     Assign(f,fi);
     Reset(f);
     Readln(f,n,m,k);

     For i:=1 to n do
     begin
          for j:=1 to k do read(f,a[i,j]);
          readln(f,diem[i]);
     end;

     Close(f);
End;

Procedure init;
begin
     Fillchar(a,sizeof(a),0);
     Fillchar(diem,sizeof(diem),0);
     Fillchar(luu,sizeof(luu),0);

     Readf;

     s:=[];

     For i:=1 to n do
     if diem[i]=0 then
        for j:=1 to k do s:=s+[a[i,j]];

     s2:=[];

     assign(f2,fo);
     Rewrite(f2);
end;

Function on:boolean;
Var
   i,j:byte;
   d:byte;
Begin
     on:=false;

     For i:=1 to n do
     begin
          d:=0;

          For j:=1 to k do
              if (a[i,j] in s2) then d:=d+1;

          If d<>diem[i] then exit;
     end;

     on:=true;
End;

Function ok(so:byte):boolean;
Var
   i,j,d:byte;
Begin
     ok:=false;

     s2:=s2+[so];

     for i:=1 to n do
     begin
          d:=0;

          for j:=1 to k do
              if a[i,j] in s2 then d:=d+1;

          If d>diem[i] then
          begin
               s2:=s2-[so];
               exit;
          end;
     end;

     s2:=s2-[so];
     ok:=true;
End;

Procedure Update;
Var
   i:byte;
Begin
     If not on then exit;

     For i:=1 to k do write(f2,luu[i],' ');
     Writeln(f2);
End;

Procedure Try(i:byte);
Var
   j:byte;
Begin
     If i>k then
     begin
          update;
          exit;
     end;

     For j:=luu[i-1]+1 to m do
     if not (j in s) and ok(j) then
     begin
          luu[i]:=j;
          s:=s+[j];
          s2:=s2+[j];

          try(i+1);

          s:=s-[j];
          s2:=s2-[j];
          luu[i]:=0;
     end;
End;

Procedure Done;
Begin
     Close(f2);
End;

Procedure Sinhtest;
Var
   f:text;
   d:byte;
Begin
     Assign(f,fi);
     Rewrite(f);

     n:=100;
     m:=50;
     k:=10;
     s:=[1..k];

     Writeln(f,n,' ',m,' ',k);


     For i:=1 to n do
     begin
          s2:=[];
          for j:=1 to k do
          begin
               Repeat
                     a[i,j]:=random(m)+1;
               Until not (a[i,j] in s2);
               s2:=s2+[a[i,j]];
          end;
     end;

     For i:=1 to n do
     begin
          d:=0;
          For j:=1 to k do
              if a[i,j] in s then d:=d+1;
          diem[i]:=d;
     end;

     For i:=1 to n do
     begin
          for j:=1 to k do write(f,a[i,j],' ');
          writeln(f,diem[i]);
     end;

     Close(f);
End;

BEGIN
{
     Randomize;
     sinhtest;
end.
}
     Clrscr;
     Init;
     Try(1);
     Done;
END.
5 9 4
2 4 6 8 2
5 6 8 9 0
2 4 5 6 2
1 2 3 7 3
3 5 6 9 1
