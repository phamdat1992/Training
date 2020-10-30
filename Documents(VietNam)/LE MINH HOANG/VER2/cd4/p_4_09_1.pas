program Minimal_Spanning_Tree_by_Kruskal;
const
  InputFile  = 'MINTREE.INP';
  OutputFile = 'MINTREE.OUT';
  maxV = 100;
  maxE = (maxV - 1) * maxV div 2;
type
  TEdge = record				
    u, v, c: Integer;		
    Mark: Boolean;			
  end;
var
  e: array[1..maxE] of TEdge; 			
  Lab: array[1..maxV] of Integer;		
  n, m: Integer;
  Connected: Boolean;

procedure LoadGraph;		
var
  i: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, m);
  for i := 1 to m do
    with e[i] do
      ReadLn(f, u, v, c);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do Lab[i] := -1;			
  for i := 1 to m do e[i].Mark := False;
end;

function GetRoot(v: Integer): Integer;	
begin
  while Lab[v] > 0 do v := Lab[v];
  GetRoot := v;
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
      Lab[r1] := x;
      Lab[r2] := r1;
    end;
end;

procedure AdjustHeap(root, last: Integer);		
var
  Key: TEdge;
  child: Integer;
begin
  Key := e[root];
  while root * 2 <= Last do
    begin
      child := root * 2;
      if (child < Last) and (e[child + 1].c < e[child].c)
        then Inc(child);
      if Key.c <= e[child].c then Break;
      e[root] := e[child];
      root := child;
    end;
  e[root] := Key;
end;

procedure Kruskal;
var
  i, r1, r2, Count, a: Integer;
  tmp: TEdge;
begin
  Count := 0;
  Connected := False;
  for i := m div 2 downto 1 do AdjustHeap(i, m);
  for i := m - 1 downto 0 do
    begin
      tmp := e[1]; e[1] := e[i + 1]; e[i + 1] := tmp;
      AdjustHeap(1, i);
      r1 := GetRoot(e[i + 1].u); r2 := GetRoot(e[i + 1].v);
      if r1 <> r2 then						
        begin
          e[i + 1].Mark := True;		
          Inc(Count);							
          if Count = n - 1 then		
            begin
              Connected := True;
              Exit;
            end;
          Union(r1, r2);					
        end;
    end;
end;

procedure PrintResult;
var
  i, Count, W: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  if not Connected then
    WriteLn(f, 'Error: Graph is not connected')
  else
    begin
      WriteLn(f, 'Minimal spanning tree: ');
      Count := 0;
      W := 0;
      for i := 1 to m do								
        with e[i] do
          begin
            if Mark then								
              begin
                WriteLn(f, '(', u, ', ', v, ') = ', c);
                Inc(Count);
                W := W + c;
              end;
            if Count = n - 1 then Break;		
          end;
      WriteLn(f, 'Weight = ', W);
    end;
  Close(f);
end;

begin
  LoadGraph;
  Init;
  Kruskal;
  PrintResult;
end.
6 9
1 2 1
1 3 1
2 4 1
2 3 2
2 5 1
3 5 1
3 6 1
4 5 2
5 6 2