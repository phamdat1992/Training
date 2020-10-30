PROGRAM LongestPrefix;
CONST
  mn = 100;
  ml = 20;
  max = 500000;


VAR
  N : Integer;
  TP : array [1..mn] of String;
  soTP : array [1..mn] of Integer;
  maxlen : Integer;
  f2 : Text;


FUNCTION Run : Longint;
  Const
    mb = 4096;
  Var
    i, j : Integer;
    Buf : array [0..mb] of Char;
    Toi : array [0..mb] of Boolean;
    soBuf : Integer;
    ok : Boolean;
    start : Longint;
    endpos : Integer;

  Function DocDayBuf : Boolean;
    Begin
      while (not SeekEof(f2)) and (soBuf <= mb) do
      begin
        ReadLn( f2, Buf[soBuf] );
        Toi[soBuf] := False;
        Inc(soBuf);
      end;
      DocDayBuf := SeekEof(f2);
    End;

  Function Compare( atpos : Integer; iTP : Integer ) : Integer;
    Var
      i : Integer;
    Begin
      if atpos+soTP[iTP] >= soBuf then
      begin
        Compare := 2;
        for i := 1 to soBuf-1-atpos do
          if Buf[atpos+i] <> TP[iTP,i] then
            begin Compare := 0; Break end;
      end else begin
        Compare := 1;
        for i := 1 to soTP[iTP] do
          if Buf[atpos+i] <> TP[iTP,i] then
            begin Compare := 0; Break end;
      end;
    End;

  Begin
    ok := False;
    start := 0; endpos := 0;
    soBuf := 1; Toi[0] := True;
    repeat
      if DocDayBuf then ok := True;

      for i := 0 to soBuf-1 do if Toi[i] then
      begin
        Toi[i] := False;
        for j := 1 to N do case Compare( i, j ) of
          1: begin
            Toi[i+soTP[j]] := True;
            if i+soTP[j] > endpos then endpos := i+soTP[j];
          end;
          2: Toi[i] := True;
        end;
      end;

      j := 0;
      for i := maxlen downto 1 do if Toi[soBuf-i] then begin j := i; Break end;
      if j = 0 then ok := True;

      if not ok then
      begin
        i := soBuf-j;
        Move( Buf[i], Buf, j );
        Move( Toi[i], Toi, j );
        Inc( start, i );
        Dec( endpos, i );
        Dec( soBuf, i );
      end;
    until ok;
    Run := start+endpos;
  End;


VAR
  f : Text;
  i : Integer;

BEGIN
  Assign( f, 'W96_5.INP' );
  Reset(f);
  ReadLn( f, n );
  maxlen := 0;
  for i := 1 to n do
  begin
    ReadLn( f, soTP[i] );
    if soTP[i] > maxlen then maxlen := soTP[i];
    ReadLn( f, TP[i] );
  end;
  Close(f);

  Assign( f2, 'W96_5.DAT' );
  Reset(f2);
  Assign( f, 'W96_5.OUT' );
  Rewrite(f);

  WriteLn( f, Run );

  Close(f);
  Close(f2);
END.