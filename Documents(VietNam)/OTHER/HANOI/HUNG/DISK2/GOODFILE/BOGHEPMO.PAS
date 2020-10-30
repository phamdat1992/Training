Uses Crt;
const fin='inp.dat';
      fou='out.dat';
      max=240;
type  mang1=array[1..max,1..max] of byte;
      mang2=array[1..max] of integer;
      mang3=array[1..2*max] of integer;
var  c:mang1;
     f,q:mang3;
     px,py:mang2;
     n:byte;
     u,z:integer;
     ff:text;



Procedure Doc_File_Du_Lieu;
Var i,j:byte;
Begin
  Writeln('INPUT:');
  Assign(ff,fin);
  Reset(ff);
  Readln(ff,n);
  Writeln(n:6);
  for i:=1 to n do
   begin
     for j:=1 to n do begin read(ff,c[i,j]);write(c[i,j]:6);end;
     writeln;readln(ff);
   end;
  Close(ff);
End;

Procedure Khoi_Tao;
var  i,j:byte;
     maxd:integer;
begin
  (* khoi tao F *)
     fillchar(f,sizeof(f), 0);
  for i:=1 to n do
   begin
     maxd:=c[i,1];
     for j:=2 to n do
      if maxd<c[i,j] then maxd:=c[i,j];
     f[i]:=maxd;
   end;
  (* tim cac bo ghep *)
     fillchar(px,sizeof(px),0);
     fillchar(py,sizeof(py),0);
  for i:=1 to n do
   begin
     j:=1;
     while (j<=n) and ((py[j]<>0) or (f[i]+f[j+n]<>c[i,j])) do inc(j);
     if j<=n then
       begin
          px[i]:=j;
          py[j]:=i;
       end;
    end;
 end;

 Function TimThayDinhTuDo:boolean;
 begin
   u:=1;
   while (px[u]<>0) and (u<=n) do inc(u);
   if u<=n then TimThayDinhTuDo:=true
   else
    TimThayDinhTuDo:=false;
 end;

 Function TimThayDuongTangCapGhep:boolean;
 var  dau,cuoi,w,v:integer;
      queue:mang2;
 begin
      fillchar(queue,sizeof(queue),0);
      fillchar(q,sizeof(q),0);
      dau:=1;cuoi:=1;queue[1]:=u;q[u]:=u;
      while cuoi-dau+1>0 do
        begin
          v:=queue[dau];inc(dau);
          if v<=n then (* v thuoc X *)
           begin
            for w:=n+1 to 2*n do
              if (f[v]+f[w]=c[v,w-n]) and (q[w]=0) then
                 begin
                    inc(cuoi);
                    queue[cuoi]:=w;
                    q[w]:=v;
                 end;
            end
          else (* v thuoc Y *)
            if py[v-n]=0 then (* v La Dinh Tu Do Thuoc Y *)
               begin
                  z:=v;
                  TimThayDuongTangCapGhep:=true;
                  exit;
               end
            else
               begin
                  w:=py[v-n];
                  inc(cuoi);
                  queue[cuoi]:=w;
                  q[w]:=v;
               end;
       end;
       TimThayDuongTangCapGhep:=false;
   end;

 Procedure TangCapGhep;
 var x,y:integer;
 begin
    y:=z;
    while y<>u do
      begin
        x:=q[y];
        px[x]:=y-n;
        py[y-n]:=x;
        y:=q[x];
      end;
 end;

 Procedure SuaNhan;
 var x,y,d:integer;
 begin
  (* tim luong de tang cap ghep *)
  d:=maxint;
  for x:=1 to n do
  if q[x]>0 then
   for y:=n+1 to 2*n do
    if q[y]=0 then
    if d>f[x]+f[y]-c[x,y-n] then d:=f[x]+f[y]-c[x,y-n];
  (* sua nhan *)
  for x:=1 to n do
   if q[x]>0 then dec(f[x],d);
  for y:=n+1 to 2*n do
   if q[y]>0 then inc(f[y],d);
  end;

  Procedure Xuat;
  var tongts:integer;
      x:byte;
  begin
    writeln('    ***** Solution *****');
    tongts:=0;
    for x:=1 to n do
      begin
         write(px[x]:6);
         inc(tongts,c[x,px[x]]);
      end;
     writeln;
     writeln('    Tong Trong So La: ',Tongts);readln;
  end;

  Procedure ChuongTrinhXuli;
  begin
    Doc_File_Du_Lieu;
    Khoi_Tao;
    while TimThayDinhTuDo do
      begin
        while not TimThayDuongTangcapGhep do SuaNhan;
        TangCapGhep;
      end;
     Xuat;
  end;

 BEGIN  CLRSCR;
   ChuongTrinhXuLi;
 END.





