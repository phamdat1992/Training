        {***********************************************************}
        {*                   Nguyen Trong Quyen                    *}
        {*                       A2 K30 PBC                        *}
        {***********************************************************}
{$M 16384,0,655360}
{$R+}
Program TQA2K30PBC;
Uses Crt;
Const
     Dl                 =       'Game.inp';
     Kq                 =       'Game.out';
     Maxn               =       10000;
     maxm               =       5000;
     bcc                =       26; {bang chu cai}
     gt  : array ['a'..'z'] of byte = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                               16,17,18,19,20,21,22,23,24,25,26         );
     xx  : array [1..26] of char = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
                 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                 'u', 'v', 'w', 'x', 'y', 'z');
Type
    Arr1                =       Array [1..Maxn] of Byte;
    arr2                =       array [1..maxm] of char;
Var
   sod, so              :       Arr1; {luu so[1] la hang don vi}
   s, xau               :       arr2; {sod la so cho boi du lieu }
   n, m                 :       Integer; {so mang luu xau s chuyen thanh so}
   f                    :       Text;
   Time                 :       Longint absolute 0000: $0046c;
   LuuTime              :       Longint;
   pmark                :       pointer;

Procedure Input;
Var
   i, code              :       integer;
   k                    :       char;
Begin
Assign(f, dl);
Reset(f);
n := 0;
while not seekeoln(f) do
      begin     read(f, k); inc(n);     val(k, sod[n], code);     end;
{mang sod[n] duoc quy uoc la hang don vi}
readln(f);  m := 0;
while not seekeoln(f) do
      begin  inc(m);   read(f, s[m]); end;

Close(f);
Assign(f, kq);
Rewrite(f);
End;

procedure nhan(var so: arr1; var skt: integer; sonhan: byte);
var
   nho, t, i            :       integer;
begin
nho := 0;
for i := 1 to skt do
    begin
    t := so[i];  t := t * sonhan + nho;
    so[i] := t mod 10;
    nho := t div 10;
    end;
while nho <> 0 do
      begin  inc(skt); so[skt] := nho mod 10;  nho := nho div 10; end;
end;


procedure cong(var so: arr1; var skt: integer; sohang: byte);
var
   nho, t, i            :       integer;
begin
nho := sohang;
for i := 1 to skt do
    begin
    t := so[i] + nho;
    so[i] := t mod 10;
    nho := t div 10;
    if nho = 0 then break;
    end;
while nho <> 0 do
      begin  inc(skt); so[skt] := nho mod 10;  nho := nho div 10; end;
end;


Procedure doichuthanhso(var so: arr1; var skt, m: integer);
{tinh xau s thanh so - xau s co m ki tu}
var
   i, t                 :       integer;
begin
t := 0;
fillchar(so, sizeof(so), 0);
skt := 0;
for i := 1 to m do
    begin
    nhan(so, skt, bcc);
    cong(so, skt, gt[s[i]]);
    end;
end;


procedure chialaydu(var n, sodu: integer; sochia: integer);
{chia so luu boi mang so va thuong gan lai vao mang so}
var
   i, dem, t, j         :       integer;
   tam                  :       arr1;
begin
sodu := sod[1];   i := 1;  dem := 0;
fillchar(tam, sizeof(tam), 0);
i := 0; dem := 0; t := 0;
while i < n do
       begin
       inc(i); j := t * 10 + sod[i];
       if j > sochia then begin dec(i); break end
       else t := j;
       end;
while i < n do
      begin
      inc(i); t := t * 10 + sod[i];
      inc(dem); tam[dem] := t div sochia;
      if t >= sochia then t := t mod sochia;
      end;
sodu := t;
n := dem;
sod := tam;
if sodu = 0 then {tru so cho 1}
   begin
   sodu := sochia;
   if sod[n] > 0 then sod[n] := sod[n] - 1
   else
       begin
       i := n;
       while (sod[i] = 0) and (i > 0) do dec(i);
       if i = 1 then
          begin
          dec(n); sod[1] := sod[i] - 1; for j := 2 to n do sod[j] := 9;
          end
       else
          begin
          sod[i] := sod[i] - 1;
          for j := i + 1 to n do sod[j] := 9;
          end;
       end;
   end;
end;

procedure doisothanhchu(var dodai: integer; n: integer);
var
   i, j, sodu, dem      :       integer;
begin
fillchar(xau, sizeof(xau), 0);
dodai := 0;
while n > 0 do
      begin
      chialaydu(n, sodu, bcc);
      inc(dodai);
      xau[dodai] := xx[sodu];
      end;
end;


Procedure Output;
Var
   i, skt, dodai        :       Integer;
   j                    :       char;
Begin
doichuthanhso(so, skt, m);
doisothanhchu(dodai, n); {luu vao mang xau}
for i := dodai downto 1 do
    write(f, xau[i]); writeln(f);
for i := skt downto 1 do
    write(f, so[i]);
Close(f);
for j := 'a' to 'z' do write(j);
End;

Begin
clrscr;
LuuTime := Time;
mark(pmark);
Input;
Output;
release(pmark);
Textcolor(red);
Writeln('          *********************************************************');
Writeln('          *                  Time Run: ', (Time - LuuTime)/18.21:8:2,'                   *');
Writeln('          *********************************************************');
Textcolor(11);
Writeln('                       Please any key to exit');
End.
157118051752
snowfall