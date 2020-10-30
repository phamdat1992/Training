{$A+,B-,D-,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Traffic;
uses crt;
const
 InputFile  = 'TRAFFIC.IN';
 OutputFile = 'TRAFFIC.OUT';
 max = 100;
 maxLong = 1000000000;
 dx: array[1..4] of ShortInt = (0, 1, -1, 0);
 dy: array[1..4] of ShortInt = (1, 0, 0, -1);
 Symbol: String[4] = 'ESNW';
type
 TList = array[1..max * max] of Byte;
 PList = ^TList;
 TDistance = array[1..max, 1..max] of LongInt;
 PDistance = ^TDistance;
var
 a: array[1..max, 1..max] of Word;
 F: PDistance;
 Free: array[0..max + 1, 0..max + 1] of Boolean;
 Trace: array[1..max, 1..max] of Byte;
 ListX, ListY: PList;
 m, n, nList: Integer;
 ch: Char;
 ShortestPath: LongInt;
 YourPath: LongInt;
 P1, P2: Word;

procedure Enter;
var
 f: Text;
 i, k, x, y: Integer;
begin
 Textattr := 7;
 Clrscr;
 Writeln('                      CHAM BAI "TIN HIEU GIAO THONG"');
 Writeln('                      ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß');
 Write('                      Cham Test TRAFFIC.IN');
 ch := Readkey; Writeln(ch);
 Assign(f, InputFile + ch); Reset(f);
 Readln(f, m, n);
 Readln(f, k);
 FillChar(a, SizeOf(a), 0);
 for i := 1 to k do Readln(f, x, y, a[x, y]);
 Close(f);
end;

procedure Update(x, y: Byte; d: Word);
var
 i: Integer;
begin
 if F^[x, y] <= d then Exit;
 if F^[x, y] = maxLong then
  begin
   Inc(nList);
   ListX^[nList] := x; ListY^[nList] := y;
  end;
 F^[x, y] := d;
end;

procedure GetPermanent(var x, y: Byte);
var
 i, imin: Integer;
 temp: Integer;
begin
 imin := 1;
 for i := 1 to nList do
  if F^[ListX^[i], ListY^[i]] < F^[ListX^[imin], ListY^[imin]] then imin := i;
 x := ListX^[imin]; y := ListY^[imin];
 temp := ListX^[nList]; ListX^[nList] := ListX^[imin]; ListX^[imin] := temp;
 temp := ListY^[nList]; ListY^[nList] := ListY^[imin]; ListY^[imin] := temp;
 Dec(nList);
end;

procedure Init;
var
 i, j: Integer;
begin
 FillChar(Free, SizeOf(Free), False);
 for i := 1 to m do
  for j := 1 to n do Free[i, j] := True;
 New(F);
 for i := 1 to m do
  for j := 1 to n do F^[i, j] := maxLong;
 nList := 0;
 New(ListX); New(ListY);
 Update(1, 1, 0);
end;

function WaitTime(x, y, d: Byte; Time: Word): Word;
var
 SN, DirSN: Boolean;
begin
 if a[x, y] = 0 then WaitTime := 0
 else
  begin
   SN := Odd(Time div a[x, y]);
   DirSN := d in [2, 3];
   if DirSN = SN then WaitTime := 0
   else WaitTime := a[x, y] - Time mod a[x, y];
  end;
end;

procedure Dijkstra;
var
 xp, yp, x, y: Byte;
 dp: Word;
 d: Byte;
begin
 repeat
  GetPermanent(xp, yp);
  if (xp = m) and (yp = n) then Break;
  Free[xp, yp] := False;
  dp := F^[xp, yp] + 1;
  for d := 1 to 4 do
   begin
    x := xp + dx[d]; y := yp + dy[d];
    if Free[x, y] and (F^[x, y] > dp + WaitTime(x, y, d, dp)) then
     begin
      Update(x, y, dp + WaitTime(x, y, d, dp));
      Trace[x, y] := d;
     end;
   end;
 until False;
end;

procedure Result;
begin
 ShortestPath := F^[m, n];
end;

procedure Test1;
var
 f: Text;
begin
 Assign(f, OutputFile + ch); Reset(f);
 Readln(f, YourPath);
 Writeln('Kiem tra do dai duong di: ');
 Writeln('  + Ket qua dung: ', ShortestPath);
 Writeln('  + Ket qua HS  : ', YourPath);
 if YourPath <> ShortestPath then
  begin
   Writeln(#7'Error!');
   P1 := 0
  end
 else
  begin
   Writeln('Correct!');
   P1 := 1;
  end;
 Close(f);
end;

procedure Test2;
var
 f: Text;
 p, i, nS, x, y: Integer;
 S: array[1..10000] of Char;
 wTime: LongInt;
begin
 Writeln('Kiem tra tinh dung dan cua duong di');
 P2 := 0;
 Assign(f, OutputFile); Reset(f);
 Readln(f);
 nS := 0;
 while not SeekEoln(f) do
  begin
   Inc(nS);
   Read(f, S[nS]);
   if not (S[nS] in ['w', 'E', 'W', 'S', 'N']) then
    begin
     Writeln('Error!');
     Writeln('  + Sai khuon dang du lieu');
     Close(f); Exit;
    end;
  end;
 if nS <> YourPath then
  begin
   Writeln('Do dai duong di khong dung');
   Close(f); Exit;
  end;
 x := 1; y := 1;
 for i := 1 to nS do
  begin
   p := Pos(S[i], Symbol);
   if p <> 0 then
    begin
     x := x + dx[p]; y := y + dy[p];
    end;
   if (x <= 0) or (x > m) or (y <= 0) or (y > n) then
    begin
     Writeln(#7'Error!');
     Writeln('  + Di duong rung!');
     Close(f); Exit;
    end;
  end;
 x := 1; y := 1;
 wTime := 0;
 for i := 1 to nS do
  begin
   p := Pos(S[i], Symbol);
   if (wTime > 0) and (p > 0) then
    begin
     Writeln(#7'Error!');
     Writeln('  + Vuot den do');
     Close(f); Exit;
    end;
   if p <> 0 then
    begin
     x := x + dx[p]; y := y + dy[p];
     wTime := WaitTime(x, y, p, i);
    end
   else Dec(wTime);
  end;
 Close(f);
 Writeln('Correct!');
 P2 := 1;
end;

procedure Ghidiem(r: Integer);
var
 f: file of Integer;
 a: array['0'..'9'] of Integer;
 p: Integer;
 i, j: Char;
begin
 if ch = '1' then
  begin
   Assign(f, 'DIEM.DAT'); Rewrite(f);
   p := -1;
   for i := '0' to '9' do Write(f, p);
   Close(f);
  end;
 Assign(f, 'DIEM.DAT'); Reset(f);
 for i := '0' to '9' do Read(f, a[i]);
 a[ch] := r;
 Close(f);
 Rewrite(f);
 for i := '0' to '9' do Write(f, a[i]);
 Close(f);
 p := 0;
 for i := '1' to ':' do
  begin
   if i = ':' then j := '0' else j := i;
   if a[j] <> -1 then
    begin
     Writeln('Diem cho test TRAFFIC.IN', j, ': ', a[j] / 2:1:0);
     p := p + a[j];
    end
   else
    Writeln('Test TRAFFIC.IN', j, ' chua cham');
  end;
 TextAttr := 30;
 Writeln('Tong diem: ', p / 2 : 1: 2);
end;

begin
 Enter;
 Init;
 Dijkstra;
 Result;
 Test1;
 TextAttr := 78; Writeln('Diem = ', P1 / 2:2:1); TextAttr := 7;
 Test2;
 TextAttr := 78; Writeln('Diem = ', P2 / 2:2:1); TextAttr := 7;
 GhiDiem(p1 + p2);
 TextAttr := 7; Writeln;
 repeat
  ReadKey;
 until not Keypressed;
end.
