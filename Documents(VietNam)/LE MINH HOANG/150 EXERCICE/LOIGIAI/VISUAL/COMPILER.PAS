program Compiler;
const
 Bit: array[1..8] of Byte = (128, 64, 32, 16, 8, 4, 2, 1);
type
 TCharBuffer = array[0..255, 0..15] of Byte;
 PCharBuffer = ^TCharBuffer;
var
 f: Text;
 i, j, k: Integer;
 ch: Char;
 P: PCharBuffer;
begin
 New(P);
 FillChar(P^, SizeOF(P^), 0);
 Assign(f, '1.txt'); Reset(f);
 while not SeekEof(f) do
  begin
   Readln(f, i);
   for j := 0 to 15 do
    begin
     P^[i, j] := 0;
     for k := 1 to 8 do
      begin
       Read(f, ch);
       if ch = 'Û' then P^[i, j] := P^[i, j] or Bit[k];
      end;
     Readln(f);
    end;
  end;
 Close(f);
 Assign(f, 'Font.Arr'); Rewrite(f);
 for i := 0 to 255 do
  begin
   Write(f, ' (');
   for j := 0 to 14 do Write(f, P^[i, j]:3, ', ');
   if i <> 255 then Writeln(f, P^[i, 15]:3, '),')
   else Writeln(f, P^[i, 15]:3, ')')
  end;
 Close(f);
end.