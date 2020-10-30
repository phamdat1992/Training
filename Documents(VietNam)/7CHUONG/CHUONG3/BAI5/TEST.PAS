uses crt;
const
    fout = 'queen.out';
var
    f: text;
    chon: char;
    st: string;
    d, loi: integer;
    Ok : boolean;
    diem: real;

BEGIN
    clrscr;
    writeln('           ======================================');
    writeln('               CHUONG TRINH CHAM BAI QUEEN');
    writeln('           ======================================');
    write  ('                Cho ten file test QUEEN.IN'); chon:=readkey;
    writeln(chon);
    assign(f,fout); reset(f);
    readln(f,st);
    close(f);
    val(st,d,loi);
    if loi<> 0 then
    begin
        writeln('Loi file ket qua: Invalid Numeric Format : ',st);
        exit;
    end;
    Ok:=true;
    case chon of
         '1': if d<>0 then Ok := false;
         '2': if d<>2 then Ok := false;
         '3': if d<>2 then Ok := false;
         '4': if d<>12 then Ok := false;
         '5': if d<>9 then Ok := false;
         '6': if d<>8 then Ok := false;
         '7': if d<>9 then Ok := false;
         '8': if d<>11 then Ok := false;
         '9': if d<>21 then Ok := false;
         '0': if d<>24 then Ok := false;
         'a': if d<>49 then Ok := false;
         'b': if d<>70 then Ok := false;
         'c': if d<>111 then Ok := false;
         'd': if d<>86 then Ok := false;
         'e': if d<>283 then Ok := false;
    end;
    if not Ok then
    begin
        writeln;
        writeln('         ????????????????????????????????????????????????????');
        writeln('                          ERROR: Khong dung dap so');
        writeln('         ????????????????????????????????????????????????????');
        diem:=0;
    end
    else
    begin
        writeln;
        writeln('         $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
        writeln('                    C O R R E C T ! C O R R E C T !');
        writeln('         $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
        if chon in ['a'..'e'] then diem:=1
        else diem:=0.5;
    end;
    writeln; writeln;
    writeln('                ==============================');
    writeln('                           Diem: ', diem:4:1);
    writeln('                ==============================');
    readln;
END.