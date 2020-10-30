(*    Chuong trinh cham bai HIGH WAYS    *)
{$r+$q+}
uses crt;
const
    fin: string = 'HIGHWAY.IN';
    fou: string = 'HIGHWAY.OUT';
    dapso : array['0'..'9'] of real =(
                                       356360.088550,
                                       2,
                                       99,
                                       8432,
                                       7538,
                                       9355.627638,
                                       922.414766,
                                       0,
                                       19914.048508,
                                       18610.122350);
var
   x, y: array[1..1000] of real;
   dau, cuoi: array[1..1000] of integer;
   daux, cuoix: array[1..1000] of integer;
   f: text;
   n, m, k, diem: integer;
   chon: char;

procedure Nhapdl;
var i: integer;
begin
    assign(f, fin); reset(f);
    readln(f, n);
    for i:=1 to n do readln(f,x[i], y[i]);
    readln(f, m);
    for i:=1 to m do readln(f,dau[i], cuoi[i]);
    close(f);
end;

procedure Evaluation;
var i: integer;
   sum, dis: real;
begin
    diem:=0;
    Nhapdl;
    assign(f, fou);
    reset(f);
    readln(f, k); 
    for i:=1 to k do readln(f,daux[i],cuoix[i]);
    close(f);
    for i:=1 to k do
    begin
        if (daux[i]<=0) or (daux[i]>n) then
        begin
            writeln('??????????????????????????????????????????????');
            writeln('        ERROR:  Khong co nut: ',daux[i]);
            writeln('??????????????????????????????????????????????');
            exit;
        end;
        if (cuoix[i]<=0) or (cuoix[i]>n) then
        begin
            writeln('??????????????????????????????????????????????');
            writeln('        ERROR:  Khong co nut: ',cuoix[i]);
            writeln('??????????????????????????????????????????????');
            exit;
        end;
    end;
    sum:=0;
    for i:=1 to k do
    begin
        dis:= sqrt( sqr(x[daux[i]] - x[cuoix[i]])+
                    sqr(y[daux[i]] - y[cuoix[i]]));
        sum:=sum+dis;
    end;
    if abs(sum-dapso[chon])>0.5 then
    begin
        writeln('??????????????????????????????????????????????');
        writeln('    ERROR: Khong toi uu!');
        writeln('           Tong do dai x/d bo sung: ',sum:12:6);
        writeln('           Dap so                 : ', dapso[chon]: 12:6);
        writeln('??????????????????????????????????????????????');
        exit;
    end;
    diem:=1;
end;


BEGIN
   clrscr;
   writeln('                 ****************************************');
   writeln('                      CHUONG TRINH CHAM BAI: HIGHWAYS');
   writeln('                 ****************************************');
   write('                        Ten file du lieu: HIGHWAY.IN');
   chon:=readkey; writeln(chon); writeln;
   fin:='HIGHWAY.IN'+chon;
   Evaluation;
   writeln; writeln;
   writeln('                 ****************************************');
   writeln('                                 Diem: ',diem);
   writeln('                 ****************************************');
   readln;
END.

