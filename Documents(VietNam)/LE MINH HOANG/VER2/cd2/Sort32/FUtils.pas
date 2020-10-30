unit FUtils;

interface
uses
    Windows, Classes, SysUtils;

procedure WriteString(Stream: TStream; S: String);
procedure WriteWString(Stream: TStream; S: string);
function ReadString(Stream: TStream): String;
function ReadWString(Stream: TStream): string;
procedure WriteInteger(Stream: TStream; Value: Integer);
function ReadInteger(Stream: TStream): Integer;
procedure MergeStream(Dest, Source: TStream);
procedure SplitStream(Dest, Source: TStream);

implementation

procedure WriteString(Stream: TStream; S: String);
var
  n, i:integer;
begin
  n := Length(S);
  Stream.Write(n, sizeof(n));
  for i := 1 to n do
    Stream.Write(S[i], Sizeof(S[i]));
end;

procedure WriteWString(Stream: TStream; S: string);
var
  n, i:integer;
begin
  n := Length(S);
  Stream.Write(n, sizeof(n));
  for i := 1 to n do
    Stream.Write(S[i], Sizeof(S[i]));
end;

function ReadString(Stream: TStream): String;
var
  n, i: Integer;
begin
  Stream.Read(n, sizeof(n));
  SetLength(Result, n);
  for i := 1 to n do
    Stream.Read(Result[i], SizeOf(Result[i]));
end;

function ReadWString(Stream: TStream): string;
var
  n, i: Integer;
begin
  Stream.Read(n, sizeof(n));
  SetLength(Result, n);
  for i := 1 to n do
    Stream.Read(Result[i], SizeOf(Result[i]));
end;

procedure WriteInteger(Stream: TStream; Value: Integer);
begin
  Stream.Write(Value, SizeOf(Integer));
end;

function ReadInteger(Stream: TStream): Integer;
begin
  Stream.Read(Result, SizeOf(Integer));
end;

procedure MergeStream(Dest, Source: TStream);
var
  n: Cardinal;
begin
  n := Source.Size;
  Dest.Seek(0, soFromEnd);
  Dest.Write(n, SizeOf(n));
  Dest.CopyFrom(Source, 0);
end;

procedure SplitStream(Dest, Source: TStream);
var
  n: Cardinal;
begin
  Source.Read(n, SizeOf(n));
  Dest.Size := 0;
  Dest.CopyFrom(Source, n);
  Dest.Seek(0, soFromBeginning);
end;

end.





