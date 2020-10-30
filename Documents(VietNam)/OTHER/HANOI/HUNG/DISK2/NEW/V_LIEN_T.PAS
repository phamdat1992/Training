Uses crt;
Const c:array[1..2] of integer=(-1,1);
Var
  a: array[0..100,0..100] of integer;
  qi,qj:array[0..400] of integer;
  chuaxet:array[0..100,0..100] of boolean;
  dientich: array[1..100] of integer;
  tong,k,n,i,j,dem:integer;

Procedure readf;
var f:text;
    tf:string[25];
Begin
 Clrscr;
 Write('Nhap ten tep: ');
 Readln(tf);
 Assign(f,tf);
 Reset(f);
 Fillchar(a,sizeof(A),0);
 Readln(f,n);
 Writeln('Ma tran luc dau');
 for i:=1 to n do
 begin
   for j:=1 to n do
   begin
    read(f,a[i,j]);
    if a[i,j]>0 then begin textcolor(red);write(a[i,j]:4);end;
    if a[i,j]=0 then begin textcolor(white);write(a[i,j]:4);end;
   end;
   writeln;
 end;
 close(f);
 textcolor(white);
end;

Procedure xuly;
Var pi,pj,k,dau,cuoi:integer;
Begin
 dem:=0;
 fillchar(chuaxet,sizeof(chuaxet),1);
 for i:=1 to n do
  for j:=1 to n do
   if (a[i,j]>0) and chuaxet[i,j] then
    begin
     inc(dem);
     dau:=1;
     cuoi:=1;
     qi[cuoi]:=i;
     qj[cuoi]:=j;
     a[i,j]:=dem;
     chuaxet[i,j]:=false;
     While dau<=cuoi do
     begin
      pi:=qi[dau];
      pj:=qj[dau];
      for k:=1 to 2 do
      begin

       if (a[pi,pj+c[k]]>0) and chuaxet[pi,pj+c[k]] then
        begin
         inc(cuoi);
         qi[cuoi]:=pi;
         qj[cuoi]:=pj+c[k];
         a[pi,pj+c[k]]:=dem;
         chuaxet[pi,pj+c[k]]:=false;
        end;

       if (a[pi+c[k],pj]>0) and chuaxet[pi+c[k],pj] then
        begin
         inc(cuoi);
         qi[cuoi]:=pi+c[k];
         qj[cuoi]:=pj;
         a[pi+c[k],pj]:=dem;
         chuaxet[pi+c[k],pj]:=false;
        end;
       end;
      inc(dau);
     end;
    end;
   writeln('Trong mang co ',dem,' vung lien thong');
   fillchar(dientich,sizeof(dientich),0);
   for k:=1 to dem do
    for i:=1 to n do
     for j:=1 to n do
      if a[i,j]=k then inc(dientich[k]);
   for i:=1 to n do
   begin
   for j:=1 to n do
   Begin
    if a[i,j]>0 then begin textcolor(a[i,j]);write(a[i,j]:4);end;
    if a[i,j]=0 then begin textcolor(white);write(a[i,j]:4);end;
   End;
   writeln;
   textcolor(white);
   end;
   for i:=1 to dem do writeln('Vung lien thong thu ',i,' co dien tich la: ',dientich[i]);
 readln;
end;
BEGIN
readf;
xuly;
END.

7
1 2 0 1 4 0 7
1 5 1 1 0 4 0
1 0 1 0 0 1 9
1 1 0 5 1 0 0
0 0 0 0 0 1 8
0 2 0 0 1 0 0
0 6 4 0 5 0 6





