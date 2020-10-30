uses crt;
const
    Fin: string = 'Square93.IN';
    Fou: string = 'Square93.OUT';
var
    sq, sq1: array [1..9, 1..9] of char;
    c, chon: char;
    f: text;
    diem: integer;
    cx: array['1'..'9'] of boolean;

procedure nhapdl;
var i, j: integer;
begin
    assign(f,fin); reset(f);
    for i:=1 to 9 do
    begin
       for j:=1 to 9 do read(f,sq[i,j]);
       readln(f);
    end;
    close(f);
    gotoxy(1,6);
    writeln('Du lieu: ');
    for i:=1 to 9 do
    begin
       for j:=1 to 9 do write(sq[i,j]);
       writeln;
    end;
end;

function Verify(p,q: integer): boolean;
var i,j,k: integer;
    c1: char;
begin
    fillchar(cx,sizeof(cx), false);
    Verify:=false;
    for i:=p to p+2 do
      for j:=q to q+2 do
      begin
          c1:=sq1[i,j];
          if not cx[c1] then cx[c1]:=true
          else
          begin
             writeln('?????????????????????????????????');
             writeln('    ERROR: ');
             writeln('      Hinh vuong dinh tren trai tai (',p,', ',q,') ');
             writeln('      chua hai so: ',c1);
             writeln('?????????????????????????????????');
             exit;
          end;
      end;
   Verify:=true;
end;

procedure Cham;
var i, j, p, q: integer;
    dd: string[10];
    c1: char;
begin
    diem:=0;
    assign(f,fou); reset(f);
    if (chon='r') or (chon='s') then
    begin
        readln(f,dd);
        if dd<>'IMPOSSIBLE' then
        begin
            writeln('?????????????????????????????????');
            writeln('    ERROR: Khong dung dap so!');
            writeln('?????????????????????????????????');
        end
        else diem:=1;
        exit;
    end;
    read(f,dd);
    if not (dd[1] in ['1'..'9']) then
    begin
        writeln('?????????????????????????????????');
        writeln('    ERROR: Khong dung dap so!');
        writeln('?????????????????????????????????');
        exit;
    end;
    reset(f);
    for i:=1 to 9 do
    begin
       for j:=1 to 9 do read(f,sq1[i,j]);
       readln(f);
    end;

    gotoxy(20,6);
    writeln('Ket qua: ');
    for i:=1 to 9 do
    begin
       gotoxy(20,6+i);
       for j:=1 to 9 do write(sq1[i,j]);
       writeln;
    end;
    writeln('======================================');
    for i:=1 to 9 do
    begin
       if not (sq1[i,j] in ['1'..'9']) then
       begin
          writeln('?????????????????????????????????');
          writeln('    ERROR:');
          writeln('            Vi tri (',i,', ',j,') ');
          writeln('              da dien: ',sq1[i,j]);
          writeln('?????????????????????????????????');
          exit;
       end;
    end;
    for i:=1 to 9 do
        for j:=1 to 9 do
            if (sq[i,j]<>'.') and (sq1[i,j]<>sq[i,j]) then
            begin
                writeln('?????????????????????????????????');
                writeln('    ERROR: ');
                writeln('            Vi tri (',i,', ',j,') ');
                writeln('            Can giu   : ',sq[i,j]);
                writeln('            Da dien so: ',sq1[i,j]);
                writeln('?????????????????????????????????');
                exit;
            end;

    for i:=1 to 9 do
    begin
        fillchar(cx,sizeof(cx), false);
        for j:=1 to 9 do
        begin
           c1:= sq1[i,j];
           if not cx[c1] then cx[c1]:=true
           else
           begin
              writeln('?????????????????????????????????');
              writeln('    ERROR: ');
              writeln('      Dong ',i,' chua hai so: ',c1);
              writeln('?????????????????????????????????');
              exit;
           end;
        end;
    end;
    for j:=1 to 9 do
    begin
        fillchar(cx,sizeof(cx), false);
        for i:=1 to 9 do
        begin
           c1:= sq1[i,j];
           if not cx[c1] then cx[c1]:=true
           else
           begin
              writeln('?????????????????????????????????');
              writeln('    ERROR: ');
              writeln('      Cot ',j,' chua hai so: ',c1);
              writeln('?????????????????????????????????');
              exit;
           end;
        end;
    end;
    p:=1;
    for i:=1 to 3 do
    begin
        q:=1;
        for j:=1 to 3 do
        begin
            if not Verify(p,q) then exit;
            q:=q+3;
        end;
        p:=p+3;
    end;
    diem:=1;
    close(f);
end;

BEGIN
    clrscr;
    writeln('                   CHUONG TRINH CHAM BAI FUJIWARA');
    writeln('               ======================================');
    write  ('                 Cho ten file du lieu: SQUARE93.IN');
    chon:=readkey; writeln(chon);
    fin:='SQUARE93.IN'+chon;
    Nhapdl;
    Cham;
    writeln; writeln; writeln;
    writeln('               $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    writeln('                             Diem: ', diem);
    writeln('               $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
    readln;
END.