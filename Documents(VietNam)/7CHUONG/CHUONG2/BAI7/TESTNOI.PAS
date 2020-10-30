program Cham_bai_2_khoi_B ; (*VOI'2001 *)
uses crt;
var  X,Y :array[0..100] of real;
     noi :array[0..100,0..100]of byte;
     dau,cuoi:array[0..100] of integer;
     noiduoc: array[1..100] of byte;
     dodaitoiuu: array[1..5] of real;
     i,j,k,m1,m2,somay,l :integer;
     lienthong: boolean;
     test: char;
     testnum : byte ;
     tongdiem: integer;
     dodai: real;
     f,g:text;
     tentep:string;

begin
    clrscr;
    textcolor(green);
    writeln('Thi Olympic tin hoc sinh vien toan quoc  -  DHQGHN 2001');
    writeln('Cham bai 2  -  Bang khong chuyen  -  Noi day dien - DKQ');
    writeln('*******************************************************');
    textcolor(7);
    (* Noi dung test 1. Mang dien thong den moi may tinh 1 diem.Neu lien
    thong theo cay 2 diem, gan toi uu muc 10%  duoc 2 diem
    Neu sai toi 1% chap nhan toi uu duoc them 4 diem ,*)
    write('Ban cham test so: ');

    repeat
       test := readkey;    writeln(test);
       testnum := ord(test) - 48;
    until (test >= '1') and (test <= '5');
    textcolor(green);
    writeln;
    writeln;
    writeln;

    textcolor(7);

    tentep := 'NOIDAY.in' + test ;
    assign(f,tentep); reset(f);
    readln(f,somay);
    for i:= 1 to somay do
        read(f,x[i],y[i]);
    x[0] := 0; y[0] := 0;

    (*Doc file out *)
    assign(g,'NOIDAY.OU'+Test);
    {$I-}
    Reset(g);
    {$I+}
    if IOResult <> 0 then
    begin
       textcolor(7);
       Writeln('Khong tim thay file ket qua NOIDAY.OUT');
       textcolor(yellow);
       writeln('-------------------------------------------------------');
       Writeln('                                      Tong diem: 0 diem');
       readln;
       halt;
    end;

    for i:= 0 to somay do
        for j:= 0 to somay do
            noi[i,j]:= 0;
    read(g,l);
    dodai := 0;
    for i := 1 to l do
        begin
           read(g,m1,m2);
           noi[m1,m2]:= 1;
           noi[m2,m1]:= 1;
           dau[i]:= m1; cuoi[i]:=m2;
           dodai := dodai + sqrt(sqr(x[m1]-x[m2]) + sqr(y[m1]-y[m2]))
        end;

    dodaitoiuu[1] := 1; (* Test cuc doan, 1 so lieu *)
    dodaitoiuu[2] := 16.1290; (*Test binh thuong, 9 so lieu *)
    dodaitoiuu[3] := 15.3137; (*Test binh thuong, 12 so lieu *)
    dodaitoiuu[4] := 8;  (*Test cac diem so le - kiem tra noi tuy tien *)
    dodaitoiuu[5] := 127.2792; (*Test lon 90 diem)

    (* Test lien thong tu diem so 0 den tat ca cac diem khac *)
    for k:= 1 to somay do noiduoc[k]:= noi[0,k];
    for k:= 1 to somay do
        for i := 1 to somay do
            for j:= 1 to somay do
                if  (noiduoc[i] = 1) and (noi[i,j]= 1) then
                    noiduoc[j]:= 1;
    lienthong := true;
    for i:= 1 to somay do
        if noiduoc[i] = 0 then
            begin
               lienthong:= false;
               textcolor(white);
               writeln('May tinh thu ',i:3, ' khong co dien');
               break
            end;
    if not lienthong then
        begin
            textcolor(white);
            writeln('Mang dien khong lien thong');
            textcolor(yellow);
            Writeln('                                      Tong diem: 0 diem');
            textcolor(7);
            erase(g);
 	    writeln;
	    writeln('Da xoa tep .out');
            readln;
            halt;
        end
    else
        begin
            write('Mang dien lien thong. ');
            if l = somay then
               begin
                 Writeln('Khong co chu trinh');
                 textcolor(yellow);
                 writeln('                                           Duoc: 2 diem');
                 textcolor(7);
                 Tongdiem := 2
               end
            else
               begin
                 Writeln('Co chu trinh');
                 textcolor(yellow);
                 writeln('                                           Duoc: 1 diem');

                 textcolor(7);
                 Tongdiem := 1
               end;
            writeln('Do dai tinh duoc = ', dodai:10:4, ' ? (Dap an = ',dodaitoiuu[testnum]:10:4,')');
            if Dodai <= Dodaitoiuu[testnum]*1.001 then
                begin
                    writeln('Toi uu voi sai so lam tron chap nhan duoc');
                    textcolor(yellow);
                    Writeln('                                            Duoc 4 diem');
                    Tongdiem:= Tongdiem + 4;
                    textcolor(7);
                end
            else
                if Dodai <= Dodaitoiuu[testnum]*1.1 then
                    begin
                        writeln('Gan toi uu voi muc sai lech duoi 10%. ');
                        textcolor(yellow);
                        Writeln('                                            Duoc 2 diem');
                        Tongdiem:= Tongdiem + 2;
                        textcolor(7);
                    end
                else
                    begin
                        writeln('Do dai khong toi uu');
                        textcolor(yellow);
                        writeln('                                            Duoc 0 diem');
                        textcolor(7);
                    end;
            textcolor(yellow);
            writeln('-------------------------------------------------------');
            writeln('                                     Tong diem: ', Tongdiem:2,' diem');
            textcolor(7);
        end;
    close(g);
    erase(g);
    writeln;
    writeln('Da xoa tep .out');
    readln;
end.
