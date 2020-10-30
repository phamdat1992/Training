{test bai Cap so cong}
uses crt;
const
  da: array['1'..'5'] of integer =
	  (25, 41, -1, 271, 1000);
var
	N, K, D, Dt	: Integer;
	Fi,Fo	: Text;
	i, j, id, id1	: Integer;
	x, x1	: Integer;
	Dung : boolean;
	finp, fout: string;
	test: char;
	diem, diem1, diem2: integer;
begin
	repeat
	  write('Test (1-5): '); test := readkey;
	  writeln(test);
	until test in ['1'..'5'];
	diem1 := 0; diem2 := 0;
	finp := 'BL1.IN'+test;
	Dt := maxint;
	{$I-}
	assign(Fi, Finp);
	reset(Fi);
	{$I+}
	if IOResult <> 0 then
	begin
		writeln('Khong co file ', Finp);
		exit;
	end;
	readln(Fi, N);
	fout := 'BL1.OUT';
	{$I-}
	assign(Fo, Fout);
	reset(Fo);
	{$I+}
	if IOResult <> 0 then
	begin
		writeln('Khong co file ', Fout);
		exit;
	end;
	read(Fo, K);
	if K = -1 then
	begin
		 writeln('Khong co cap so cong nao.');
		 close(Fi);
		 close(Fo);
		 if da[test] = -1 then
		 begin
		   writeln('Dung.');
		   diem := 1;
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
		 exit;
	end;
	readln(Fo, D);
	writeln('Do dai cap so cong: ', K, ', (dap an: ', da[test], ')');
	writeln('Cong sai: ', D);
	if k = da[test] then diem1 := 1 else diem1 := 0;
	{kiem tra tinh dung dan}
	Dung := True;
	readln(Fo, Id1);
	for j:=1 to Id1 do Readln(Fi, x1);
	for i:= 2 to K do
	begin
		 Readln(Fo,Id);
		 if Id <= Id1 then
		 begin
			writeln('Sai do chi so khong tang: ', Id1, ' >= ', Id);
			Dung := False;
			break;
		 end;
		 for j:=1 to Id-Id1 do Readln(Fi, x);
		 if Dt = maxint then Dt := x-x1;
		 if (x - x1) <> Dt then
		 begin
			writeln('Khong phai cap so cong tai phan tu ', Id1, ' va ', Id);
			Dung := False;
			break;
		 end;
		 Id1 := Id; x1 := x;
	end;

	if Dung then
	begin
	  if k >= da[test] then diem2 := 1;
	  writeln('Ket qua dung.');
	  if D <> Dt then writeln('Cong sai ghi khong dung!');
	  if k > da[test] then writeln('Extra! ket qua tot hon dap an!');
	  if k = da[test] then writeln('Ok! ket qua la toi uu');
	  if k < da[test] then  {gan dung, chi voi cac test 4, 5}
	  begin
		writeln('Chua toi uu!');
		case test of
		  '1'..'3': diem2 := 0;
			  '4' : if k >= 250 then diem2 := 1;
			  '5' : if k >= 900 then diem2 := 1;
		end;
	  end;
	end;
	diem := diem1+diem2;
	textcolor(12);
	writeln('Diem tong cong: ', diem);
	textcolor(7);
	close(Fi);
	close(Fo);
	readln;
end.

