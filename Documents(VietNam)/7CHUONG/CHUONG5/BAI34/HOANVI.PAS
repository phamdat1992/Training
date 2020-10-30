uses crt;
const
     fi='hv.inp';
     fo='hv.out';
type
    mang=array[1..15]of longint;
var
   b,t,a:MAng;
   n,dem:Integer;
   c:Array[1..15]of boolean;
   gt:array[0..15]of longint;
   f,g:Text;

procedure init;
var i:Integer;
begin
     gt[0]:=1;
     for i:=1 to 12 do gt[i]:=gt[i-1]*i;
end;

procedure so_hieu(a:Mang;n:Integer);
var dem,i,j:Integer;
    tong:longint;
begin
     tong:=0;
     fillchar(c,sizeof(c),true);
     for i:=1 to n-1 do
     begin
          dem:=0;
          for j:=a[i]-1 downto 0 do
           if c[j] then inc(dem);
          tong:=tong+gt[n-i]*dem;
          c[a[i]]:=false;
     end;
     writeln(g,tong+1);
end;

procedure nguoc(so__hieu:longint;n:Integer);
var i,j,dem,ll:Integer;
    sohieu:longint;
begin
     fillchar(b,sizeof(b),0);
     fillchar(a,sizeof(a),0);
     fillchar(c,sizeof(c),true);
     ll:=0;
     sohieu:=so__hieu;
     for i:=n downto 2 do
     begin
          if sohieu mod gt[i-1]=0 then
          begin
               b[i]:=sohieu div gt[i-1]-1;
               sohieu:=gt[i-1];
          end
          else
          begin
               b[i]:=sohieu div gt[i-1];
               sohieu:=sohieu mod gt[i-1];
          end;
     end;
     for i:=n downto 2 do
     begin
          dem:=0;
          j:=0;
          while dem<>b[i]+1 do
          begin
               inc(j);
               if c[j] then inc(dem);
          end;
          inc(ll);
          a[ll]:=j;
          c[j]:=false;
     end;
     for j:=1 to n do if c[j] then a[n]:=j;
     for j:=1 to n do  write(g,a[j],' ');writeln(g);
end;
procedure readfile;
var x,i:longint;
begin
     clrscr;
     assign(f,fi);assign(g,fo);
     reset(f); rewrite(g);
     while not seekeof(f) do
     begin
          dem:=0;
          while not seekeoln(f) do
          begin
               read(f,x);inc(dem);a[dem]:=x;
          end;
          readln(f);
          if dem>2 then
          so_hieu(a,dem)
          else
          nguoc(a[2],a[1]);
     end;
     close(f); close(g);
end;

begin
     init;
     readfile;
end.
3 5
3 2 1


