{$R+}
Program Chess;
Uses crt;
Const
     Fi='chess.inp';
     Fo='chess.out';
     Maxn=4;
     d:array[1..4] of integer=(-1, 0, 1, 0);
     c:array[1..4] of integer=(0, 1, 0, -1);
Type
	kpt = record
    	d,c:integer;
    end;

    out = record
        x,y,z,t:integer;
    end;
Var
   a,b:array[0..maxn+1,0..maxn+1] of integer;
   chuadi:array[0..maxn+1,0..maxn+1] of boolean;
   kq:array[1..200] of out;

   chuadi2,chuadi1:array[0..5,0..5] of boolean;
   buoc:word;
   luu,xy,zt:array[1..2000] of kpt;
   hangdoi:array[1..2000] of kpt;
   truoc:array[1..2000] of byte;
   dem:integer;
   k,i,j,m,n,x,y,z,t:integer;
   f:text;
   ch:char;
   sobuoc:integer;

Procedure readf;
Var
   f:text;
Begin
     Assign(f,fi);
     Reset(f);

     For i:=1 to maxn do
     begin
          For j:=1 to maxn do
          begin
               read(f,ch);
               Case ch of
                    '1': a[i,j]:=1;
                    '0': a[i,j]:=0;
               end;
          end;
          readln(f);
     end;

     For i:=1 to maxn do
     Begin
          For j:=1 to maxn do
          begin
               read(f,ch);
               Case ch of
                    '1': b[i,j]:=1;
                    '0': b[i,j]:=0;
               end;
          end;
          readln(f);
     end;
     Close(F);
End;

Procedure Init;
Begin
     Fillchar(a,sizeof(a),1);
     Fillchar(b,sizeof(b),1);
     Fillchar(kq,sizeof(kq),0);

     fillchar(chuadi2,sizeof(chuadi2),True);
     Fillchar(chuadi1,sizeof(chuadi1),False);

     for i:=1 to 4 do
         For j:=1 to 4 do
         begin
              chuadi1[i,j]:=False;
              chuadi2[i,j]:=False;
         end;

     For i:=1 to maxn do
         for j:=1 to maxn do
         begin
              a[i,j]:=0;
              b[i,j]:=0;
         end;

     Readf;

     Assign(f,fo);
     Rewrite(f);
     sobuoc:=0;
     dem:=0;
End;

Function ok:boolean;
Var
   i,j:integer;
Begin
     ok:=false;
     For i:=1 to maxn do
         for j:=1 to maxn do
             if a[i,j]<>b[i,j] then exit;
     ok:=true;
End;

procedure try(i,j,x:byte);
var
   u,v:byte;
   dau,cuoi:byte;
begin
     u:=i;v:=j;
     buoc:=0;dau:=1;
     cuoi:=1;hangdoi[dau].d:=i;
     hangdoi[dau].c:=j;chuadi1:=chuadi2;

	 truoc[1]:=0;chuadi1[i,j]:=true;

     while (dau<=cuoi) and (a[u,v]=x) do
     begin
          u:=hangdoi[dau].d;v:=hangdoi[dau].c;
          chuadi1[u,v]:=true;

          for k:=1 to 4 do
              if not chuadi1[u+d[k],v+c[k]] then
              begin
                   inc(cuoi);
                   hangdoi[cuoi].d:=u+d[k];
                   hangdoi[cuoi].c:=v+c[k];
                   truoc[cuoi]:=dau;
              end;
              inc(dau);
     end;

     while cuoi<>0 do
     begin
          inc(buoc);
          xy[buoc].d:=hangdoi[cuoi].d;
          xy[buoc].c:=hangdoi[cuoi].c;
          cuoi:=truoc[cuoi];
     end;
     zt:=xy;

     for u:=1 to buoc do xy[u]:=zt[buoc-u+1];

     v:=a[i,j];
     a[i,j]:=a[xy[buoc-1].d,xy[buoc-1].c];
     a[xy[buoc-1].d,xy[buoc-1].c]:=v;
     chuadi2[i,j]:=true;

     Inc(dem);
     kq[dem].x:=xy[1].d;
     kq[dem].y:=xy[1].c;
     kq[dem].z:=xy[2].d;
     kq[dem].t:=xy[2].c;

     buoc:=buoc-2;
end;

Procedure Main;
Var
   k,i,j:integer;
Begin
     If ok then
     begin
          Writeln(f,0);
          close(f);
          Halt;
     end;

     Fillchar(chuadi,sizeof(chuadi),False);
     For i:=1 to maxn do
         for j:=1 to maxn do chuadi[i,j]:=true;

     For i:=1 to maxn do
         for j:=1 to maxn do
             if a[i,j]<>b[i,j] then
             begin
			 	  Try(i,j,a[i,j]);
                  sobuoc:=sobuoc+buoc;
             End;
End;

Procedure Done;
Begin
     Writeln(f,sobuoc);
     For i:=1 to sobuoc do writeln(f,kq[i].x,' ',kq[i].y,' ',kq[i].z,' ',kq[i].t);
     Close(f);
End;

BEGIN
     Clrscr;
     Init;
     Main;
     Done;
END.
1111
0000
1110
0010
1010
0101
1010
0101


1111
0000
1110
0010
1010
0011
1010
0101
