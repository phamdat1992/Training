program Schedule;
const
 InputFile  = 'B1.IN5';
 OutputFile = 'B1.OUT';
 maxN = 500;
 maxM = 20000;
type
 TIntArray = array[1..maxM] of Integer;
 TByteArray = array[1..maxM] of Byte;
 PIntArray = ^TIntArray;
 PByteArray = ^TByteArray;
var
 eu, ev, ei, ed: PIntArray;
 ep, ec, emark: PByteArray;
 mark: TByteArray;
 Lab: array[1..maxN] of Integer;
 DayLab: TIntArray;
 n, m, k, dcount: Integer;

procedure GoOut;
var
  f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, -1);
 Close(f);
 Halt;
end;

procedure Enter;
var
 f: Text;
 i: Integer;
begin
 New(eu); New(ev); New(ec); New(emark); New(ep);
 New(ei); New(ed);
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m, k);
 for i := 1 to m do
  begin
   Readln(f, eu^[i], ev^[i]);
   ei^[i] := i;
  end;
 Close(f);
end;

procedure Swap(i, j: Integer);
var
 t: Integer;
begin
 t := eu^[i]; eu^[i] := eu^[j]; eu^[j] := t;
 t := ev^[i]; ev^[i] := ev^[j]; ev^[j] := t;
 t := ec^[i]; ec^[i] := ec^[j]; ec^[j] := t;
 t := emark^[i]; emark^[i] := emark^[j]; emark^[j] := t;
 t := ep^[i]; ep^[i] := ep^[j]; ep^[j] := t;
 t := ei^[i]; ei^[i] := ei^[j]; ei^[j] := t;
 t := ed^[i]; ed^[i] := ed^[j]; ed^[j] := t;
end;

procedure InitLab;
var i: Integer;
begin
 for i := 1 to maxN do Lab[i] := -1;
end;

function GetRoot(u: Integer): Integer;
begin
 while Lab[u] > 0 do u := Lab[u];
 GetRoot := u;
end;

procedure Union(r1, r2: Integer);
var
 x: Integer;
begin
 x := Lab[r1] + Lab[r2];
 if Lab[r1] > Lab[r2] then
  begin
   Lab[r1] := r2;
   Lab[r2] := x;
  end
 else
  begin
   Lab[r2] := r1;
   Lab[r1] := x;
  end;
end;

procedure GetMST;
var
 i, r1, r2, ecount: Integer;
begin
 InitLab;
 FillChar(emark^, SizeOf(emark^), 0);
 eCount := 0;
 for i := 1 to m do
  begin
   r1 := GetRoot(eu^[i]); r2 := GetRoot(ev^[i]);
   if r1 <> r2 then
    begin
     emark^[i] := 1;
     Inc(eCount);
     if eCount = n - 1 then Break;
     Union(r1, r2);
    end;
  end;
end;

procedure GetPriority;
var
 i, k: Integer;
begin
 FillChar(ec^, SizeOf(ec^), 0);
 FillChar(ep^, SizeOf(ep^), 0);
 GetMST;
 for i := 1 to m do
  if emark^[i] = 1 then ep^[i] := 1;
 k := m;
 for i := m downto 1 do
  if emark^[i] = 1 then
   begin
    Swap(i, k); Dec(k);
   end;
 GetMST;
 for i := 1 to m do
  if (emark^[i] = 1) and (ep^[i] = 1) then ep^[i] := 2;
end;

procedure SortByPriority;
var
 v, i, k: Integer;
begin
 k := m;
 for v := 2 downto 1 do
  for i := k downto 1 do
   if ep^[i] = v then
    begin
     Swap(i, k);
     Dec(k);
    end;
end;

function FindMSF: Integer;
var
 w, c, i, ecount, r1, r2: Integer;
begin
 InitLab;
 FillChar(emark^, SizeOf(emark^), 0);
 ecount := 0; w := 0;
 for c := 0 to 1 do
  for i := 1 to m do
   if ec^[i] = c then
    begin
     r1 := GetRoot(eu^[i]); r2 := GetRoot(ev^[i]);
     if r1 <> r2 then
      begin
       emark^[i] := 1;
       w := w + ec^[i];
       Inc(ecount);
       if ecount = n - 1 then
        begin
         FindMSF := w; Exit;
        end;
       Union(r1, r2);
      end;
    end;
end;

procedure Solve;
var
 i, rcount, w: Integer;
 Nosolution: Boolean;
begin
 SortByPriority;
 for i := 1 to m do ec^[i] := 1;
 FillChar(ed^, SizeOf(ed^), 0);
 dcount := 0;
 repeat
  Inc(dcount);
  w := FindMSF;   {Truoc het dung cay khung}
  rcount := 0;
  Nosolution := True;
  for i := m downto 1 do {Sua nhung canh ngoai cay khung theo thu tu uu tien}
   if (ec^[i] = 1) and (emark^[i] = 0) then
    begin
     Nosolution := False;
     ec^[i] := 0;
     ed^[i] := dcount;
     Inc(rcount);
     if rcount = k then Break;
    end;
  if Nosolution then GoOut;
 until w = 0;
 for i := 1 to m do  {Sua kieu gi cung xong}
  if ec^[i] = 1 then
   begin
    Inc(rcount);
    if rcount > k then
     begin
      rcount := 1;
      Inc(dcount);
     end;
    ed^[i] := dcount;
   end;
 for i := 1 to m do
  daylab[ei^[i]] := ed^[i];
end;

procedure Result;
var
 f: Text;
 i: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, dcount);
 for i := 1 to m do Writeln(f, daylab[i]);
 Close(f);
end;

begin
 Writeln(memavail);
 Enter;
 GetPriority;
 Solve;
 Result;
 Writeln(memavail);
end.
