{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 60384,0,655360}
program Mess;

uses Crt;

const
  inpfile= 'mess.inp';
  outfile= 'mess.out';
  maxN= 100;
  VC= 10000;

type
  ArrN= array[1.. maxN] of integer;
  Matrix= array[1.. maxN] of ArrN;

var
  n, s, t                               : integer;
  a                                     : Matrix;
  d, p                                  : ArrN;
  inp, out                              : text;
  stop                                  : boolean;

procedure ReadInp;
var i, j, m: integer;
begin
  Assign(inp, inpfile); Reset(inp);
    ReadLn(inp, n, m, s, t);
    FillChar(a, SizeOf(a), 0);
    while m> 0 do begin
      Dec(m);
      Read(inp, i, j);
      ReadLn(inp, a[i, j]);
      a[j, i]:= a[i, j];
    end;
  Close(inp);
end;

procedure FindPath;
var i, j: integer;
begin
  for i:= 1 to N do begin d[i]:= Vc;p[i]:= 0; end;
  d[s]:= 0;
  p[s]:= -1;
  repeat
    stop:= true;
    for i:= 1 to N do
      for j:= 1 to N do if a[i, j]<> 0 then
        if d[i]+ a[i, j]< d[j] then begin
          d[j]:= d[i]+ a[i, j];
          p[j]:= i;
          stop:= false;
        end;
  until stop;
  stop:= p[t]= 0;
end;

procedure IncFlow;
var i, j: integer;
begin
  j:= t;
  repeat
    i:= p[j];
    if a[i, j]< 0 then begin
      a[i, j]:= -a[i, j];
      a[j, i]:= a[i, j];
    end
    else begin
      a[i, j]:= 0;
      a[j, i]:= -a[j, i];
    end;
    j:= i;
  until j= s;
end;

procedure WriteOut;
var i, j, cp: integer;
begin
  Assign(out, outfile); Rewrite(out);
  cp:= 0;
  i:= s;
  Write(out, i: 4);
  repeat
    for j:= 1 to N do if a[j, i]< 0 then break;
    a[i, j]:= -a[j, i];
    a[j, i]:= a[i, j];
    Inc(Cp, a[i, j]);
    i:= j;
    Write(out, i: 4);
  until i= t;
  WriteLn(out);
  i:= s;
  Write(out, i: 4);
  repeat
    for j:= 1 to N do if a[j, i]< 0 then break;
    a[i, j]:= -a[j, i];
    a[j, i]:= a[i, j];
    Inc(Cp, a[i, j]);
    i:= j;
    Write(out, i: 4);
  until i= t;
  WriteLn(out);
  WriteLn(out, Cp);
  Close(out);
end;

begin
  ReadInp;
  FindPath;
  if stop then begin
    WriteLn('Khong du 2 duong');
    Exit;
  end
  else IncFlow;
  FindPath;
  if stop then begin
    WriteLn('Khong du 2 duong');
    Exit;
  end
  else IncFlow;
  WriteOut;
end.
mess.out
mess.inp
5 7 1 5
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3
----