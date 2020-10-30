{$M 16000,0,655360}
uses crt;
const
     fi='chess.inp';
     fo='chess.out';
     lt:array[1..16] of word=(32768,16384,8192,4096,2048,1024,512,256,128,
     64,32,16,8,4,2,1);
type
    m1=array[1..12870] of word;
    m3=array[1..65300] of byte;
var
   f:text;g:file of string;
   s1,s2,s4,sbd:word;
   x,y,z,t:byte;
   q1:^m1;truoc1,truoc2:^m3;
procedure nhap;
var
   i,j:byte;c:char;
begin
assign(f,fi);reset(f);
s1:=0;
for i:=1 to 4 do
    begin
    for j:=1 to 4 do
    begin read(f,c);if c='1' then s1:=s1+lt[(4*(i-1)+j)];end;
    readln(f);
    end;
s2:=0;
for i:=1 to 4 do
    begin
    for j:=1 to 4 do
    begin read(f,c);if c='1' then s2:=s2+lt[(4*(i-1)+j)];end;
    readln(f);
    end;
close(f);
end;
procedure trai(i:byte;r:word;var s4:word);
begin
s4:=r+lt[i-1]-lt[i];
end;
procedure phai(i:byte;r:word;var s4:word);
begin
s4:=r+lt[i+1]-lt[i];
end;
procedure len(i:byte;r:word;var s4:word);
begin
s4:=r+lt[i-4]-lt[i];
end;
procedure xuong(i:byte;r:word;var s4:word);
begin
s4:=r+lt[i+4]-lt[i];
end;
procedure bfs;
var
   dem,dau,cuoi,r:word;i:byte;
begin
if s1=s2 then exit;
fillchar(truoc1^,sizeof(truoc1^),0);
fillchar(truoc2^,sizeof(truoc2^),0);
dau:=1;cuoi:=1;q1^[dau]:=s1;
truoc1^[s1]:=1;truoc2^[s1]:=1;dem:=0;
while dau<=cuoi do
      begin
      r:=q1^[dau];inc(dau);
      for i:=1 to 16 do if (r and lt[i]) =lt[i] then
          begin
          if (i mod 4<>1)and((r and lt[i-1])=0) then
             begin
             trai(i,r,s4);
             if (truoc2^[s4]=0) then
                begin
                truoc1^[s4]:=1;truoc2^[s4]:=i;
                if s4=s2 then exit;
                inc(cuoi);
                q1^[cuoi]:=s4;
                end;
             end;
          if (i mod 4<>0)and((r and lt[i+1])=0) then
             begin
             phai(i,r,s4);
             if (truoc2^[s4]=0) then
                begin
                truoc1^[s4]:=2;truoc2^[s4]:=i;
                if s4=s2 then exit;
                inc(cuoi);
                q1^[cuoi]:=s4;
                end;
             end;
          if (i>4)and((r and lt[i-4])=0) then
             begin
             len(i,r,s4);
             if (truoc2^[s4]=0) then
                begin
                truoc1^[s4]:=3;truoc2^[s4]:=i;
                if s4=s2 then exit;
                inc(cuoi);
                q1^[cuoi]:=s4;
                end;
             end;
          if (i<13)and((r and lt[i+4])=0) then
             begin
             xuong(i,r,s4);
             if (truoc2^[s4]=0) then
                begin
                truoc1^[s4]:=4;truoc2^[s4]:=i;
                if s4=s2 then exit;
                inc(cuoi);
                q1^[cuoi]:=s4;
                end;
             end;
          end;
      end;
end;
procedure dc(u,v:byte;var s4:word;var x,y,z,t:byte);
{Trang thai co so hieu S2 voi truoc1=U va truoc2=V
duoc chuyen den tu trang thai co so hieu S4}
begin
case u of
1:
  begin
  s4:=s2+lt[v]-lt[v-1];
  if v mod 4=0 then begin x:=v div 4;y:=4;z:=x;t:=3;end
  else begin x:=v div 4 + 1;y:=v mod 4;z:=x;t:=y-1;end;
  end;
2:
  begin
  s4:=s2+lt[v]-lt[v+1];
  x:=v div 4 + 1;y:=v mod 4;z:=x;t:=y+1;
  end;
3:
  begin
  s4:=s2+lt[v]-lt[v-4];
  if v mod 4=0 then begin x:=v div 4;y:=4;z:=x-1;t:=y;end
  else begin x:=v div 4 + 1;y:=v mod 4;z:=x-1;t:=y;end;
  end;
4:
  begin
  s4:=s2+lt[v]-lt[v+4];
  if v mod 4=0 then begin x:=v div 4;y:=4;z:=x+1;t:=y;end
  else begin x:=v div 4 + 1;y:=v mod 4;z:=x+1;t:=y;end;
  end;
end;
end;
procedure viet;
var
   i:word;t1,xx,xy,xz,xt:string;
begin
assign(f,fo);rewrite(f);
if s1=s2 then writeln(f,0)
else
   begin
   sbd:=0;
   assign(g,'h.h');rewrite(g);
   while s2<>s1 do
         begin
         dc(truoc1^[s2],truoc2^[s2],s4,x,y,z,t);
         inc(sbd);
         str(x,xx);str(y,xy);str(z,xz);str(t,xt);
         t1:=xx+' '+xy+' '+xz+' '+xt;
         write(g,t1);
         s2:=s4;
         end;
   close(g);
   assign(g,'h.h');reset(g);
   writeln(f,sbd);
   for i:=sbd downto 1 do
       begin
       seek(g,i-1);
       read(g,t1);writeln(f,t1);
       end;
   end;
close(f);close(g);
end;
BEGIN
new(truoc1);new(truoc2);new(q1);
nhap;bfs;viet;
dispose(truoc1);dispose(truoc2);dispose(q1);
END.
