{}
{ uses crt;}
const tenfv='INP.B4';
var
 a: array[1..250,1..250] of byte;
 dem, gt, m, n, i, cd1, j, k, l, max, i0, j0, k0, l0,
 ii, jj, tt, i1, j1, k1, l1 : byte;
 dto, dt1, cd2: word;
 f1, f: text;
 s: String[1];

 hs, a1: array[0..100] of byte;
 nt: array[1..50] of byte;
 ti, tj, tk, tk0: integer;
 procedure kt;
 var
  i:byte;
 begin
  for i:=0 to 50 do a1[i]:=0;
 end;
 procedure snt;
 var
  td, tnt: set of byte;
  st, j, i: integer;
 begin
  td:=[2..50];
  tnt:=[];
  st:=2;
  repeat
   while not (st in td) do inc(st);
   tnt:=tnt+[st];
   j:=st;
   while (j<=50) do begin td:=td-[j]; j:=j+st end;
  until td=[];
  k:=0;
  for j:=2 to 50 do
   if j in tnt then begin inc(k);nt[k]:=j end else nt[j]:=0;
   k0:=k;
 end;
 procedure tong(s,i, p: integer);
 var
  s0, k, l: integer;
 begin
  if (i>k0) or (s>=50) then begin  if a1[s]<p then a1[s]:=p;
    for l:=1 to i-1 do if (hs[l]=1) and (s+nt[l]<=50) and (a1[s+nt[l]]<=p+1)
     then a1[s+nt[l]]:=p+1;exit end;
  hs[i]:=0; tong (s,i+1, p);
  hs[i]:=1; tong (s+nt[i],i+1, p+1);
 end;
procedure ktra(dt0: word;i0,j0,k0,l0: byte);
var i, j, k: byte;
    kt: boolean;
begin
  k:=a[i0,j0];
  kt:=true;
  i:=i0;
  repeat
   j:=j0;
   repeat
    kt:=kt and (a[i,j]=k);
    inc(j)
   until (j>l0) or not kt;
   inc(i)
  until (i>k0) or not kt;
  kt:=kt and ((k0+1-i0)*(l0+1-j0)=dto);
  if not kt then writeln(F, 'Sai! ',i-1,' ',j-1);
end;
begin
 snt;
 tong(0,1,0);
{ clrscr;}
 randomize;
 assign(f,'Kq');
 rewrite(f);

 for tt:=1 to 9 do
 begin
   writeln(f,'Ket qua ',tt);
   writeln(f,'***********');
   str(tt,s);
   assign(f1,TenFv+s);
   reset(f1);
   readln(f1,m,n);
   writeln(f,m,' ',n);
   for i:=1 to m do
    for j:=1 to n do
    begin
      read(f1,a[i,j]);
      a[i,j]:=a1[a[i,j]];
    end;

   i0:=1; j0:=1; k0:=1; l0:=1; dto:=1;
   i:=1;
  repeat
    ii:=m+1-i;
    j:=1;
   repeat
    jj:=n+1-j;
    gt:=a[i,j];
    k:=i;
    dt1:=1;
    k1:=i;
    l1:=j;
    cd1:=n;
    repeat
      l:=j;
      repeat
        l:=l+1
      until (l>cd1) or (a[k, l] <> gt);
      if cd1 > l - 1 then
        cd1:= l-1;
      cd2 := (k-i+1)*(l-j);
      if  cd2 > dt1 then
         begin k1:=k; l1:=l-1; dt1 :=cd2 end;
      k:=k+1;
    until (a[k, j] <> gt) or (k>m);

    if dt1>dto then
    begin
        dto:=dt1; i0:=i; j0:=j; k0:=k1; l0:=l1;
    end;
   j:=j+1
   until (j>n) or (dto>(ii*jj));
   i:=i+1
   until (i>m) or (dto>ii*n);


    for i:=1 to m do
    begin
     for j:= 1 to n do write(f,a[i,j]);
     writeln(f)
    end;

    writeln(f,dto:10, i0:5, j0:5, k0:5, l0:5);

    ktra(dto,i0,j0,k0,l0);
  end;
    close(f)
 end.
