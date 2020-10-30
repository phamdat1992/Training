uses crt;
const
    fout = 'RTICKET.OUT';
var
    f: text;
    chon: char;
    st: string;
    diem, loi: integer;
    d: longint;
    Ok : boolean;

BEGIN
    clrscr;
    writeln('           ======================================');
    writeln('               CHUONG TRINH CHAM BAI RTICKET');
    writeln('           ========================================');
    write  ('                Cho ten file test RTICKET.IN'); chon:=readkey;
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
         '1': if d<>70 then Ok := false;
         '2': if d<>1 then Ok := false;
         '3': if d<>1000000000 then Ok := false;
         '4': if d<> 42 then Ok := false;
         '5': if d<>138 then Ok := false;
         '6': if d<>172 then Ok := false;
         '7': if d<>1000000000 then Ok := false;
         '8': if d<>657200025 then Ok := false;
         '9': if d<>500000016 then Ok := false;
         '0': if d<>950001480 then Ok := false;
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
        diem:=1;
    end;
    writeln; writeln;
    writeln('                ==============================');
    writeln('                           Diem: ', diem);
    writeln('                ==============================');
    readln;
ENd.