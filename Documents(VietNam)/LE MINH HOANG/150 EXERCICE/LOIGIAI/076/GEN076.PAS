program GuesTBox;
const
 InputFile: string = '.INP';
 OutputFile: string = '.OUT';
 s: String = '1234567890';
 max = 10000;
type
 TList = array[1..max] of Integer;
 TLongList = array[1..max] of LongInt;
var
 adj, Index: TList;
 head: array[1..max + 1] of Integer;
 c, Parent, Count: ^TList;
 m: ^TLongList;
 n, Director, SelectedCount: Integer;
 i: Integer;

procedure Enter;
var
 f: Text;
 i, p: Integer;
begin
 New(m); New(c); New(Parent); New(Count);
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 FillChar(Count^, SizeOf(Count^), 0);
 for i := 1 to n do
  begin
   Read(f, Parent^[i], c^[i]);
   if Parent^[i] = 0 then Director := i
   else Inc(Count^[Parent^[i]]);
  end;
 head[1] := 1;
 for i := 2 to n + 1 do
  begin
   head[i] := head[i - 1] + Count^[i - 1];
  end;
 for i := 1 to n do
  if Parent^[i] <> 0 then
   begin
    p := Parent^[i];
    Dec(Count^[p]);
    adj[head[P] + Count^[p]] := i;
   end;
 Dispose(Count);
 Dispose(Parent);
 Close(f);
end;

procedure Destroy;
begin
 Dispose(m);
 Dispose(c);
end;

procedure Numbering;
var
 i, Last, iv, u, v: Integer;
begin
 Index[1] := Director; Last := 1;
 for i := 1 to n do {Breadth First Search}
  begin
   u := Index[i]; {Pop u}
   for iv := head[u] to head[u + 1] - 1 do
    begin
     v := adj[iv];
     Inc(Last); Index[Last] := v; {Push v}
    end;
  end;
end;

{Ham lay tong do vui tinh cac nhanh con}
function GetChildrenD(u: Integer): LongInt;
var
 S: LongInt;
 iv: Integer;
begin
 S := 0;
 for iv := head[u] to head[u + 1] - 1 do S := S + m^[adj[iv]];
 GetChildrenD := S;
end;

{Ham lay tong do vui tinh cua cac nhanh chau}
function GetGrandChildrenD(u: Integer): LongInt;
var
 S: LongInt;
 iu, iv: Integer;
begin
 S := 0;
 for iu := head[u] to head[u + 1] - 1 do {Duyet cac con adj[iu] cua u}
  for iv := head[adj[iu]] to head[adj[iu] + 1] - 1 do {Duyet con cua adj[iu]}
   S := S + m^[adj[iv]];
 GetGrandChildrenD := S;
end;

function GetMax(x, y: LongInt): LongInt;
begin
 if x > y then GetMax := x else GetMax := y;
end;

procedure Optimize;
var
 i, j, u, v, iv: Integer;
 ChildrenD, GChildrenD: LongInt;
begin
 for i := n downto 1 do
  begin
   u := Index[i];
   ChildrenD := GetChildrenD(u);
   GChildrenD := GetGrandChildrenD(u);
   if ChildrenD > c^[u] + GChildrenD then
    begin
     m^[u] := ChildrenD;
     c^[u] := -1;
    end
   else m^[u] := c^[u] + GChildrenD;
  end;
end;

procedure Trace;
var
 Last, First, iu, iv, p: Integer;
begin
 Index[1] := Director;
 First := 1; Last := 1; SelectedCount := 0;
 repeat
  p := Index[First]; Inc(First);
  if c^[p] > 0 then
   begin
    c^[p] := -2; Inc(SelectedCount);
    for iu := head[p] to head[p + 1] - 1 do
     for iv := head[adj[iu]] to head[adj[iu] + 1] - 1 do
      begin
       Inc(Last); Index[Last] := adj[iv];
      end;
   end
  else
   for iu := head[p] to head[p + 1] - 1 do
    begin
     Inc(Last); Index[Last] := adj[iu];
    end;
 until First > Last;
end;

procedure Result;
var
 f: Text;
 i: Integer;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, SelectedCount, ' ', m^[Director]);
 for i := 1 to n do
  if c^[i] = -2 then Writeln(f, i);
 Close(f);
end;

begin
 for i := 1 to 10 do
  begin
   InputFile := 'GUEST.IN' + S[i];
   OutputFile := 'GUEST.OU' + S[i];
   Enter;
   Numbering;
   Optimize;
   Trace;
   Result;
   Destroy;
  end;
end.
3
0 3
1 6
2 4
