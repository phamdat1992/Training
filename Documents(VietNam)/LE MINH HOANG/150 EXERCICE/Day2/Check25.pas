{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  NAME='LAND';
  LIST:array[0..10]of string=('Dung !!!'
                             ,'Chua toi uu !!!'
                             ,'Ket qua vo ly !!!'
                             ,'Khong co file output','','','','','','','');
  RESULT:array['0'..'9']of integer=(13,2,2,2,2,1,2,10,2,4);
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
    assign(fp,'KQ'+Num+'25.txt');
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
    readln(f,Value);
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
    writeln('Total = ',Total/10*40:0:2,'/40');
    writeln(fp,Total/10*40:0:2);
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