{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

program Bo_Ghep_CD;
const
	fi='bg.inp';
	fo='bg.out';
	mn=250;
var
	f:text;
	n,m:integer;
	bgx,bgy,luu:array [1..mn] of integer;
	vsy:array [1..mn] of boolean;
	a:array [1..mn,1..mn] of 0..1;
(**************************************)

procedure nhap;
var
	i,j:integer;
 begin
  assign(f,fi);
  reset(f);
  readln(f,m,n);
  for i:=1 to n do
   begin
	for j:=1 to n do read(f,a[i,j]);
	readln(f);
   end;
  close(f);
 end;
 (*********************)

procedure bgm;
label done;
var  i,j,k:integer;
	 st:string;
 begin
  fillchar(bgx,sizeof(bgx),0);
  fillchar(bgy,sizeof(bgy),0);
  for i:=1 to m do
   if (bgx[i]=0) then
	begin
	 st:=char(i);
	 fillchar(vsy,sizeof(vsy),false);
	 fillchar(luu,sizeof(luu),0);
	 repeat
	  k:=ord(st[1]);
	  delete(st,1,1);
	  for j:=1 to n do
	   if (a[k,j]=1) and (vsy[j]=false) then
		begin
		 luu[j]:=k;
		 vsy[j]:=true;
		 if (bgy[j]<>0) then st:=st+chr(bgy[j])
		 else
		  begin
		   repeat
			bgy[j]:=luu[j];
			k:=bgx[bgy[j]];
			bgx[bgy[j]]:=j;
			j:=k;
		   until j=0;
		   goto done;
		  end;
		end;
		until st='';
	done:end;
 end;
(******************************)

procedure xuat;
var dem,i:integer;

 begin
  assign(f,fo);
  rewrite(f);
  dem:=0;
  for i:=1 to m do
   if (bgx[i]<>0) then inc(dem);
  writeln(f,dem);
  for i:=1 to m do
   if (bgx[i]<>0) then writeln(f,i,' ',bgx[i]);
   close(f);
 end;
  (**************************)

 BEGIN
  nhap;
  bgm;
  xuat;
 END.

4 4
0 1 1 0
1 1 0 0
1 0 1 0
0 0 1 1


