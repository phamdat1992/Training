program make_test_file; { for PART.PAS }
uses  crt;
const filename = 'PART.INP';
      mn = 100;
type  arr1lint = array [ 1..mn ] of longint;
var   f : text;
      fn: string[12];
      A1, B1, A2, B2 : arr1lint;
      n, i, j : integer;

procedure input;
begin
  clrscr;
  write('Ten File chua du lieu : ');
  readln(fn);
  if fn = '' then fn := filename;

  repeat
    clrscr;
    write('N = ');
    readln(n);
    if (n < 1) or ( n > mn)
    then begin
           writeln('Nhap lai !',#7,#7,#7);
           delay(300);
         end;
  until (n > 0) and (n <= mn);
end;

function  daxet : boolean;
begin
  for j := 1 to i-1 do
    if (A1[i] = A1[j]) and (A2[i] = A2[j])
       and (B1[i] = B1[j]) and (B2[i] = B2[j])
    then begin
           daxet := true;
           exit;
         end;
  daxet := false;
end;

procedure make_AB;
begin
  i := 0;
  repeat
    inc(i);
    A1[i] := random(1001);
    B1[i] := random(1001);
    A2[i] := random(1001);
    B2[i] := random(1001);
    if daxet then dec(i);
  until i = n;
end;

procedure writeF;
begin
  assign(f,fn);
    rewrite(f);
    writeln(f,n);
    for i := 1 to n do writeln(f,A1[i],' ',B1[i],' ',A2[i],' ',B2[i]);
  close(f);
end;

BEGIN
  input;
  randomize;
  make_AB;
  writeF;
END.