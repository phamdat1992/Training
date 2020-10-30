program   Test_077;
uses      Crt;
const
     InputFileName = 'BRACKETS.IN';
     OutputFileName = 'BRACKETS.OUT';
     Max = 10000;
var
     ifl, ofl, f : Text;
     i, d, n : Integer;
     p : byte;
     ch : Char;
     b, HS : array [1..2 * Max] of Char;
     Ten, s : String;

 procedure  RewritePoint;
 begin
     Assign(f, 'POINT.PNT'); Rewrite(f);
     WriteLn(f, 0);
     Close(f);
 end;

 procedure  WriteP;
 begin
     WriteLn('              ****************************************************');
     WriteLn('              *                                                  *');
     WriteLn('              *       CHAM BAI BRACKETS : KHOI PHUC NGOAC        *');
     WriteLn('              *                                                  *');
     WriteLn('              ****************************************************');
 end;

 procedure  AskTest;
 begin
     WriteLn; WriteLn; WriteLn;
     Write('            Ten file du lieu : Brackets.in');
     ReadLn(ch);
     if ch = '1' then
         ReWritePoint;
 end;

 procedure  ReadResult;
 begin
     Assign(ofl, OutputFileName); Reset(ofl);
     for i := 1 to 2 * n do Read(ofl, HS[i]);
     Close(ofl);
 end;

 procedure  Solve;
 begin
     {$I-}
     Assign(ifl, InputFileName + ch); Reset(ifl);
     if IoResult <> 0 then
       begin
         Write('            Sai ten File Input...');
         ReadLn;
         Halt;
       end;
     ReadLn(ifl, n);
     Fillchar(b, SizeOf(b), '?');
     for i :=  1 to 2 * n do
       if b[i] = '?' then
         begin
           read(ifl, d);
           b[i] := '('; b[i + d + 1] := ')';
         end;
     Close(ifl);
 end;

 procedure  AddPoint;
 begin
     Assign(f, 'POINT.PNT'); Reset(f);
     ReadLn(f, p);
     Close(f);
     p := p + 1;
     Assign(f, 'POINT.PNT'); Rewrite(f);
     WriteLn(f, p);
     Close(f);
 end;

 function  Ok : BooLean;
 begin
     for i := 1 to 2 * n do
       if HS[i] <> B[i] then
         begin
           Ok := False; Exit;
         end;
     Ok := true;
 end;

 procedure  Correct;
 begin
     WriteLn;
     WriteLn('*=====================================================*');
     WriteLn('*                                                     *');
     WriteLn('*        Ket qua dung !!! Diem Test Brackets.in', ch, ' : 01 ', '*');
     WriteLn('*                                                     *');
     WriteLn('*=====================================================*');
     AddPoint;
 end;

 procedure  Wrong;
 begin
     WriteLn;
     WriteLn('*====================================================*');
     WriteLn('*                                                    *');
     WriteLn('*        Ket qua sai !!! Diem Test Brackest.in', ch, ' : 00 ', '*');
     WriteLn('*                                                    *');
     WriteLn('*====================================================*');
 end;

 function   Perfect : Integer;
 begin
     Assign(f, 'PR.P'); Reset(f);
     ReadLn(f, d); Perfect := d;
     Close(f);
 end;

 procedure  CopyFiletoFile(N1, N2 : String);
 begin
     Assign(ofl, N2); Rewrite(ofl);
     Assign(ifl, N1); Reset(ifl);
     ReadLn(ifl, d); WriteLn(ofl, d + 1);
     for i := 1 to d do
       begin
         ReadLn(ifl, s); WriteLn(ofl, s);
       end;
     WriteLn(ofl, Ten);
     Close(ifl); Close(ofl);
 end;

 procedure  WriteNameAndAddName;
 begin
     CopyFiletoFile('PR.P', 'FILE.CP');
     Assign(f, 'FILE.CP'); Reset(f);
     Readln(f, d);
     for i := 1 to d do
       begin
         ReadLn(f, S); WriteLn(i : 10, '. ', S);
       end;
     Close(f);
     Assign(ifl, 'FILE.CP'); Reset(ifl);
     Assign(ofl, 'PR.P'); Rewrite(ofl);
     ReadLn(ifl, d); WriteLn(ofl, d);
     for i := 1 to d do
       begin
         ReadLn(ifl, s); WriteLn(ofl, s);
       end;
     Close(ifl); Close(ofl);
 end;

 procedure  Check;
 begin
     WriteLn; WriteLn; WriteLn;
     if Ok then Correct
     else  Wrong;
     WriteLn;
     WriteLn('           Tong diem hien tai cua ban : ', p, '/10'); ReadLn;
     If p = 10 then
       begin
         WriteLn; WriteLn; WriteLn;
         Clrscr;
         Write(' Ten ban la gi : '); ReadLn(Ten);
         if Perfect = 0 then WriteLn('Ban la nguoi dau tien giai duoc bai nay !!!')
         else
           begin
              WriteLn(' Ban la nguoi thu ', Perfect + 1, ' hoan thanh bai nay !!!');
              WriteLn; WriteLn; WriteLn; WriteLn;
              Clrscr;
              WriteLn('       Danh sach nhung nguoi dat 10/10 bai Brackets " Khoi phuc ngoac " : ');
              WriteNameAndAddName;
           end;
       end;
 end;

begin
     Clrscr;
     WriteP;
     AskTest;
     Solve;
     ReadResult;
     Check;
     ReadLn;
end.