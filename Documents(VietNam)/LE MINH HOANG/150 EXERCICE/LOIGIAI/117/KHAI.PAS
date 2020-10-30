{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Traffic;
const
  InputFile  = 'traffic.inp';
  OutputFile = 'traffic.out';
  max = 200;
type
  TEdge = record
    u , v : Integer;
  end;
var
  C : array[1..max , 1..max] of Boolean;
  Free , Go , Back : array[1..max] of Boolean;
  List : array[1..max] of TEdge;

  n , root , m : Integer;

 procedure InputData;
 var
   f : Text;
   i , m , u ,v : Integer;
 begin
   Assign(f, InputFile);
   Reset(f);
   Readln(f, n , m);
   FillChar(C , SizeOf(C) , False);
   for i := 1 to m do
    begin
      Readln(f , u , v);
      C[u,v] := True;
    end;
   Close(f);
 end;

 procedure DfsGo(u : Integer);
 var
   v : Integer;
 begin
   Free[u] := False;
   C[root , u] := True;
   for v := 1 to n do
    if C[u,v] and Free[v] then DfsGo(v);
 end;

 procedure DfsBack(u : Integer);
 var
   v : Integer;
 begin
   Free[u] := False;
   for v := 1 to n do
    if C[v,u] and Free[v] then DfsBack(v);
 end;

 procedure Prepare_Go;
 var
   i : Integer;
 begin
   FillChar(Free , SizeOf(Free) , True);
   FillChar(Go , SizeOf(Go) , False);
   for i := 1 to n do
    if Free[i] then
     begin
       Go[i] := True;
       root := i;
       DfsGo(i);
     end;
   FillChar(Free , SizeOf(Free) , True);
   for i := n downto 1 do if Go[i] then
    if Free[i] then
     begin
       root := i;
       DfsGo(i);
     end
    else Go[i] := False;
 end;

 procedure Prepare_Back;
 var
   i : Integer;
 begin
   FillChar(Free , SizeOf(Free) , True);
   FillChar(Back , SizeOf(Back) , False);
   for i := 1 to n do
    if Free[i] then
     begin
       Back[i] := True;
       DfsBack(i);
     end;

   FillChar(Free , SizeOf(Free) , True);

   for i := n downto 1 do if Back[i] then
    if Free[i] then DfsBack(i)
    else Back[i] := False;
 end;

 procedure Prepare;
 var
   i,j : Integer;
   found : Boolean;
 begin
   Prepare_Go;
   Prepare_Back;
   for i := 1 to n do
    if Go[i] then
     begin
       FillChar(Free , SizeOf(Free) , True);
       root := i;
       DfsGo(i);
     end;
   m := 0;
   for i := 1 to n do
    if Go[i] then
     begin
       found := False;
       for j := 1 to n do
        if C[i,j] and Back[j] then found := True;
       if not found then
        Writeln('wrong!');
     end;
   for i := 1 to n do
    if Back[i] then
     begin
       found := False;
       for j := 1 to n do
        if C[j,i] and Go[j] then found := True;
       if not found then
        Writeln('wrong!');
     end;
 end;

 procedure Add(i , j : Integer);
 begin
   if i = j then Exit;
   Inc(m);
   List[m].u := i;
   List[m].v := j;
 end;

 procedure Start(var u , v : Integer);
 var
   i, j : Integer;
 begin
   for i := 1 to n do
    if Go[i] then
     for j := 1 to n do
      if C[i,j] and Back[j] then
       begin
         u := i;  v := j;
         Exit;
       end;
 end;

 function Found(i : Integer) : Integer;
 var
   j : Integer;
 begin
   for j := 1 to n do
    if Back[j] and C[i,j] then
     begin
       Found := j;
       Exit;
     end;
   Found := 0;
 end;

 procedure Process;
 var
   s , f : Integer;
   flag : Boolean;

  procedure Step1;
  var
    i , j , r : Integer;
  begin
    flag := False;
    for i := 1 to n do if Go[i] then
     begin
       j := Found(i);
       if j = 0 then Continue;
       Go[i] := False; Back[j] := False;
       Add(f , i);
       flag := True;
       for r := 1 to n do
        begin
          if C[i,r] then C[s,r] := True;
          if C[r,f] then C[r,j] := True;
        end;
       f := j;
     end;
  end;

  procedure Step2;
  var
    i , j , r : Integer;
  begin
    flag := False;
    for i := 1 to n do
     if Go[i] and C[i,f] then
      begin
        j := Found(s);
        if j = 0 then Continue;
        for r := 1 to n do
         begin
           if C[s,r] then C[i,r] := True;
           if C[r,f] then C[r,j] := True;
         end;
        Add(f , s);
        s := i;  f := j;
        Go[i] := False; Back[j] := False;
        flag := True;
      end;
  end;

  procedure Step3;
  var
    i : Integer;
  begin
    for i := 1 to n do
     begin
       if Go[i] then Add(f,i);
       if Back[i] then Add(i,s);
     end;
    Add(f,s);
  end;

 begin
   Prepare;
   Start(s , f);
   Go[s] := False;
   Back[f] := False;
   repeat
     Step1;
   until not flag;
   repeat
     Step2;
   until not flag;
   Step3;
 end;

 procedure OutputResult;
 var
   f : Text;
   i : Integer;
 begin
   Assign(f , OutputFile);
   Rewrite(f);
   Writeln(f , m);
   Writeln(m);
   for i := 1 to m do
    with List[i] do Writeln(f, u , ' ' , v);
   Close(f);
 end;

begin
  InputData;
  Process;
  OutputResult;
end.