{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  NAME='ONBANGAU';
  LIST:array[0..10]of string=('Dung !!!'
                             ,'Ket qua vo ly !!!'
                             ,'Chua toi uu !!!'
                             ,'Khong co file output','','','','','','','');
  RESULT:array['0'..'9']of integer=(11,2,13,9,31,17,26,29,-1,86);
var
  Test:char;
  Num,FILEINP,FILEOUT:string;
  fp:text;
  Total:integer;
  Point,Error:array['0'..'9']of integer;
 procedure Prepare;
  begin
    clrscr;
    write('Nhap so bao danh : ');
    readln(Num);
    writeln;
    if length(Num)=1 then Num:='0'+Num;
    assign(fp,'KQ'+Num+'26.txt');
    rewrite(fp);
    Total:=0;
  end;
 procedure Enter;
  begin
  end;
 procedure Check;
  var
    f:text;
    Value:integer;
    s:string;
  begin
    Point[Test]:=1;
    Error[Test]:=0;
    assign(f,FILEOUT);
    {$I-}
    reset(f);
    if IOResult<>0 then
     begin
       Point[Test]:=0;
       Error[Test]:=3;
       exit;
     end;
    {$I+}
    readln(f,s);
    while s[1]=' ' do delete(s,1,1);
    while s[length(s)]=' ' do dec(s[0]);
    if s='CRY' then Value:=-1
    else
     begin
       reset(f);
       readln(f,Value);
     end;
    if Value<RESULT[Test] then
     begin
       Point[Test]:=0;
       Error[Test]:=1;
       exit;
     end;
    if Value>RESULT[Test] then
     begin
       Point[Test]:=0;
       Error[Test]:=2;
     end;
    close(f);
  end;
 procedure PrintResult;
  begin
    write('Calling test ',Test,' : ');
    writeln(List[Error[Test]],' --> ',Point[Test],' diem');
    writeln;
    inc(Total,Point[Test]);
  end;
 procedure Done;
  begin
    writeln('Total = ',Total/10*20:0:2,'/20');
    writeln(fp,Total/10*20:0:2);
    writeln(fp);
    for Test:='0' to '9' do
     begin
       write(fp,'Calling test ',Test,' : ');
       writeln(fp,List[Error[Test]],' --> ',Point[Test],' diem');
       writeln(fp);
     end;
    close(fp);
    readln;
  end;
begin
  Prepare;
  for Test:='0' to '9' do
   begin
     FILEINP:=NAME+'.IN'+Test;
     FILEOUT:=NAME+'.OU'+Test;
     Enter;
     Check;
     PrintResult;
   end;
  Done;
end.