PROGRAM NOI_DAY_DIEN_PHUC_VU_THI_OLYMPIC_TIN_HOC;
uses crt;
const finp='noiday.in5';
	    fout='noiday.out';
      maxn=100;
type kma=array[0..maxn,0..maxn] of byte;
var fi,fo:text;
    a:array[0..maxn,0..maxn] of real;
    b:array[0..maxn] of record x,y:real;end;
    c:^kma;
    cx:array[0..maxn] of boolean;
    dinh:array[0..maxn] of integer;
    nea:array[0..maxn] of byte;
    d:array[0..maxn] of real;
    n:integer;
    dai:real;
procedure init;
var i:integer;
begin
     assign(fi,finp);reset(fi);
     readln(fi,n);
     b[0].x:=0;b[0].y:=0;
     for i:=1 to n do readln(fi,b[i].x,b[i].y);
     close(fi);
end;
procedure prepare;
var i,j:integer;
begin
     for i:=0 to n do
         for j:=0 to n do
             if i=j then a[i,j]:=0
             else a[i,j]:=sqrt(sqr(b[i].x-b[j].x)+sqr(b[i].y-b[j].y));
end;
procedure make;
var sd,i,j,giu:integer;
    min:real;
begin
     fillchar(cx,sizeof(cx),true);
     dai:=0;
     sd:=1;
     cx[0]:=false;
     for i:=1 to n do
         begin
              nea[i]:=0;
              d[i]:=a[0,i];
         end;
     fillchar(c^,sizeof(c^),0);
     while sd<=n do
           begin
                min:=1.7E38;
                for i:=0 to n do
                    if (cx[i]) and (d[i]<min) then
                       begin
                            min:=d[i];
                            giu:=i;
                       end;
                cx[giu]:=false;
                inc(sd);
                c^[giu,nea[giu]]:=1;
                c^[nea[giu],giu]:=1;
                dai:=dai+a[giu,nea[giu]];
                for i:=0 to n do
                    if (cx[i]) and(d[i]>a[giu,i]) then
                       begin
                            d[i]:=a[giu,i];
                            nea[i]:=giu;
                       end;
           end;
end;
procedure result;
var i,j:integer;
begin
     assign(fo,fout);rewrite(fo);
     writeln(fo,n);
     for i:=0 to n do
     	for j:=0 to n do if c^[i,j]=1 then
        begin
			c^[j,i]:=0;
			writeln(fo,i,' ',j);
        end;
     close(fo);

end;
begin
     clrscr;
     new(c);
     init;
     prepare;
     make;
     result;
end.
