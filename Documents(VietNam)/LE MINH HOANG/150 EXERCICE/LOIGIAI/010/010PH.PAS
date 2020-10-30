program   Bo_tri_phong_hop;
type
    TArr = array [0..32000] of Word;
const
    InputFile  = 'Activity.in0';
    OutputFile = 'Activity.out';
var
    MaxLeft, Lab : ^TArr;
    n, MaxFLab : integer;

procedure   enter;
var
    f : Text;
    i, a, b : integer;
begin
    Assign(f, InputFile); Reset(f);
    readln(f, n);
    New(Lab); New(MaxLeft);
    Fillchar(Lab^, Sizeof(Lab^), 0);
    Fillchar(MaxLeft^, Sizeof(MaxLeft^), 0);
    for i := 1 to n do
      begin
        readln(f, a, b);
        if  a > MaxLeft^[b] then
          begin
            Lab^[b] := i;
            MaxLeft^[b] := a;
            if MaxFLab < b then MaxFLab := b;
          end;
      end;
    Close(f);
end;

procedure   Solve;
var
    f : Text;
    endt, Count, v : integer;
begin
    Count := 0; endt := 0;
    for v := 0 to MaxFLab do
      if (MaxLeft^[v] >= endt) and (Lab^[v] <> 0) then
        begin
          Inc(Count);
          endt := v;
        end;
    Assign(f, OutputFile); Rewrite(f);
    writeln(f, Count);
    endt := 0;
    for v := 0 to MaxFLab do
      if (MaxLeft^[v] >= endt) and (Lab^[v] <> 0) then
        begin
          writeln(f, Lab^[v]);
          endt := v;
        end;
    Close(f);
end;

BEGIN
    Enter;
    Solve;
END.