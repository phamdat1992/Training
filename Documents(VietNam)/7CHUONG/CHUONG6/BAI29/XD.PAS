{$R+}
{$M 65000,0,0}
uses crt;
const
     fi='string.in4';
     fo='string.ou4';
th:array[0..26,0..26] of longint=
((1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,5,10,10,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,7,21,35,35,21,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,8,28,56,70,56,28,8,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,9,36,84,126,126,84,36,9,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,10,45,120,210,252,210,120,45,10,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,11,55,165,330,462,462,330,165,55,11,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,12,66,220,495,792,924,792,495,220,66,12,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,13,78,286,715,1287,1716,1716,1287,715,286,78,13,1,0,0,0,0,0,0,0,0,0,0,0,0,0),
(1,14,91,364,1001,2002,3003,3432,3003,2002,1001,364,91,14,1,0,0,0,0,0,0,0,0,0,0,0,0),
(1,15,105,455,1365,3003,5005,6435,6435,5005,3003,1365,455,105,15,1,0,0,0,0,0,0,0,0,0,0,0),
(1,16,120,560,1820,4368,8008,11440,12870,11440,8008,4368,1820,560,120,16,1,0,0,0,0,0,0,0,0,0,0),
(1,17,136,680,2380,6188,12376,19448,24310,24310,19448,12376,6188,2380,680,136,17,1,0,0,0,0,0,0,0,0,0),
(1,18,153,816,3060,8568,18564,31824,43758,48620,43758,31824,18564,8568,3060,816,153,18,1,0,0,0,0,0,0,0,0),
(1,19,171,969,3876,11628,27132,50388,75582,92378,92378,75582,50388,27132,11628,3876,969,171,19,1,0,0,0,0,0,0,0),
(1,20,190,1140,4845,15504,38760,77520,125970,167960,184756,167960,125970,77520,38760,15504,4845,1140,190,20,1,0,0,0,0,0,0),
(1,21,210,1330,5985,20349,54264,116280,203490,293930,352716,352716,293930,203490,116280,54264,20349,5985,1330,210,21,1,0,0,
0,0,0),
(1,22,231,1540,7315,26334,74613,170544,319770,497420,646646,705432,646646,497420,319770,170544,74613,26334,7315,1540,231,
22,1,0,0,0,0),
(1,23,253,1771,8855,33649,100947,245157,490314,817190,1144066,1352078,1352078,1144066,817190,490314,245157,100947,33649,
8855,1771,253,23,1,0,0,0),
(1,24,276,2024,10626,42504,134596,346104,735471,1307504,1961256,2496144,2704156,2496144,1961256,1307504,735471,346104,
134596,42504,10626,2024,276,24,1,0,0),
(1,25,300,2300,12650,53130,177100,480700,1081575,2042975,3268760,4457400,5200300,5200300,4457400,3268760,2042975,1081575,
480700,177100,53130,12650,2300,300,25,1,0),
(1,26,325,2600,14950,65780,230230,657800,1562275,3124550,5311735,7726160,9657700,10400600,9657700,7726160,5311735,3124550,
1562275,657800,230230,65780,14950,2600,325,26,1));
     n=26;
     moc:array[0..26] of longint=(0,26,351,2951,17901,83681,313911,971711,2533986,5658536,10970271,18696431,28354131,38754731,
     48412431,56138591,61450326,64574876,66137151,66794951,67025181,67090961,67105911,67108511,67108836,67108862,67108863);
     tt:array['a'..'z'] of longint=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26);
     chu:array[1..26] of char
     =('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
     cuoi:array[1..26] of string=('z','yz','xyz','wxyz','vwxyz','uvwxyz','tuvwxyz','stuvwxyz','rstuvwxyz','qrstuvwxyz',
     'pqrstuvwxyz','opqrstuvwxyz','nopqrstuvwxyz','mnopqrstuvwxyz','lmnopqrstuvwxyz','klmnopqrstuvwxyz','jklmnopqrstuvwxyz',
     'ijklmnopqrstuvwxyz','hijklmnopqrstuvwxyz','ghijklmnopqrstuvwxyz','fghijklmnopqrstuvwxyz','efghijklmnopqrstuvwxyz',
     'defghijklmnopqrstuvwxyz','cdefghijklmnopqrstuvwxyz','bcdefghijklmnopqrstuvwxyz','abcdefghijklmnopqrstuvwxyz');

var
   dem,sl,sm:longint;k:longint;
   f:text;
   xau,gm:array[1..1000] of char;s,mk:string;
   day,ma:array[1..1000] of longint;
   m,t:longint;
procedure nhap;
begin
assign(f,fi);reset(f);
m:=0;
while not(eoln(f)) do begin inc(m);read(f,xau[m]);end;readln(f);
sl:=0;
while not(seekeoln(f)) do
      begin inc(sl);read(f,day[sl]);end;
readln(f);
close(f);
end;
function doan(c1,c2:char;x:longint):longint;
{Tinh so tu do dai k tu tu do dai k dau tien co chu thu x la c1
den tu do dai k cuoi cung co chu thu x la pred(c2)}
var
   i,j,u,v:longint;
begin
i:=tt[c1];j:=tt[c2];
if c1=c2 then begin doan:=0;exit;end;
if x=k then begin doan:=j-i;exit;end;
u:=0;
for v:=i to j-1 do u:=u+th[n-v,k-x];
doan:=u;
end;
function sh(s:string):longint;
var
   x,y,tam:longint;c1,c2:char;
begin
k:=length(s);
if k=1 then begin sh:=tt[s[1]];exit;end;
if tt[s[1]]=n-k+1 then begin sh:=moc[k];exit;end;
tam:=moc[k-1];c1:='a';
for x:=1 to k do
    begin
    c2:=s[x];tam:=tam+doan(c1,c2,x);
    c1:=succ(c2);
    end;
sh:=tam+1;
end;
procedure cau1;
var
   x,y:longint;
begin
x:=1;sm:=0;
while x<=m do
      begin
      y:=x;
      if y<m then
         begin
         s:=xau[y];while (y<m)and(xau[y]<xau[y+1]) do
                     begin
                     s:=s+xau[y+1];inc(y);
                     end;
         inc(sm);ma[sm]:=sh(s);
         x:=y+1;
         end
      else
          begin
          inc(sm);ma[sm]:=ord(xau[m])-96;inc(x);
          end;
      end;
assign(f,fo);rewrite(f);
for x:=1 to sm do write(f,ma[x]:10);writeln(f);
close(f);
end;
function tim(x:longint):string;
{Tim tu co so hieu X}
var
   i,j,u,v:longint;tam:string;c1,c2:char;
begin
k:=0;
while moc[k]<x do inc(k);
{Tu can tim co do dai k:tam[1]tam[2]....tam[k]}
if moc[k]=x then begin tim:=cuoi[k];exit;end;
dec(x,moc[k-1]);
{Tu ung voi to hop chap K thu X trong so moi to hop chap K cua 26}
c1:='a';tam:='';
for j:=1 to k do
    begin
    c2:=c1;
    while (c2<='z')and(doan(c1,c2,j)<x) do inc(c2);
    if c2>'z' then begin tam:=tam+'z';tim:=tam;exit;end;
    if doan(c1,c2,j)=x then
       begin
       tam:=tam+pred(c2);
       if j<k then for u:=n-k+j+1 to n do tam:=tam+chu[u];
       tim:=tam;exit;
       end;
    tam:=tam+pred(c2);
    dec(x,doan(c1,pred(c2),j));
    c1:=c2;
    end;
tim:=tam;
end;
procedure cau2;
begin
assign(f,fo);append(f);
for t:=1 to sl do write(f,tim(day[t]));
writeln(f);
close(f);
end;
BEGIN
nhap;cau1;cau2;
END.