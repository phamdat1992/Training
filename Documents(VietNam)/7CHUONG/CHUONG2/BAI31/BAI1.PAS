{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program THUC_HIEN_SONG_SONG;
uses crt;
const fi='SN.INP';
       fo='SN.OUT';
      max=101;
type bt=byte;
     ii=integer;
     bb=boolean;
     ar1=array[1..max,1..max] of ii;
     ar2=array[1..max] of bt;
     ar3=array[1..2*max] of bt;
var  a        : ar1;
     m,n	  : bt;
     px,py,kq : ar2;
     tr,q     : ar3;
     min,tg   : ii;
     found    : bb;
     f		  : text;
procedure Nhap;
var  i,j:bt;
begin
   assign(f,fi); reset(f);
   readln(f,m,n);
   for i:=1 to m do
   begin
      for j:=1 to n do read(f,a[i,j]);
      readln(f);
   end;
   close(f);
end;

procedure TimDuongTang(i:bt;var dd:bt);
var  d,c,u,v:bt;
begin
   fillchar(tr,sizeof(tr),0);
   q[1]:=i; d:=1; c:=1;
   found:=false;
   while d<=c do
   begin
      u:=q[d]; inc(d);
      if u<=n then
      begin
         for v:=1 to m do
		  if (tr[v+m]=0)and(a[v,u]>-1)and(a[v,u]<=tg) then
		  begin
             inc(c); q[c]:=v+m; tr[q[c]]:=u;
             if py[v]=0 then
             begin
                dd:=q[c]; found:=true; exit;
             end;
		  end;
      end
      else
      begin
         inc(c); q[c]:=py[u-m]; tr[q[c]]:=u;
      end;
   end;
end;

procedure Tang(dd:bt);
var  ok:bb;
begin
   if not found then exit;
   ok:=true;
   while tr[dd]<>0 do
   begin
      if ok then
	  begin
         px[tr[dd]]:=dd-m;
         py[dd-m]:=tr[dd];
	  end;
      ok:=not ok; dd:=tr[dd];
   end;
end;

procedure Cap_Ghep;
var i,dd:bt;
begin
   fillchar(px,sizeof(px),0);
   fillchar(py,sizeof(py),0);
   for i:=1 to n do
   begin
      TimDuongTang(i,dd);
      if not found then exit;
      Tang(dd);
   end;
end;

procedure Ket_thuc;
begin
   assign(f,fo); rewrite(f);
   writeln(f,-1);
   close(f);
   halt;
end;

procedure Xu_Ly;
var  i,j:bt;
     d,l,r:ii;
begin
   min:=-1; tg:=maxint;
   Cap_ghep;
   if not found then Ket_thuc;
   for i:=1 to n do
    if a[px[i],i]>min then min:=a[px[i],i];
   kq:=px;
   l:=0; r:=min;
   while l<>r do
   begin
      tg:=(l+r) div 2;
      Cap_ghep;
      if found then
      begin
         d:=-1;
         for i:=1 to n do
    	  if a[px[i],i]>d then d:=a[px[i],i];
         if d<min then
         begin
            min:=d; kq:=px;
         end;
         r:=tg;
      end
      else
        l:=tg+1;
   end;
end;

procedure Inkq;
var i:bt;
begin
   writeln(min);
   assign(f,fo); rewrite(f);
   for i:=1 to n do write(f,kq[i],' ');
   close(f);
end;
begin
   Clrscr;
   Nhap;
   Xu_Ly;
   Inkq;
end.