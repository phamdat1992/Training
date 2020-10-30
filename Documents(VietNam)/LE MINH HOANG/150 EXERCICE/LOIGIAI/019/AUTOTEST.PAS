{$M 4000 0 0}
uses crt, dos;
var
 ch: Char;
 f: File;
begin
 repeat
  Exec('C:\_Temp\RandTest.EXE', '');
  Exec('C:\_Temp\TH019.EXE','');
 until keypressed;
end.
