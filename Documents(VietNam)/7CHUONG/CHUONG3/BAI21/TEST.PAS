uses crt;
const
  maxn = 20;
  maxk = 10;
  maxkk = 100;
  da: array['1'..'6'] of integer = (3, 4, -1, 4, 5, 10);
type
  dong = array[1..maxkk] of byte;
  nghiem = array[1..maxn] of byte;
var
  k, kk, n: byte;
  nx, ny: integer;
  luat: array[0..3] of dong;
  phieu: array[1..maxn] of dong;
  f: text;
  fi, fo: string;
  x: nghiem;
  test: char;
  diem: integer;

  procedure DocData;
  var i, j: byte;
  begin
	clrscr;
	repeat
	  write('Test (1-6): '); test := readkey;
	  writeln(test);
	until test in ['1'..'6'];
	fi := 'BL4.IN'+test;
	assign(f, fi); reset(f);
	readln(f, n, k);
	kk := k*k;
	for i := 1 to n do
	begin
	  for j := 1 to kk do read(f, phieu[i][j]);
	  readln(f);
	end;
	close(f);
  end;

  procedure DocKq;
  var i: byte;
  begin
	fillchar(x, sizeof(x), 0);
	assign(f, fo); reset(f);
	readln(f, nx);
	if nx = -1 then
	begin
	  writeln('Khong xep duoc!');
	  if da[test] = -1 then
	  begin
		writeln('Dung.');
		diem := 2;
	  end
	  else
	  begin
		writeln('Sai.');
		diem := 0;
	  end;
	  textcolor(12);
	  writeln('Diem tong cong: ', diem);
	  textcolor(7);
	  readln;
	  halt;
	end;
	ny := 0;
	for i := 1 to n do
	begin
	  read(f, x[i]);
	  if not (x[i] in [0..3]) then
	  begin
		writeln('Error: sai gia tri!');
		diem := 0;
		textcolor(12);
		writeln('Diem tong cong: ', diem);
		textcolor(7);
		readln;
		halt;
	  end;
	  if x[i] > 0 then inc(ny);
	end;
	close(f);
  end;

  procedure Dao(var s, t: dong);
  var i: byte;
  begin
	for i := 1 to kk do t[i] := s[kk+1-i];
  end;

  procedure SinhLuat;
  {tuong ung voi gia tri k}
  var i, j, m, chiso, dau: byte;
  begin
	for i := 1 to kk do luat[0][i] := i;
	m := 0; dau := k;
	for i := 1 to k do
	begin
	  chiso := dau;
	  for j := 1 to k do
	  begin
		inc(m);
		luat[1][chiso] := m;
		inc(chiso, k);
	  end;
	  dec(dau);
	end;
	Dao(luat[0], luat[2]);
	Dao(luat[1], luat[3]);
  end;

  function Chapnhan: boolean;
  var
	i, j: byte;
		s: dong;
  begin
	fillchar(s, sizeof(s), 0);
	for i := 1 to n do
	  for j := 1 to kk do
		s[j] := s[j]+phieu[i][j];
		for j := 1 to kk do
		if s[j] = 0 then
		begin
		  ChapNhan := false; exit;
		end;
		ChapNhan := true;
  end;

  procedure BienDoi;
  var i, j, m: byte;
	  s: dong;
  begin
	for i := 1 to n do
	begin
	  m := x[i];
	  for j := 1 to kk do
	s[j] := phieu[i][luat[m][j]];
	  phieu[i] := s;
	end;
  end;

Begin
	fo := 'BL4.OUT';
	DocData;
	DocKq;
	SinhLuat;
	BienDoi;
	if Chapnhan then
	begin
	  writeln('Cach xep thoa man yeu cau');
	  writeln('So phieu can xoay: ', ny, ' (dap an ', da[test], ')');
	  if nx <> ny then
		writeln('Tinh sai so phieu can xoay (ghi ', nx, ', tinh ', ny);
	  if ny <= da[test] then
	  begin
		diem := 2;
		if ny = da[test] then
		  writeln('Ok: cach xep la toi uu')
		else
		  writeln('Extra: cach xep tot hon dap an!');
	  end else
	  begin
		diem := 1;
		writeln('Cach xep chua toi uu!');
	  end;
	end else
	begin
	  writeln('Error: cach xep khong thoa man!');
	  diem := 0;
	end;
	textcolor(12);
	writeln('Diem tong cong: ', diem);
	textcolor(7);
	readln;
end.

