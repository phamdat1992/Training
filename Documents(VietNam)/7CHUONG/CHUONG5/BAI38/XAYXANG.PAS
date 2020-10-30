{$R+,Q+}
(*  Le Van Hung *)
(* Hoa_Tra_My Group *)
program tim_vi_tri;

const
     inp = 'vitri.in1';
     out = 'vitri.out';
     infmax = high(integer);
     infmin = low (integer);
     maxn = 200;
type
     dn = 0..maxn+1;
     m1 = array[dn] of longint;
     m2 = array[1..20000] of integer;
     m3 = array[0..32000] of boolean;
     m4 = array[dn] of boolean;
var
     f : text;
     d : m1;
     q : ^m3;
     max : m2;
     kq : m4;
     kl,sl,n,k : integer;

procedure nhap;
var i : integer;
begin
     assign(f,inp); reset(f); readln(f,n,k);
     for i:=1 to n do read(f,d[i]);
     close(f);
end;

function somax(s1,s2 : integer ) : integer;
begin
     if s1>s2 then somax:=s1 else somax:=s2;
end;

function somin(s1,s2 : integer ) : integer;
begin
     if s1<s2 then somin:=s1 else somin:=s2;
end;

procedure chondai;
var i,l,tr : integer;
begin
     kl:=infmin;
     i:=1; tr:=0; l:=n div k;
     repeat
           if kl<(d[i]-d[tr]) then kl:=d[i]-d[tr];
           tr:=i; inc(i,l);
     until i>n;
     if kl<(d[n]-d[tr]) then kl:=d[n]-d[tr];
end;

procedure danhdau;
var i,j : integer;
begin
     fillchar(q^,sizeof(q^),0);
     for i:=1 to n do for j:=i+1 to n do q^[d[j]-d[i]]:=true;
end;

procedure timmax;
var i : integer;
begin
     sl:=0;
     for i:=0 to somin(kl,d[n]-d[1]) do
     if (q^[i]) then
        begin
             inc(sl);
             max[sl]:=i;
        end;
end;

function dung(ss : integer ) : boolean;
var i,j,dem : integer;
begin
     dem:=0; i:=1;
     repeat
           j:=i;
           while (j<=n)and((d[j]-d[i])<=ss) do inc(j);
           dec(j); i:=j;
           while (j<=n)and((d[j]-d[i])<=ss) do inc(j);
           i:=j; inc(dem);
     until (i>n);
     dung:=dem<=k
end;

procedure nhiphan;
var l,r,tg : integer;
begin
     l:=1; r:=sl;
     while l<r do
     begin
          tg:=(l+r) div 2;
          if dung(max[tg]) then r:=tg else l:=tg+1;
     end;
     while not dung(max[r]) do dec(r);
     kl:=max[r];
end;

procedure timkq;
var i,j : integer;
begin
     i:=1;
     fillchar(kq,sizeof(kq),0);
     repeat
           j:=i;
           while (j<=n)and((d[j]-d[i])<=kl) do inc(j);
           dec(j); i:=j; kq[i]:=true;
           while (j<=n)and((d[j]-d[i])<=kl) do inc(j);
           i:=j;
     until (i>n);
     j:=k;
     for i:=1 to n do
     if kq[i] then dec(j);
     i:=1;
     while j<>0 do
     begin
          if not kq[i] then
          begin
               kq[i]:=true;
               dec(j);
          end;
          inc(i);
     end;
end;

procedure xuly;
begin
     chondai;
     danhdau;
     timmax;
     nhiphan;
     timkq;
end;

procedure xuat;
var i : integer;
begin
     assign(f,out); rewrite(f);
     for i:=1 to n do
     if kq[i] then writeln(f,i);
     close(f);
end;

procedure make;
var i,j : integer;
const
     n = 200;
     k = 30;
     max = 200;
begin
     assign(f,inp); rewrite(f);
     writeln(f,n,' ',k);
{     randomize; j:=1;
     for i:=1 to n do
     begin
          writeln(f,j);
          inc(j,random(random(max)));
          if (j>32000)or(j<=0) then j:=32000;
     end;}
     j:=max div k;
     for i:=1 to n do
     begin
          {if i<n then writeln(f,32000) else writeln(f,1);}
          writeln(f,j*i);
     end;
     close(f);
end;

procedure kiemtra;
var i,j : integer;
begin
     nhap;
     assign(f,out); reset(f);
     j:=0;
     while not seekeof(f) do
     begin
          readln(f,i);
          inc(j);
      end;
     close(f);
     writeln(j=k);
end;

begin
     nhap;
     new(q);
     xuly;
     xuat;
     dispose(q);
end.