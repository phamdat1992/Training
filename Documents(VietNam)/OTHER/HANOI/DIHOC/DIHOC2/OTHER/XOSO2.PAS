{$R+}
Program soso;
uses crt;
Const
	Fi='xoso.inp';
    Fo='xoso.out';
    Maxn=100;
Var
   A:array[0..maxn,0..maxn] of integer;
   diem:array[0..maxn] of integer;
   chuaxet:array[0..maxn] of boolean;
   cc:array[0..maxn] of boolean;
   cx:array[0..maxn] of boolean;
   kq,quay:array[0..maxn] of integer;
   lam:array[0..maxn] of integer;
   i,j,m,n,k:integer;
   chap:integer;
   dem:integer;
   chiso:integer;
   ha:integer;
   tt,tt1:set of byte;
   f2:text;
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
     assign(f2,fo);
     rewrite(f2);
end;

{Function findmax:integer;
Var
   i,max:integer;
   chiso:integer;
begin
     for i:=1 to n do
         if cx[i] then
         begin
              chiso:=i;
              max:=diem[i];
              cx[i]:=False;
              break;
         end;

     for i:=1 to n do
         if (cx[i]) and (diem[i]>max) then
         begin
              max:=diem[i];
              chiso:=i;
              cx[i]:=False;
         end;
     findmax:=chiso;
end;

{function kt(i:integer):boolean;
Var
   j: integer;
   l: set of byte;
   dm:integer;
begin
     kt:=false;
     l:=[];
     dm:=0;
     for j:=1 to chap do l:=l+[lam[i]];

     for j:=1 to k do
         if (a[i,j] in l) and (cc[a[i,j]]) then inc(dm);

     if dm > diem[i] then exit;
     kt:=true;
end;}

Function d(i:integer):integer;
Var
   dm,j:integer;
begin
     dm:=0;

     for j:=1 to k do
         if (a[i,j] in tt1) and (cc[a[i,j]]) then inc(dm);

     d:=dm;
end;

function on:boolean;
begin
     on:=false;
     tt1:=[];
     for i:=1 to chap do
         tt1:=tt1+[lam[i]];
     for i:=1 to n do
         if d(i)>diem[i] then exit;
     on:=true;
end;

Function spt:integer;
Var
   i:integer;
   pt:integer;
begin
     for i:=1 to m do
         if i in tt then inc(pt);
     spt:=pt;
end;

Function onduoc:boolean;
Var
   j: integer;
   dm:integer;
begin
     onduoc:=false;
     tt1:=[];

     for i:=1 to dem do
         tt1:=tt1+[kq[i]];

     for i:=1 to n do
         if d(i) <> diem[i] then exit;

     onduoc:=true;
end;


Function datduoc(so:integer):boolean;
Var
   j: integer;
   dm:integer;
begin
     datduoc:=false;

     tt1:=[];
     tt1:=tt+[so];

     for i:=1 to n do
         if d(i) > diem[i] then exit;

     datduoc:=true;
end;

Procedure out;
Var
   i:integer;
begin
     if onduoc then
     begin
          for i:=1 to dem do
              write(f2,kq[i],' ');
          writeln(f2);
     end;
end;

Procedure xettiep;
Var
   i,j:integer;
begin
{     if spt>=k then exit;}
     for i:=1 to n do
     if cx[i] then
     begin
          cx[i]:=false;
          for j:=1 to k do
              if not (a[i,j] in tt) and (cc[a[i,j]]=false) and datduoc(a[i,j])  then
              begin
                   cc[a[i,j]]:=true;
                   tt:=tt+[a[i,j]];
                   inc(dem);
                   kq[dem]:=a[i,j];
                   tt1:=tt;
                   if (dem=k) then out;
                   if (not onduoc) and (dem>=k) then dec(dem);
              end;
     end;
end;

Procedure tim;
var
   i,j:integer;
begin
     if not on then exit;
     fillchar(cc,sizeof(cc),False);
     fillchar(cx,sizeof(cx),True);
     tt:=[];

     dem:=0;
     fillchar(kq,sizeof(kq),0);

     for i:=1 to chap do write(lam[i]:5);
     writeln;

     for i:=1 to chap do
         begin
              inc(dem);
              kq[dem]:=lam[i];
              tt:=tt+[lam[i]];
              cc[lam[i]]:=true;
         end;
     xettiep;
end;

Procedure try(i:integer);
Var
   j:integer;
begin
     If i>chap then
     begin
          tim;
          exit;
     end;

     For j:=lam[i-1]+1 to k do
     if chuaxet[j] then
     begin
          chuaxet[j]:=false;
          lam[i]:=quay[j];
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
     close(f2);
end;

BEGIN
     Clrscr;
     init;
     main;
     done;
END.
5 9 4
2 4 6 8 2
5 6 8 9 1
2 4 5 6 2
1 2 3 7 3
3 5 6 9 1
