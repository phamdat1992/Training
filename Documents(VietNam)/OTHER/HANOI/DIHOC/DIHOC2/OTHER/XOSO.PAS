Program soso;
uses crt;
Const
	Fi='xoso.inp';
    Fo='xoso.out';
    Maxn=100;
Var
   A:array[1..maxn,1..maxn] of integer;
   diem:array[1..maxn] of integer;
   chuaxet:array[1..maxn] of boolean;
   cx:array[1..maxn] of boolean;
   kq,quay:array[1..maxn] of integer;
   lam:array[1..maxn] of integer;
   i,j,m,n,k:integer;
   chap:integer;
   dem:integer;
   chiso:integer;
   ha:integer;
Procedure readf;
Var
   f:text;
Begin
     Assign(f,fi);
     reset(f);
     Readln(f,n,m,k);
     For i:=1 to n do
     begin
          for j:=1 to k do read(f,a[i,j]);
          read(f,diem[i]);
          readln(f);
     end;
     close(f);
End;

Procedure init;
begin
     Fillchar(a,sizeof(a),0);
     Fillchar(diem,sizeof(diem),0);
     Fillchar(chuaxet,sizeof(chuaxet),True);
     Fillchar(cx,sizeof(cx),True);
     readf;
     dem:=0;
end;

Function findmax:integer;
Var
   i,max:integer;
   chiso:integer;
begin
     for i:=1 to n do
         if cx[i] then
         begin
              max:=a[i];
              chiso:=i;
              cx[i]:=False;
         end;

     for i:=1 to n do
         if (cx[i]) and (diem[i]>max) then
         begin
              max:=a[i];
              chiso:=i;
              cx[i]:=False;
         end;
     findmax:=chiso;
end;

function kt(i:integer):boolean;
Var
   j: integer;
   l: set of byte;
   dm:integer;
begin
     kt:=false;
     l:=[];
     dm:=0;
     for j:=1 to chap do l:=l+[kq[i]];

     for j:=1 to k do
         if a[i,j] in l then inc(dm);
     if dm > diem[i] then exit;
     kt:=true;
end;

procedure lam(i:integer);
Var
   j: integer;
   l: set of byte;
   dm:integer;
begin
     l:=[];
     dm:=0;
     ha:=ha+1;

     for j:=1 to chap do l:=l+[kq[i]];

     for j:=1 to k do
         if not (a[i,j] in l) then
         begin

         end;

     if dm > diem[i] then exit;

end;


Procedure update;
Var
   i,j:integer;
begin
     For i:=1 to n do
         if (i <> chiso) and not kt(i) then exit;

     ha:=chap;
     while ha<k do
     begin
          i:=findmax;
          lam(i);
     end;

     inc(dem);
     for i:=1 to chap do write(kq[i]:6);
     writeln;

end;

Procedure try(i:integer);
Var
   j:integer;
begin
     If i>chap then
     begin
          update;
          exit;
     end;

     For j:=1 to k do
     if chuaxet[j] then
     begin
          chuaxet[j]:=false;
          kq[i]:=quay[j];
          try(i+1);
          chuaxet[j]:=true;
     end;

end;

Procedure main;
Var
   i:integer;
   max:integer;
begin
     max:=diem[1];
     chiso:=1;

     for i:=1 to n do write(diem[i]:5);
     writeln;

     for i:=2 to n do
         if max<diem[i] then
         begin
              max:=diem[i];
              chiso:=i;
         end;

     chap:=max;

     for i:=1 to k do
          quay[i]:=a[chiso,i];

     cx[chiso]:=false;
     try(1);
end;

Procedure done;
begin
     Writeln(dem);
end;

BEGIN
     Clrscr;
     init;
     main;
     done;
END.
5 9 4
2 4 6 8 2
5 6 8 9 0
2 4 5 6 2
1 2 3 7 3
3 5 6 9 1
