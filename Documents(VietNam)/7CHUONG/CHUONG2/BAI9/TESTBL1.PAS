{

}
uses crt;
const
	MAXN	= 500;
	MAXM	= 20000;
	MAXP	= 500;
	NumTest	= 8;
	Finp	= 'BL1.IN';
       	Fout	= 'BL1.OUT';
	Pkq:	Array[0..NumTest-1] of Integer=( 50,2,-1, 20, 240, 400,  80, 180);
	Diem:	Array[0..NumTest-1] of Real	=  (0.5,0, 1,0.5,0.5,0.5,0.5,0.5);
	DiemPA:	Array[0..NumTest-1] of Real	=  (0.5,1, 0,0.5,1.0,0.5,0.5,1);
	Epsilon:Array[0..NumTest-1] of Integer=( 0,1,0, 9, 0, 0,  0, 0);
type
	Arr = Array[1..MAXM] of Integer;
var
	TestNo	: Integer;
	Test	: real;
	N, M, K, P	: Integer;
	A	: Array[1..2] of ^Arr; {Cac doan pho}
	B	: Arr; {Lich xep}
	PC	: Array[1..MAXP] of Integer; {So doan sua trong cac ngay}

function Nhap:boolean;
var
	F	: Text;
	i	: Integer;
	Name: String;
	OldTA	: integer;
begin
	OldTA	:= textattr ;
	Name := Finp + chr(TestNo + Ord('0'));
	{$I-}
	assign(F, Name);
	reset(F);
	{$I+}
	if IOResult <> 0 then
	begin
		textcolor(RED);
		writeln('Khong co file ', Name);
		textattr := OldTA;
		nhap := False;
		exit;
	end;
	readln(F, N, M, K);
	For i:= 1 to M do
	begin
		readln(F, A[1]^[i], A[2]^[i]);
	end;
	close(F);
	{$I-}
	assign(F, Fout);
	reset(F);
	{$I+}
	if IOResult <> 0 then
	begin
		textcolor(CYAN);
		writeln('Khong co file BL1.OUT');
		textattr := OldTA;
		writeln(' Diem = 0');
		nhap := False;
		exit;
	end;
	readln(F, P);
	if P<> -1 then
		For i:= 1 to M do
			readln(F, B[i]);
	close(F);
{
	erase(F);
}
	Nhap := True;
end;

var
	Cha	: Array[1..MAXN] of Integer;
	Danso	: Array[1..MAXN] of Integer;
function OngTo(i: integer): integer;
begin
	while Cha[i] <> 0 do i := Cha[i];
	OngTo := i;
end;

function LienThong(ngay: integer): boolean;
var
	SoOT, i, Td, Tc	: integer;
begin
	fillchar(Cha, sizeof(Cha), 0);
	for i:=1 to N do Danso[i] := 1;
	SoOT	:= N;
	for i:=1 to M do
	begin
		if B[i] <> ngay then
		begin
			Tc := OngTo(A[1]^[i]); Td := OngTo(A[2]^[i]);
			if Tc <> Td then
			begin
				Dec(SoOT);
				if Danso[Tc] <= Danso[Td] then
				begin
					Cha[Tc] := Td; Inc(Danso[Td],Danso[Tc]);
				end
				else
				begin
					Cha[Td] := Tc; Inc(Danso[Tc],Danso[Td]);
				end
			end;
		end;
	end;

	LienThong	:= (SoOT = 1);
end;

function PhuongAnOk: boolean;
var
	i	: integer;
begin
	{Kiem tra xem co ngay nao sua qua K doan khong}
	fillchar(PC, sizeof(PC), 0);
	for i:= 1 to M do
		if (B[i] > P) or (B[i] < 1) then
		begin
			writeln('Lich khong hop le o doan duong thu ', i);
			PhuongAnOk	:= False;
			exit;
		end
		else
			inc(PC[B[i]]);
	for i:= 1 to P do
	begin
		if (PC[i] > K)  then
		begin
			writeln('Lich khong hop le: ');
			writeln(' Ngay thu ', i, ' sua qua ', k, ' doan');
			PhuongAnOk	:= False;
			exit;
		end;
	{Con phai kiem tra tinh lien thong cua mang sau moi ngay}
		if not LienThong(i) then
		begin
			writeln('Lich khong hop le: ');
			writeln(' Ngay thu ', i, ' khong bao dam tinh lien thong');
			PhuongAnOk	:= False;
			exit;
		end;
	end;
	writeln('Lich hop le.');
	PhuongAnOk	:= True;
end;
procedure KiemTra;
begin
	Test 	:= 0;
	if (P = -1) then
		if P = Pkq[TestNo] then
		begin
			writeln('Dung. Khong co cach sua chua');
			Test := Test + Diem[TestNo];
			exit;
		end
		else begin
			writeln('Sai do P = ', P, ' <> Phuong an toi uu ', Pkq[TestNo]);
			exit;
		end;
	if Pkq[TestNo] = -1 then
	begin
		writeln('Sai do test nay khong co phuong an su+?a chua.');
		exit;
	end;
	if P < Pkq[TestNo] then
	begin
		writeln('Sai do P = ', P, ' < Phuong an toi uu ', Pkq[TestNo]);
	end;
	if P > Pkq[TestNo]+Epsilon[TestNo] then
	begin
		writeln('Sai do P = ', P, ' qua lon.');
		exit;
	end
        else
	    if P >= Pkq[TestNo] then
		Test	:= Test+Diem[TestNo];
	if PhuongAnOk then
		Test	:= Test+DiemPA[TestNo]
        else
            if P <> Pkq[TestNo] then
		Test	:= 0;
end;
procedure Display;
var
	OldTA	: integer;
begin
	OldTA	:= textattr;
	writeln('N, M, K = ', N, ' ', M, ' ', K);
	writeln('Ket qua cua thi sinh              Ket qua cho doi');
	textcolor(CYAN);
	writeln(' P = ', P:3,'                           P = ', Pkq[TestNo]);
	textattr := OldTA;
	writeln;
end;
var
	OldTA	: integer;

begin
	new(A[1]);
	new(A[2]);
	clrscr;
	OldTA	:= textattr;
        writeln;
        writeln('########################################');
        writeln;
        textcolor(CYAN);
        writeln(' CHUONG TRINH CHAM BAI 1 KHOI A VOI2001');
        writeln('            TEN BAI: SUA DUONG');
        writeln;
	textattr := OldTA;
        writeln('########################################');
	write('Test so: ');
	repeat
		TestNo := ord(readkey) - 48;
	until TestNo in [0..9];
	writeln(TestNo);
	if Nhap then
	begin
		Display;
		KiemTra;
                writeln;
                writeln('########################################');
                writeln;
                textcolor(LIGHTRED);
                writeln(' Diem : ', Test:0:2);
	        textattr := OldTA;
                writeln;
                writeln('########################################');
	end;
	textcolor(blink+yellow);
	writeln('This program is written by GS TS NDN.');
	textcolor(15);
	dispose(A[1]);
	dispose(A[2]);
	readkey;
end.

