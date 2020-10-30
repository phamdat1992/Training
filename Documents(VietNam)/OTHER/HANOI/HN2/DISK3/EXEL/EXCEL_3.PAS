uses crt,graph;
const
  chu:array[1..26] of char=('A','B','C','D','E','F','G','H','I','J','K','L',
  'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  so:array[1..50] of string[2]=(' 1',' 2',' 3',' 4',' 5',' 6',' 7',' 8',' 9',
  '10','11','12','13','14','15','16','17','18','19','20','21','22','23','24',
  '25','26','27','28','29','30','31','32','33','34','35','36','37','38','39',
  '40','41','42','43','44','45','46','47','48','49','50');
   doi:array['A'..'Z'] of integer=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
   18,19,20,21,22,23,24,25,26);
   ten='Database For Future - ';
   menu:array[1..6] of string=('File','Edit','Insert','Format','Data','Help');
   (*Ten cua cac menu*)
   tam_mn:array[1..6] of integer=(40,100,160,220,280,340);(*Toa do cot cua
   cac menu*)
   n=12;
   ham:array[1..n] of string[8]=('SUM','AVERAGE','ROUND','MAX','MIN','ABS',
   'SQRT','INT','MOD','DAY','MONTH','YEAR');
type
  mang=array[1..50,1..26] of string[40];
var
  bitmap:pointer;
  ten_file,s:string;
  {Bien ten file dung de luu ten file hien thoi}
  {Bien s dung de luu du lieu nhap vao cua moi o}
  x1,x2,y1,y2,x_tro,y_tro(* Dia chi o trong vung lam viec*),
  x_tro1,y_tro1(*Dia chi o thuc*),gd,gm,xc,ys:integer;
  xt:array[1..50] of integer;(*Toa do dong thuc cua cac o*)
  yt:array[1..26] of integer;(*Toa do cot thuc cua cac o*)
  cl_board,dd,error,start:boolean;
  clip_board:^mang;
  gia_tri:mang;
  kieu,kieu_dinh_dang,kieu_1,kieu_dinh_dang_1:array[1..50,1..26] of byte;
  ch:char;
  f:text;
  dia_chi_1,dia_chi_2:record
                        dong,cot:byte;
                      end;
  th_dau:set of char;
  th_so: set of char;
procedure trao(var a,b:byte);
  var
    tg:byte;
  begin
    tg:=a;
    a:=b;
    b:=tg;
  end;
(*----------------------------------------------------*)

procedure hien_thi(x_tro,y_tro,x_tro1,y_tro1:integer);
  var
    tg:string[5];
  begin
    setcolor(14);
    setfillstyle(1,1);
    bar(yt[y_tro]-25,xt[x_tro]-5,yt[y_tro]+25,xt[x_tro]+5);
    tg:=copy(gia_tri[x_tro1,y_tro1],1,5);
    if kieu_dinh_dang[x_tro,y_tro]=0 then
      begin
        settextjustify(lefttext,centertext);
        outtextxy(yt[y_tro]-18,xt[x_tro],tg);
      end;
    if kieu_dinh_dang[x_tro,y_tro]=1 then
      begin
        settextjustify(centertext,centertext);
        outtextxy(yt[y_tro],xt[x_tro],tg);
      end;
    if kieu_dinh_dang[x_tro,y_tro]=2 then
      begin
        settextjustify(righttext,centertext);
        outtextxy(yt[y_tro]+18,xt[x_tro],tg);
      end;
    setfillstyle(1,1);
    bar(150,42,630,60);
    settextjustify(lefttext,centertext);
    outtextxy(160,50,gia_tri[x_tro1,y_tro1]);
  end;
(*--------------------------------------------------*)
function ngay_thang(s:string):boolean;
  var
    kt,ngay,thang,nam:integer;
  function nam_nhuan(a:integer):boolean;
    begin
      nam_nhuan:=(a mod 4 = 0) and not((a mod 100 = 0) and (a mod 400 <> 0))
    end;
  begin
    ngay_thang:=true;
    if (length(s)=10) and (s[3]='/') and (s[6]='/') then
      begin
        val(s[1]+s[2],ngay,kt);
        val(s[4]+s[5],thang,kt);
        val(s[7]+s[8]+s[9]+s[10],nam,kt);
        if nam>=1980 then
          begin
            if (thang<=12) and (thang>=1) then
              begin
                case thang of
                  1,3,5,7,8,10,12:
                    if (ngay>31) or (ngay<1) then ngay_thang:=false;
                  4,6,9,11:
                    if (ngay>30) or (ngay<1) then ngay_thang:=false;
                  2:
                    if nam_nhuan(nam) then
                      begin
                        if (ngay>29) or (ngay<1) then ngay_thang:=false;
                      end
                    else
                      begin
                        if (ngay>28) or (ngay<1) then ngay_thang:=false;
                      end;
                end;
              end
            else ngay_thang:=false;
          end
        else ngay_thang:=false;
      end
    else ngay_thang:=false;
  end;
(*----------------------------------------------------*)
function address(s:string):boolean;
  var
    kt:integer;
    tg:real;
  begin
    if s[1] in ['A'..'Z'] then
      begin
        val(copy(s,2,length(s)-1),tg,kt);
        if kt<>0 then address:=false
        else
          if (tg>=1) and (tg<=50) and (round(tg)=tg) then address:=true
          else address:=false;
      end
    else address:=false;
  end;
(*----------------------------------------------------*)
var
  bien_1:array[1..100] of real;
  dem_1:integer;
procedure tach_bien(s:string);
  var
    s1,s2:string;
    x1,y1,x2,y2:byte;
    i,kt,k,l:integer;
  begin
    i:=1;
    while i<=length(s) do
      begin
        if s[i]=' ' then delete(s,i,1)
        else inc(i);
      end;
    dem_1:=0;
    i:=1;
    s1:='';
    s:=s+',';
    while i<=length(s) do
      begin
        if s[i]=',' then
          begin
            inc(dem_1);
            if address(s1) then
              begin
                y1:=doi[s1[1]];
                val(copy(s1,2,length(s1)-1),x1,kt);
                if kieu[x1,y1]<>3 then
                  begin
                    error:=true;
                    exit;
                  end;
                val(gia_tri[x1,y1],bien_1[dem_1],kt);
              end
            else
              begin
                val(s1,bien_1[dem_1],kt);
                if kt<>0 then
                  begin
                    error:=true;
                    exit;
                  end;
              end;
            s1:='';
          end
        else
          if s[i] in ['A'..'Z','0'..'9','.','-'] then s1:=s1+s[i]
          else
            if s[i]=':' then
              begin
                if address(s1) then
                  begin
                    s2:='';
                    inc(i);
                    while (i<=length(s)) and (s[i] in ['A'..'Z','0'..'9','.','-']) do
                      begin
                        s2:=s2+s[i];
                        inc(i);
                      end;
                    if (i<length(s)) and (s[i]<>',') then
                      begin
                        error:=true;
                        exit;
                      end;
                    if address(s2) then
                      begin
                        y1:=doi[s1[1]];
                        y2:=doi[s2[1]];
                        val(copy(s1,2,length(s1)-1),x1,kt);
                        val(copy(s2,2,length(s2)-1),x2,kt);
                        if x1>x2 then trao(x1,x2);
                        if y1>y2 then trao(y1,y2);
                        for k:=x1 to x2 do
                          for l:=y1 to y2 do
                            if kieu[k,l]=3 then
                              begin
                                inc(dem_1);
                                val(gia_tri[k,l],bien_1[dem_1],kt);
                              end
                            else
                              begin
                                error:=true;
                                exit;
                              end;
                      end;
                    s1:='';
                  end
                else
                  begin
                    error:=true;
                    exit;
                  end;
              end
            else
              begin
                error:=true;
                exit;
              end;
        inc(i);
      end;
  end;
function sum(s:string):real;
  var
    tg:real;
    i:integer;
  begin
    tach_bien(s);
    if dem_1>=1 then
      begin
        tg:=0;
        for i:=1 to dem_1 do tg:=tg+bien_1[i];
        sum:=tg;
      end
    else error:=true;
  end;
(*----------------------------------------------------*)
function average(s:string):real;
  var
    i:integer;
    tg:real;
  begin
    tach_bien(s);
    if dem_1>=1 then
      begin
        tg:=0;
        for i:=1 to dem_1 do tg:=tg+bien_1[i];
        average:=tg/dem_1;
      end
    else error:=true;
  end;
(*----------------------------------------------------*)
function round_1(s:string):real;
  begin
    tach_bien(s);
    if dem_1=1 then round_1:=round(bien_1[1])
    else error:=true;
  end;
(*----------------------------------------------------*)
function max(s:string):real;
  var
    tg:real;
    i:integer;
  begin
    tach_bien(s);
    if dem_1>=1 then
      begin
        tg:=-1000000000;
        for i:=1 to dem_1 do
          if tg<bien_1[i] then tg:=bien_1[i];
        max:=tg;
      end
    else error:=true;
  end;
(*----------------------------------------------------*)
function min(s:string):real;
  var
    tg:real;
    i:integer;
  begin
    tach_bien(s);
    if dem_1>=1 then
      begin
        tg:=1000000000;
        for i:=1 to dem_1 do
          if tg>bien_1[i] then tg:=bien_1[i];
        min:=tg;
      end
    else error:=true;
  end;

(*----------------------------------------------------*)
function abs_1(s:string):real;
  begin
    tach_bien(s);
    if dem_1=1 then abs_1:=abs(bien_1[1])
    else error:=true;
  end;
(*----------------------------------------------------*)
function sqrt_1(s:string):real;
  begin
    tach_bien(s);
    if dem_1=1 then sqrt_1:=sqrt(bien_1[1])
    else error:=true;
  end;
(*----------------------------------------------------*)
function int_1(s:string):real;
  begin
    tach_bien(s);
    if dem_1=1 then int_1:=int(bien_1[1])
    else error:=true;
  end;
(*----------------------------------------------------*)
function mod_1(s:string):real;
  var
    chia,du:real;
  begin
    tach_bien(s);
    if dem_1=2 then
      begin
        chia:=bien_1[1]/bien_1[2];
        mod_1:=bien_1[1]-trunc(chia)*bien_1[2];
      end
    else error:=true;
  end;
(*----------------------------------------------------*)
function day(s:string):integer;
  var
    i,x1,y1,tg,kt:integer;
  begin
    i:=1;
    while i<=length(s) do
      begin
        if s[i]=' ' then delete(s,i,1)
        else inc(i);
      end;
    if address(s) then
      begin
        y1:=doi[s[1]];
        val(copy(s,2,length(s)-1),x1,kt);
        if kieu[x1,y1]=2 then
          begin
            val(copy(gia_tri[x1,y1],1,2),tg,kt);
            day:=tg;
          end
        else error:=true;
      end;
  end;
(*----------------------------------------------------*)
function month(s:string):integer;
  var
    i,x1,y1,tg,kt:integer;
  begin
    i:=1;
    while i<=length(s) do
      begin
        if s[i]=' ' then delete(s,i,1)
        else inc(i);
      end;
    if address(s) then
      begin
        y1:=doi[s[1]];
        val(copy(s,2,length(s)-1),x1,kt);
        if kieu[x1,y1]=2 then
          begin
            val(copy(gia_tri[x1,y1],4,2),tg,kt);
            month:=tg;
          end
        else error:=true;
      end;
  end;
(*----------------------------------------------------*)
function year(s:string):integer;
  var
    i,x1,y1,tg,kt:integer;
  begin
    i:=1;
    while i<=length(s) do
      begin
        if s[i]=' ' then delete(s,i,1)
        else inc(i);
      end;
    if address(s) then
      begin
        y1:=doi[s[1]];
        val(copy(s,2,length(s)-1),x1,kt);
        if kieu[x1,y1]=2 then
          begin
            val(copy(gia_tri[x1,y1],7,4),tg,kt);
            year:=tg;
          end
        else error:=true;
      end;
  end;
(*----------------------------------------------------*)
function hop_le(s:string):boolean;
  var
    dem,i:integer;
  begin
    hop_le:=false;
    dem:=0;
    i:=1;
    while i<=length(s) do
      begin
        if s[i]='(' then inc(dem);
        if s[i]=')' then dec(dem);
        if dem<0 then break;
        inc(i);
      end;
    if dem<>0 then
      begin
        error:=true;
        exit;
      end;
    i:=1;
    while i<=length(s) do
      begin
        if s[i]='(' then
          begin
            if (i>1) and ((s[i-1]<>'(') and
            (not (s[i-1] in ['+','-','*','/'])))then
              begin
                error:=true;
                exit;
              end;
            inc(i);
          end else
        if s[i]=')' then
          begin
            if ((s[i-1]<>')') and (not (s[i-1] in ['0'..'9']))) then
              begin
                error:=true;
                exit;
              end;
            inc(i);
          end else
        if s[i] in th_so then
          begin
            if (i>1) and (s[i-1]<>'(') and (not (s[i-1] in th_dau)) then
              begin
                error:=true;
                exit;
              end;
            dem:=0;
            while ((s[i] in th_so) or (s[i]='.')) and (i<=length(s)) do
              begin
                if s[i]='.' then
                  begin
                    if not(s[i+1] in th_so) then
                      begin
                        error:=true;
                        exit;
                      end;
                    inc(dem);
                  end;
                if dem>1 then
                  begin
                    error:=true;
                    exit;
                  end;
                inc(i);
              end;
          end else
        if s[i] in th_dau then
          begin
            if (i>1) and (not (s[i-1] in th_so)) and (s[i-1]<>')') then
              begin
                error:=true;
                exit;
              end;
            inc(i);
          end
        else
          begin
            error:=true;
            exit;
          end;
      end;
    hop_le:=true;
  end;
(*----------------------------------------------------*)
procedure doi_bien(s:string);
  var
    i,j,x,y:integer;
  begin
    i:=1;
    while i<=length(s) do
      begin
        if s[i] in ['A'..'Z'] then
          begin
            j:=i+1;
            x:=0;
            while (j<=length(s)) and (s[j] in ['0'..'9']) do
              begin
                x:=x*10+ord(s[j])-48;
                inc(j);
              end;
            if (j<=length(s)) and (s[j]<>')') and (not (s[j] in th_dau)) then
              begin
                error:=true;
                exit;
              end;
            if (x<51) and (x>0) then
              begin
                y:=doi[s[i]];
                if kieu[x,y]=3 then
                  begin
                    delete(s,i,j-i);
                    insert(gia_tri[x,y],s,i);
                  end
                else
                  begin
                    error:=true;
                    exit;
                  end;
              end
            else
              begin
                error:=true;
                exit;
              end;
          end;
        inc(i);
      end;
  end;
(*----------------------------------------------------*)
procedure tb_ngoac(var s:string);
  var
    i,i1,i2,dem:integer;
    ok:boolean;
  begin
    s:='('+s+')';
    i:=1;
    while i<=length(s) do
      begin
        if s[i] in ['*','/'] then
          begin
            dem:=0;
            i1:=i;
            i2:=i;
            ok:=true;
            repeat
             dec(i1);
             if dem=0 then
               begin
                 if (s[i1]='(') or (s[i1] in th_dau) then
                   begin
                     if s[i1]<>'(' then ok:=false;
                     break;
                   end;
               end;
             if s[i1]=')' then inc(dem);
             if s[i1]='(' then dec(dem);
            until false;
            repeat
             inc(i2);
             if dem=0 then
               begin
                 if (s[i2]=')') or (s[i2] in th_dau) then
                   begin
                     if s[i2]<>')' then ok:=false;
                     break;
                   end;
               end;
             if s[i2]=')' then inc(dem);
             if s[i2]='(' then dec(dem);
            until false;
            if ok then
              begin
                dec(i1);
                inc(i2);
                while (s[i1]='(') and (s[i2]=')') and (i1>0) and (i2<=length(s))
                do
                  begin
                    delete(s,i2,1);
                    delete(s,i1,1);
                    dec(i2,2);
                    dec(i1);
                    inc(i);
                  end;
                inc(i);
              end
            else
              begin
                insert(')',s,i2);
                insert('(',s,i1+1);
                inc(i,2);
              end;
          end
        else inc(i);
      end;
    i:=1;
    while i<=length(s) do
      begin
        if s[i] in ['+','-'] then
          begin
            dem:=0;
            i1:=i;
            i2:=i;
            ok:=true;
            repeat
             dec(i1);
             if dem=0 then
               begin
                 if (s[i1]='(') or (s[i1] in th_dau) then
                   begin
                     if s[i1]<>'(' then ok:=false;
                     break;
                   end;
               end;
             if s[i1]=')' then inc(dem);
             if s[i1]='(' then dec(dem);
            until false;
            repeat
             inc(i2);
             if dem=0 then
               begin
                 if (s[i2]=')') or (s[i2] in th_dau) then
                   begin
                     if s[i2]<>')' then ok:=false;
                     break;
                   end;
               end;
             if s[i2]=')' then inc(dem);
             if s[i2]='(' then dec(dem);
            until false;
            if ok then
              begin
                dec(i1);
                inc(i2);
                while (s[i1]='(') and (s[i2]=')') and (i1>0) and (i2<=length(s))
                do
                  begin
                    delete(s,i2,1);
                    delete(s,i1,1);
                    dec(i2,2);
                    dec(i1);
                    inc(i);
                  end;
                inc(i);
              end
            else
              begin
                insert(')',s,i2);
                insert('(',s,i1+1);
                inc(i,2);
              end;
          end
        else inc(i);
      end;
  end;
(*----------------------------------------------------*)
function balan(s:string):real;
  var
    ten,s1:string;
    ok:boolean;
    i,k:integer;
  function tinh:real;
    var
      i,dau_s,dau_d,dem,j:integer;
      dau:array[1..100] of char;
      so:array[1..100] of real;
      x,tg:real;
    Begin
      i:=1;
      dau_d:=0;
      dau_s:=0;
      while i<=length(s) do
        begin
          if s[i]=')' then
            begin
              case dau[dau_d] of
                '+':so[dau_s-1]:=so[dau_s-1]+so[dau_s];
                '-':so[dau_s-1]:=so[dau_s-1]-so[dau_s];
                '*':so[dau_s-1]:=so[dau_s-1]*so[dau_s];
                '/':so[dau_s-1]:=so[dau_s-1]/so[dau_s];
              end;
              dec(dau_d);
              dec(dau_s);
              inc(i);
            end else
          if s[i] in th_dau then
            begin
              inc(dau_d);
              dau[dau_d]:=s[i];
              inc(i);
            end else
          if s[i] in th_so then
            begin
              x:=ord(s[i])-48;
              dem:=0;
              inc(i);
              while (i<=length(s)) and ((s[i] in th_so) or (s[i]='.')) do
                begin
                  if s[i] in th_so then
                    begin
                      if dem=0 then x:=x*10+ord(s[i])-48
                      else
                        begin
                          tg:=ord(s[i])-48;
                          for j:=1 to dem do tg:=tg/10;
                          x:=x+tg;
                          inc(dem);
                        end;
                    end
                  else inc(dem);
                  inc(i);
                end;
              inc(dau_s);
              so[dau_s]:=x;
            end
          else inc(i);
        end;
      tinh:=so[1];
    End;
  Begin
    if (s[1] in ['A'..'Z'])and(s[2] in ['A'..'Z']) then
      begin
        ten:='';
        i:=1;
        while (i<=length(s)) and (s[i] in ['A'..'Z']) do
          begin
            ten:=ten+s[i];
            inc(i);
          end;
        ok:=false;
         for k:=1 to n do
            if ten=ham[k] then
              begin
                ok:=true;
                if (s[i]='(') and (s[length(s)]=')') then
                  begin
                    s1:=copy(s,i+1,length(s)-i-1);
                    case k of
                      1:balan:=sum(s1);
                      2:balan:=average(s1);
                      3:balan:=round_1(s1);
                      4:balan:=max(s1);
                      5:balan:=min(s1);
                      6:balan:=abs_1(s1);
                      7:balan:=sqrt_1(s1);
                      8:balan:=int_1(s1);
                      9:balan:=mod_1(s1);
                      10:balan:=day(s1);
                      11:balan:=month(s1);
                      12:balan:=year(s1);
                    end;
                  end
                else
                  begin
                    error:=true;
                    exit;
                  end;
              end;
          if not ok then error:=true;
      end
    else
      begin
        doi_bien(s);
        if error then exit;
        if hop_le(s) then
          begin
            tb_ngoac(s);
            balan:=tinh;
          end;
      end;
  End;
(*----------------------------------------------------*)
procedure tinh_gia_tri;
  var
    tg:string;
    so,ket_qua:real;
    kt,i:integer;
  begin
    setfillstyle(1,1);
    bar(150,42,630,60);
    tg:='';
    for i:=1 to length(s) do tg:=tg+upcase(s[i]);
    if (s[1]<>'=') or (s='=') then
      begin
        if (tg='TRUE') or (tg='FALSE') then
          begin
            kieu[x_tro1,y_tro1]:=1;
            kieu_dinh_dang[x_tro1,y_tro1]:=2;
            gia_tri[x_tro1,y_tro1]:=tg;
          end
        else
          begin
            val(s,so,kt);
            if kt=0 then
              begin
                kieu[x_tro1,y_tro1]:=3;
                kieu_dinh_dang[x_tro1,y_tro1]:=2;
                gia_tri[x_tro1,y_tro1]:=tg;
              end
            else
              begin
                if ngay_thang(tg) then
                  begin
                    kieu[x_tro1,y_tro1]:=2;
                    kieu_dinh_dang[x_tro1,y_tro1]:=2;
                    gia_tri[x_tro1,y_tro1]:=tg;
                  end
                else
                  begin
                    kieu[x_tro1,y_tro1]:=4;
                    gia_tri[x_tro1,y_tro1]:=s;
                    kieu_dinh_dang[x_tro1,y_tro1]:=0;
                  end;
              end;
          end;
      end
    else
      begin
        error:=false;
        delete(tg,1,1);
        ket_qua:=balan(tg);
        if not error then
          begin
            kieu[x_tro1,y_tro1]:=3;
            kieu_dinh_dang[x_tro1,y_tro1]:=2;
            if (pos('DAY',tg)<>0)or(pos('MONTH',tg)<>0)or(pos('YEAR',tg)<>0) then
              str(ket_qua:5:0,gia_tri[x_tro1,y_tro1])
            else str(ket_qua:5:2,gia_tri[x_tro1,y_tro1]);
          end
        else
          begin
            gia_tri[x_tro1,y_tro1]:='#####';
            kieu[x_tro1,y_tro1]:=0;
            kieu_dinh_dang[x_tro1,y_tro1]:=2;
          end;
      end;
    bar(yt[y_tro]-26,xt[x_tro]-6,yt[y_tro]+26,xt[x_tro]+6);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
    s:='';
  end;
(*----------------------------------------------------*)

procedure khoi_tao;
  var
    i,j:integer;
  begin
    (*Khoi tao cac toa do dau tien*)
    x1:=1;
    y1:=1;
    x2:=19;
    y2:=10;

    x_tro:=1;
    y_tro:=1;
    x_tro1:=1;
    y_tro1:=1;
    yt[1]:=60;
    xt[1]:=90;
    xc:=70;
    ys:=15;
    for i:=2 to 26 do yt[i]:=yt[i-1]+60;
    for i:=2 to 50 do xt[i]:=xt[i-1]+20;
    {Khoi tao gia_tri ban dau la false}

  end;
(*----------------------------------------------------*)
procedure up;
  var
    i,j:integer;
  begin
    settextjustify(centertext,centertext);
    if s<>'' then tinh_gia_tri;
    if x_tro1>1 then dec(x_tro1);
    if x_tro>1 then
      begin
        setcolor(1);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
        dec(x_tro);
        setcolor(7);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
      end
    else
      if x1>1 then
        begin
          setcolor(red);
          for i:=x1 to x2 do outtextxy(ys,xt[i-x1+1],so[i]);
          dec(x1);
          dec(x2);
          setcolor(14);
          for i:=x1 to x2 do outtextxy(ys,xt[i-x1+1],so[i]);
          for i:=x1 to x2 do
            for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
        end;
    setfillstyle(1,3);
    bar(1,42,100,60);
    setcolor(15);
    settextjustify(centertext,centertext);
    if x_tro1<10 then outtextxy(50,52,chu[y_tro1]+so[x_tro1])
    else outtextxy(50,52,chu[y_tro1]+' '+so[x_tro1]);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*----------------------------------------------------*)
procedure down;
  var
    i,j:integer;
  begin
    settextjustify(centertext,centertext);
    if s<>'' then tinh_gia_tri;
    if x_tro1<50 then inc(x_tro1);
    if x_tro<19 then
      begin
        setcolor(1);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
        inc(x_tro);
        setcolor(7);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
      end
    else
      if x2<50 then
        begin
          setcolor(red);
          for i:=x1 to x2 do outtextxy(ys,xt[i-x1+1],so[i]);
          inc(x1);
          inc(x2);
          setcolor(14);
          for i:=x1 to x2 do outtextxy(ys,xt[i-x1+1],so[i]);
          for i:=x1 to x2 do
            for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
        end;
    setfillstyle(1,3);
    bar(1,42,100,60);
    setcolor(15);
    settextjustify(centertext,centertext);
    if x_tro1<10 then outtextxy(50,52,chu[y_tro1]+so[x_tro1])
    else outtextxy(50,52,chu[y_tro1]+' '+so[x_tro1]);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*----------------------------------------------------*)
procedure left;
  var
    i,j:integer;
  begin
    settextjustify(centertext,centertext);
    if s<>'' then tinh_gia_tri;
    if y_tro1>1 then dec(y_tro1);
    if y_tro>1 then
      begin
        setcolor(1);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
        dec(y_tro);
        setcolor(7);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
      end
    else
      if y1>1 then
        begin
          setcolor(red);
          for i:=y1 to y2 do outtextxy(yt[i-y1+1],xc,chu[i]);
          dec(y1);
          dec(y2);
          setcolor(14);
          for i:=y1 to y2 do outtextxy(yt[i-y1+1],xc,chu[i]);
          for i:=x1 to x2 do
            for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
        end;
    setfillstyle(1,3);
    bar(1,42,100,60);
    setcolor(15);
    settextjustify(centertext,centertext);
    if x_tro1<10 then outtextxy(50,52,chu[y_tro1]+so[x_tro1])
    else outtextxy(50,52,chu[y_tro1]+' '+so[x_tro1]);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*----------------------------------------------------*)
procedure right;
  var
    i,j:integer;
  begin
    settextjustify(centertext,centertext);
    if s<>'' then tinh_gia_tri;
    if y_tro1<26 then inc(y_tro1);
    if y_tro<10 then
      begin
        setcolor(1);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
        inc(y_tro);
        setcolor(7);
        setlinestyle(0,15,3);
        rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
      end
    else
      if y2<26 then
        begin
          setcolor(red);
           for i:=y1 to y2 do outtextxy(yt[i-y1+1],xc,chu[i]);
          inc(y1);
          inc(y2);
          setcolor(14);
          for i:=y1 to y2 do outtextxy(yt[i-y1+1],xc,chu[i]);
          for i:=x1 to x2 do
            for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
        end;
    setfillstyle(1,3);
    bar(1,42,100,60);
    setcolor(15);
    settextjustify(centertext,centertext);
    if x_tro1<10 then outtextxy(50,52,chu[y_tro1]+so[x_tro1])
    else outtextxy(50,52,chu[y_tro1]+' '+so[x_tro1]);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*----------------------------------------------------*)
procedure paste;
  var
    i,j:integer;
  begin
    if cl_board then
      begin
        for i:=x_tro1 to x_tro1+dia_chi_2.dong-dia_chi_1.dong do
          for j:=y_tro1 to y_tro1+dia_chi_2.cot-dia_chi_1.cot do
            begin
              gia_tri[i,j]:=clip_board^[i-x_tro1+dia_chi_1.dong,
                                               j-y_tro1+dia_chi_1.cot];
              kieu[i,j]:=kieu_1[i-x_tro1+dia_chi_1.dong,
                                               j-y_tro1+dia_chi_1.cot];
              kieu_dinh_dang[i,j]:=kieu_dinh_dang_1[i-x_tro1+dia_chi_1.dong,
                                               j-y_tro1+dia_chi_1.cot];
            end;
        for i:=x1 to x2 do
          for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
      end;
  end;
(*----------------------------------------------------*)
procedure copy_1;
  var
    i,j:integer;
  begin
    if dd then
      begin
        for i:=dia_chi_1.dong to dia_chi_2.dong do
          for j:=dia_chi_1.cot to dia_chi_2.cot do
            begin
              clip_board^[i,j]:=gia_tri[i,j];
              kieu_1[i,j]:=kieu[i,j];
              kieu_dinh_dang_1[i,j]:=kieu_dinh_dang[i,j];
            end;
        cl_board:=true;
        dd:=false;
      end;
  end;
(*----------------------------------------------------*)
procedure cut;
  var
    i,j:integer;
  begin
    if dd then
      begin
        for i:=dia_chi_1.dong to dia_chi_2.dong do
          for j:=dia_chi_1.cot to dia_chi_2.cot do
            begin
              clip_board^[i,j]:=gia_tri[i,j];
              kieu_1[i,j]:=kieu[i,j];
              kieu_dinh_dang_1[i,j]:=kieu_dinh_dang[i,j];
              kieu[i,j]:=0;
              kieu_dinh_dang[i,j]:=2;
              gia_tri[i,j]:='';
            end;
         for i:=x1 to x2 do
           for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
         cl_board:=true;
         dd:=false;
       end;
  end;
(*----------------------------------------------------*)
procedure status;
  const
    s1:array[1..6] of string[8]=('F1','F2','F3','F4','F10','ALT+F4');
    s2:array[1..6] of string[4]=('Help','Save','Open','New','Menu','Exit');
    {s1, s2 la hai xau de luu chu thich dong trang thai}
  var
    x,i:integer;
  begin
    x:=15;{Bien x de cong toa do cot}
    setfillstyle(1,7);
    bar(1,462,630,480);
    for i:=1 to 5 do
      begin
        setcolor(red);
        outtextxy(x,472,s1[i]);
        setcolor(0);
        x:=x+35;
        outtextxy(x,472,s2[i]);
        x:=x+70;
      end;
     setcolor(red);
     outtextxy(x,472,s1[6]);
     setcolor(0);
     x:=x+50;
     outtextxy(x,472,s2[6]);
  end;
(*----------------------------------------------------*)
procedure title_bar;
  begin
    settextjustify(centertext,centertext);
    setfillstyle(1,lightblue);
    setcolor(14);
    bar(1,1,630,20);
    outtextxy(315,10,ten+ten_file);
    setfillstyle(1,2);
    bar(5,5,10,15);
  end;
(*----------------------------------------------------*)
procedure ve;
  var
    x,i:integer;
    {Bien x dung de cong toa do cot cua cac chu tren menu}
  begin
    (* Ve khung vung lam viec*)
    setcolor(7);
    setfillstyle(1,4);
    rectangle(1,60,630,460);
    line(1,80,630,80);
    floodfill(2,70,7);
    line(30,60,30,460);
    floodfill(15,90,7);
    setfillstyle(1,1);
    floodfill(300,200,7);
    (*Ve cac o trong vung lam viec*)
    (*Ve cac cot*)
    x:=90;
    for i:=1 to 10 do
      begin
        line(x,60,x,460);
        x:=x+60;
      end;
    (*Ve cac hang*)
    x:=100;
    for i:=1 to 20 do
      begin
        line(1,x,630,x);
        x:=x+20;
      end;
    (*Ve con tro khoi tao*)
    setlinestyle(0,15,3);
    rectangle(yt[y_tro]-28,xt[x_tro]-8,yt[y_tro]+28,xt[x_tro]+8);
    (*Ve cac hang chu va dong so*)
    setcolor(14);
    settextjustify(centertext,centertext);
    for i:=1 to 10 do outtextxy(yt[i],xc,chu[i]);
    for i:=1 to 19 do outtextxy(ys,xt[i],so[i]);
    (*Ve thanh tieu de*)
    title_bar;
    (*Ve khung thanh menu*)
    setfillstyle(1,7);
    bar(1,22,630,40);
    (*Ve o dia chi*)
    setfillstyle(1,3);
    bar(1,42,100,60);
    (*Khoi tao dia chi o 1:1 tai o dia chi*)
    setcolor(15);
    settextjustify(centertext,centertext);
    if x_tro1<10 then outtextxy(50,52,chu[y_tro1]+so[x_tro1])
    else outtextxy(50,52,chu[y_tro1]+' '+so[x_tro1]);
    (*Ve o ngan cach giua o dia chi va o cong thuc*)
    setfillstyle(1,14);
    bar(100,42,150,60);
    setcolor(red);
    outtextxy(135,50,'=');
    (*Ve thanh cong thuc*)
    setfillstyle(1,1);
    bar(150,42,630,60);
    (*Ve cac muc cua menu*)
    setcolor(0);
    for i:=1 to 6 do outtextxy(tam_mn[i],30,menu[i]);

    setfillstyle(1,5);
    bar(5,25,10,35);

    setcolor(black);
    setlinestyle(0,1,1);
    outtextxy(620,10,'X');
    rectangle(612,3,627,15);
    (*Ve dong trang thai*)
    status;
  end;
(*----------------------------------------------------*)
procedure help;
  var
    ch:char;
  begin
  end;
(*----------------------------------------------------*)
procedure frame_1(s:string);
  begin
    setlinestyle(0,1,1);
    getmem(bitmap,imagesize(218,189,422,292));
    getimage(218,189,422,292,bitmap^);
    setfillstyle(1,7);
    bar(320-100,240-50,320+100,240+50);
    setfillstyle(1,lightblue);
    bar(220,190,420,210);
    setcolor(7);
    rectangle(220,190,420,210);
    rectangle(221,191,419,209);
    setcolor(black);
    line(421,190,421,290);
    line(219,291,421,291);
    line(422,189,422,292);
    line(219,292,421,292);
    setcolor(white);
    line(219,190,219,290);
    line(219,190,420,190);
    line(218,189,218,291);
    line(219,189,421,189);

    settextjustify(lefttext,centertext);
    outtextxy(230,200,s);

    outtextxy(242,240,'Do you want to save ');
    outtextxy(245,260,'"'+ten_file+'"'+' (Y/N) ?');

  end;
(*----------------------------------------------------*)
procedure frame(s:string);
  begin
    setlinestyle(0,1,1);
    getmem(bitmap,imagesize(218,189,422,292));
    getimage(218,189,422,292,bitmap^);
    setfillstyle(1,7);
    bar(320-100,240-50,320+100,240+50);
    setfillstyle(1,lightblue);
    bar(220,190,420,210);
    setcolor(7);
    rectangle(220,190,420,210);
    rectangle(221,191,419,209);
    setcolor(black);
    line(421,190,421,290);
    line(219,291,421,291);
    line(422,189,422,292);
    line(219,292,421,292);
    setcolor(white);
    line(219,190,219,290);
    line(219,190,420,190);
    line(218,189,218,291);
    line(219,189,421,189);

    settextjustify(lefttext,centertext);
    outtextxy(230,200,s);

    outtextxy(230,230,'File name');
    setfillstyle(1,15);
    bar(230,245,410,265);
  end;
(*----------------------------------------------------*)
procedure save;
  var
    i,j:integer;
    s:string;
    ch:char;
  begin
    if ten_file='Noname.dbf' then
      begin
        frame('Save As');
        setfillstyle(1,7);
        bar(1,462,620,480);
        setcolor(0);
        outtextxy(50,472,'Enter file name');
        s:='';
        setcolor(0);
        i:=1;
        repeat
          ch:=readkey;
          if ch in ['A'..'Z','a'..'z','0'..'9','_'] then
              if ((i=1) and not(ch in ['0'..'9'])) or ((i<=8) and (i>1)) then
                begin
                  s:=s+ch;
                  inc(i);
                end;
          outtextxy(235,255,s);
        until (ch=#27) or (ch=#13);
        if ch=#27 then
          begin
            putimage(218,189,bitmap^,0);
            status;
            exit;
          end;
        putimage(218,189,bitmap^,0);
        freemem(bitmap,imagesize(218,189,422,292));
        ten_file:=s+'.dbf';
        ten_file[1]:=upcase(ten_file[1]);
        title_bar;
      end;
    setfillstyle(1,7);
    bar(1,462,620,480);
    setcolor(0);
    outtextxy(100,472,'Saving file...');
    delay(1000);
    assign(f,ten_file);
    rewrite(f);
    for i:=1 to 50 do
      for j:=1 to 26 do
        begin
          writeln(f,gia_tri[i,j]);
          writeln(f,kieu[i,j]);
          writeln(f,kieu_dinh_dang[i,j]);
        end;
    close(f);
    status;
  end;
(*----------------------------------------------------*)
procedure open;
  var
    i,j:integer;
    s:string;
    ch:char;
  begin
        frame_1('Database For Furture');
        repeat
          ch:=readkey;
        until (ch='y') or (ch='n') or (ch='Y') or (ch='N');
        putimage(218,189,bitmap^,0);
        freemem(bitmap,imagesize(218,189,422,292));
        if (ch='y') or (ch='Y') then save;

        frame('Open');
        setfillstyle(1,7);
        bar(1,462,620,480);
        setcolor(0);
        outtextxy(50,472,'Enter file name');
        s:='';
        setcolor(0);
        i:=1;
        repeat
          ch:=readkey;
          if ch in ['A'..'Z','a'..'z','0'..'9','_'] then
              if ((i=1) and not(ch in ['0'..'9'])) or ((i<=8) and (i>1)) then
                begin
                  s:=s+ch;
                  inc(i);
                end;
          outtextxy(235,255,s);
        until (ch=#27) or (ch=#13);
        if ch=#27 then
          begin
            putimage(218,189,bitmap^,0);
            status;
            exit;
          end;
        putimage(218,189,bitmap^,0);
        freemem(bitmap,imagesize(218,189,422,292));
        ten_file:=s+'.dbf';
        ten_file[1]:=upcase(ten_file[1]);
        title_bar;
    setfillstyle(1,7);
    bar(1,462,620,480);
    setcolor(0);
    outtextxy(100,472,'Opening file...');
    delay(1000);
    assign(f,ten_file);
    reset(f);
    for i:=1 to 50 do
      for j:=1 to 26 do
        begin
          readln(f,gia_tri[i,j]);
          readln(f,kieu[i,j]);
          readln(f,kieu_dinh_dang[i,j]);
        end;
    close(f);
    khoi_tao;
    cleardevice;
    ve;
    for i:=1 to 19 do
      for j:=1 to 10 do hien_thi(i,j,i,j);
  end;
(*----------------------------------------------------*)
procedure new_1;
  var
    i,j:integer;
  begin
    for i:=1 to 50 do
      for j:=1 to 26 do
        begin
          gia_tri[i,j]:='';
        end;
    fillchar(kieu,sizeof(kieu),0);
    fillchar(kieu_dinh_dang,sizeof(kieu_dinh_dang),2);
    if not start then
      begin
        frame_1('Database For Furture');
        repeat
          ch:=readkey;
        until (ch='y') or (ch='n') or (ch='Y') or (ch='N');
        putimage(218,189,bitmap^,0);
        freemem(bitmap,imagesize(218,189,422,292));
        if (ch='y') or (ch='Y') then save;
        cleardevice;
      end;
    ten_file:='Noname.dbf';
    khoi_tao;
    ve;
  end;
(*----------------------------------------------------*)
procedure quit;
  var
    ch:char;
  begin
    frame_1('Database For Furture');
    repeat
      ch:=readkey;
    until (ch='y') or (ch='n') or (ch='Y') or (ch='N');
    putimage(218,189,bitmap^,0);
    freemem(bitmap,imagesize(218,189,422,292));
    if (ch='y') or (ch='Y') then save;
    closegraph;
    dispose(clip_board);
    halt;
  end;
(*----------------------------------------------------*)
procedure cell;
  const
    dong:Array[1..2] of integer=(235,265);
  var
    i,tro_cell:integer;
    ch:char;
  procedure up;
    begin
      setcolor(7);
      setfillstyle(1,15);
      rectangle(320-70,dong[tro_cell]-10,320+80,dong[tro_cell]+10);
      fillellipse(240,dong[tro_cell],2,2);
      if tro_cell=1 then tro_cell:=2
      else dec(tro_cell);
      setcolor(0);
      setfillstyle(1,0);
      rectangle(320-70,dong[tro_cell]-10,320+80,dong[tro_cell]+10);
      fillellipse(240,dong[tro_cell],2,2);
    end;
  (*- - - - - - -*)
  procedure down;
    begin
      setcolor(7);
      setfillstyle(1,15);
      rectangle(320-70,dong[tro_cell]-10,320+80,dong[tro_cell]+10);
      fillellipse(240,dong[tro_cell],2,2);
      if tro_cell=2 then tro_cell:=1
      else inc(tro_cell);
      setcolor(0);
      setfillstyle(1,0);
      rectangle(320-70,dong[tro_cell]-10,320+80,dong[tro_cell]+10);
      fillellipse(240,dong[tro_cell],2,2);
    end;
  (*- - - - - - -*)
  procedure shift_down;
    var
      i,j:integer;
    begin
      for i:=50 downto x_tro1+1 do
        begin
          gia_tri[i,y_tro1]:=gia_tri[i-1,y_tro1];
          kieu[i,y_tro1]:=kieu[i-1,y_tro1];
          kieu_dinh_dang[i,y_tro1]:=kieu_dinh_dang[i-1,y_tro1];
        end;
      gia_tri[x_tro1,y_tro1]:='';
      kieu[x_tro1,y_tro1]:=0;
      kieu_dinh_dang[x_tro1,y_tro1]:=2;
      for i:=x1 to x2 do
        for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
    end;
  (*- - - - - - -*)
  procedure shift_right;
    var
      i,j:integer;
    begin
      for i:=26 downto y_tro1+1 do
        begin
          gia_tri[x_tro1,i]:=gia_tri[x_tro1,i-1];
          kieu[x_tro1,i]:=kieu[x_tro1,i-1];
          kieu_dinh_dang[x_tro1,i]:=kieu_dinh_dang[x_tro1,i-1];
        end;
      gia_tri[x_tro1,y_tro1]:='';
      kieu[x_tro1,y_tro1]:=0;
      kieu_dinh_dang[x_tro1,y_tro1]:=2;
      for i:=x1 to x2 do
        for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
    end;
  (*- - - - - - -*)
  begin
    setlinestyle(0,1,1);
    getmem(bitmap,imagesize(218,189,422,292));
    getimage(218,189,422,292,bitmap^);
    setfillstyle(1,7);
    bar(320-100,240-50,320+100,240+50);
    setfillstyle(1,lightblue);
    bar(220,190,420,210);
    setcolor(7);
    rectangle(220,190,420,210);
    rectangle(221,191,419,209);
    setcolor(black);
    line(421,190,421,290);
    line(219,291,421,291);
    line(422,189,422,292);
    line(219,292,421,292);
    setcolor(white);
    line(219,190,219,290);
    line(219,190,420,190);
    line(218,189,218,291);
    line(219,189,421,189);

    setfillstyle(1,15);
    fillellipse(240,235,4,4);
    fillellipse(240,265,4,4);
    setcolor(7);
    circle(240,265,2);

    setcolor(15);
    outtextxy(320,235,'Shift cells down');
    outtextxy(324,265,'Shift cells right');
    outtextxy(260,200,'Insert');

    setlinestyle(1,1,1);
    setcolor(0);
    setfillstyle(1,0);
    rectangle(320-70,235-10,320+80,235+10);
    fillellipse(240,235,2,2);
    tro_cell:=1;
    repeat
      ch:=readkey;
      if ch=#0 then
        begin
          ch:=readkey;
          case ch of
            #72:up;
            #80:down;
          end;
        end;
    until (ch=#27) or (ch=#13);
    if ch=#13 then
      begin
        if tro_cell=1 then shift_down
        else shift_right;
      end;
    putimage(218,189,bitmap^,0);
    freemem(bitmap,imagesize(218,189,422,292));
  end;
(*-------------------------------------------------*)
procedure rows;
  var
    i,j:integer;
  begin
    for i:=50 downto x_tro1+1 do
      for j:=1 to 26 do
        begin
          gia_tri[i,j]:=gia_tri[i-1,j];
          kieu[i,j]:=kieu[i-1,j];
          kieu_dinh_dang[i,j]:=kieu_dinh_dang[i-1,j];
        end;
    for i:=1 to 26 do
      begin
        gia_tri[x_tro1,i]:='';
        kieu[x_tro1,i]:=0;
        kieu_dinh_dang[x_tro1,i]:=2;
      end;
    for i:=x1 to x2 do
      for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
  end;
(*-------------------------------------------------*)
procedure columns;
  var
    i,j:integer;
  begin
    for i:=26 downto y_tro1+1 do
      for j:=1 to 50 do
        begin
          gia_tri[j,i]:=gia_tri[j,i-1];
          kieu[j,i]:=kieu[j,i-1];
          kieu_dinh_dang[j,i]:=kieu_dinh_dang[j,i-1];
        end;
    for i:=1 to 50 do
      begin
        gia_tri[i,y_tro1]:='';
        kieu[i,y_tro1]:=0;
        kieu_dinh_dang[i,y_tro1]:=2;
      end;
    for i:=x1 to x2 do
      for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
  end;
(*-------------------------------------------------*)
procedure align_left;
  begin
    kieu_dinh_dang[x_tro1,y_tro1]:=0;
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*-------------------------------------------------*)
procedure center;
  begin
    kieu_dinh_dang[x_tro1,y_tro1]:=1;
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*-------------------------------------------------*)
procedure align_right;
  begin
    kieu_dinh_dang[x_tro1,y_tro1]:=2;
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
  end;
(*-------------------------------------------------*)

procedure menu_1;
  var
    ch:char;
    tro_mn,tro:byte;
  procedure left;
    begin
      setfillstyle(1,7);
      bar(tam_mn[tro_mn]-30,30-8,tam_mn[tro_mn]+30,30+10);
      setcolor(0);
      outtextxy(tam_mn[tro_mn],30,menu[tro_mn]);
      if tro_mn=1 then tro_mn:=6
      else dec(tro_mn);
      setfillstyle(1,green);
      bar(tam_mn[tro_mn]-30,30-8,tam_mn[tro_mn]+30,30+10);
      setcolor(0);
      outtextxy(tam_mn[tro_mn],30,menu[tro_mn]);
    end;
  (*- - - - - - -*)
  procedure right;
    begin
      setfillstyle(1,7);
      bar(tam_mn[tro_mn]-30,30-8,tam_mn[tro_mn]+30,30+10);
      setcolor(0);
      outtextxy(tam_mn[tro_mn],30,menu[tro_mn]);
      if tro_mn=6 then tro_mn:=1
      else inc(tro_mn);
      setfillstyle(1,green);
      bar(tam_mn[tro_mn]-30,30-8,tam_mn[tro_mn]+30,30+10);
      setcolor(0);
      outtextxy(tam_mn[tro_mn],30,menu[tro_mn]);
    end;
  (*- - - - - - -*)
  procedure file_1;
    const
      menu:array[1..4] of string[13]=('New        F4','Save       F2',
      'Open       F3','Exit   ALT+F4');
      dong:array[1..4] of byte=(60,80,100,120);
    var
      i:integer;
      ch:char;
    procedure up;
      begin
        setfillstyle(1,7);
        bar(tam_mn[1]-30,dong[tro]-10,tam_mn[1]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[1]-20,dong[tro],menu[tro]);
        if tro>1 then dec(tro)
        else tro:=4;
        setfillstyle(1,green);
        bar(tam_mn[1]-30,dong[tro]-10,tam_mn[1]+100,dong[tro]+10);

        setcolor(0);
        outtextxy(tam_mn[1]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    procedure down;
      begin
        setfillstyle(1,7);
        bar(tam_mn[1]-30,dong[tro]-10,tam_mn[1]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[1]-20,dong[tro],menu[tro]);
        if tro<4 then inc(tro)
        else tro:=1;
        setfillstyle(1,green);
        bar(tam_mn[1]-30,dong[tro]-10,tam_mn[1]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[1]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    begin
      getmem(bitmap,imagesize(tam_mn[1]-32,39,tam_mn[1]+102,142));
      getimage(tam_mn[1]-32,39,tam_mn[1]+102,142,bitmap^);
      setfillstyle(1,7);
      bar(tam_mn[1]-30,41,tam_mn[1]+100,140);

      setlinestyle(0,1,1);
      setcolor(0);
      line(tam_mn[1]+101,40,tam_mn[1]+101,141);
      line(tam_mn[1]+102,40,tam_mn[1]+102,142);

      line(tam_mn[1]-31,141,tam_mn[1]+101,141);
      line(tam_mn[1]-32,142,tam_mn[1]+102,142);

      setcolor(15);
      line(tam_mn[1]-31,40,tam_mn[1]-31,141);
      line(tam_mn[1]-32,40,tam_mn[1]-32,142);

      line(tam_mn[1]-31,40,tam_mn[1]+101,40);

      settextjustify(lefttext,centertext);
      setcolor(0);
      for i:=1 to 4 do outtextxy(tam_mn[1]-20,dong[i],menu[i]);
      tro:=1;
      setfillstyle(1,green);
      bar(tam_mn[1]-30,dong[1]-10,tam_mn[1]+100,dong[1]+10);
      setcolor(0);
      outtextxy(tam_mn[1]-20,dong[1],menu[1]);
      repeat
        ch:=readkey;
        if ch=#0 then
          begin
            ch:=readkey;
            case ch of
              #72: up;
              #80: down;
            end;
          end;
        if ch=#13 then
          begin
            putimage(tam_mn[1]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[1]-32,39,tam_mn[1]+102,142));
          end;
        if ch=#27 then
          begin
            tro:=0;
            putimage(tam_mn[1]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[1]-32,39,tam_mn[1]+102,142));
          end;
      until (ch=#27) or (ch=#13);

    end;
  (*- - - - - - -*)
  procedure edit;
    const
      menu:array[5..7] of string[13]=('Copy    ALT+C','Cut     ALT+X',
      'Paste   ALT+V');
      dong:array[5..7] of byte=(60,80,100);
    var
      i:integer;
      ch:char;
    procedure up;
      begin
        setfillstyle(1,7);
        bar(tam_mn[2]-30,dong[tro]-10,tam_mn[2]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[2]-20,dong[tro],menu[tro]);
        if tro=5 then tro:=7
        else dec(tro);
        setfillstyle(1,green);
        bar(tam_mn[2]-30,dong[tro]-10,tam_mn[2]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[2]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    procedure down;
      begin
        setfillstyle(1,7);
        bar(tam_mn[2]-30,dong[tro]-10,tam_mn[2]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[2]-20,dong[tro],menu[tro]);
        if tro=7 then tro:=5
        else inc(tro);
        setfillstyle(1,green);
        bar(tam_mn[2]-30,dong[tro]-10,tam_mn[2]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[2]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    begin
      getmem(bitmap,imagesize(tam_mn[2]-32,39,tam_mn[2]+102,122));
      getimage(tam_mn[2]-32,39,tam_mn[2]+102,122,bitmap^);
      setfillstyle(1,7);
      bar(tam_mn[2]-30,41,tam_mn[2]+100,120);

      setlinestyle(0,1,1);
      setcolor(0);
      line(tam_mn[2]+101,40,tam_mn[2]+101,121);
      line(tam_mn[2]+102,40,tam_mn[2]+102,122);

      line(tam_mn[2]-31,121,tam_mn[2]+101,121);
      line(tam_mn[2]-32,122,tam_mn[2]+102,122);

      setcolor(15);
      line(tam_mn[2]-31,40,tam_mn[2]-31,121);
      line(tam_mn[2]-32,40,tam_mn[2]-32,122);

      line(tam_mn[2]-31,40,tam_mn[2]+101,40);

      settextjustify(lefttext,centertext);
      setcolor(0);
      for i:=5 to 7 do outtextxy(tam_mn[2]-20,dong[i],menu[i]);
      tro:=5;
      setfillstyle(1,green);
      bar(tam_mn[2]-30,dong[tro]-10,tam_mn[2]+100,dong[tro]+10);
      setcolor(0);
      outtextxy(tam_mn[2]-20,dong[tro],menu[tro]);
      repeat
        ch:=readkey;
        if ch=#0 then
          begin
            ch:=readkey;
            case ch of
              #72: up;
              #80: down;
            end;
          end;
        if ch=#13 then
          begin
            putimage(tam_mn[2]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[2]-32,39,tam_mn[2]+102,122));
          end;
        if ch=#27 then
          begin
            tro:=0;
            putimage(tam_mn[2]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[2]-32,39,tam_mn[2]+102,122));
          end;
      until (ch=#27) or (ch=#13);
    end;
  (*- - - - - - -*)
  procedure insert;
    const
      menu:array[8..10] of string[13]=('Cell         ','Rows         ',
      'Columns      ');
      dong:array[8..10] of byte=(60,80,100);
    var
      i:integer;
      ch:char;
    procedure up;
      begin
        setfillstyle(1,7);
        bar(tam_mn[3]-30,dong[tro]-10,tam_mn[3]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[3]-20,dong[tro],menu[tro]);
        if tro=8 then tro:=10
        else dec(tro);
        setfillstyle(1,green);
        bar(tam_mn[3]-30,dong[tro]-10,tam_mn[3]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[3]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    procedure down;
      begin
        setfillstyle(1,7);
        bar(tam_mn[3]-30,dong[tro]-10,tam_mn[3]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[3]-20,dong[tro],menu[tro]);
        if tro=10 then tro:=8
        else inc(tro);
        setfillstyle(1,green);
        bar(tam_mn[3]-30,dong[tro]-10,tam_mn[3]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[3]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    begin
      getmem(bitmap,imagesize(tam_mn[3]-32,39,tam_mn[3]+102,122));
      getimage(tam_mn[3]-32,39,tam_mn[3]+102,122,bitmap^);
      setfillstyle(1,7);
      bar(tam_mn[3]-30,41,tam_mn[3]+100,120);

      setlinestyle(0,1,1);
      setcolor(0);
      line(tam_mn[3]+101,40,tam_mn[3]+101,121);
      line(tam_mn[3]+102,40,tam_mn[3]+102,122);

      line(tam_mn[3]-31,121,tam_mn[3]+101,121);
      line(tam_mn[3]-32,122,tam_mn[3]+102,122);

      setcolor(15);
      line(tam_mn[3]-31,40,tam_mn[3]-31,121);
      line(tam_mn[3]-32,40,tam_mn[3]-32,122);

      line(tam_mn[3]-31,40,tam_mn[3]+101,40);

      settextjustify(lefttext,centertext);
      setcolor(0);
      for i:=8 to 10 do outtextxy(tam_mn[3]-20,dong[i],menu[i]);
      tro:=8;
      setfillstyle(1,green);
      bar(tam_mn[3]-30,dong[tro]-10,tam_mn[3]+100,dong[tro]+10);
      setcolor(0);
      outtextxy(tam_mn[3]-20,dong[tro],menu[tro]);
      repeat
        ch:=readkey;
        if ch=#0 then
          begin
            ch:=readkey;
            case ch of
              #72: up;
              #80: down;
            end;
          end;
        if ch=#13 then
          begin
            putimage(tam_mn[3]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[3]-32,39,tam_mn[3]+102,122));
          end;
        if ch=#27 then
          begin
            tro:=0;
            putimage(tam_mn[3]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[3]-32,39,tam_mn[3]+102,122));
          end;
      until (ch=#27) or (ch=#13);
    end;
  (*- - - - - - -*)
  procedure format;
    const
      menu:array[11..13] of string[13]=('Align Left   ','Center       ',
      'Align Right  ');
      dong:array[11..13] of byte=(60,80,100);
    var
      i:integer;
      ch:char;
    procedure up;
      begin
        setfillstyle(1,7);
        bar(tam_mn[4]-30,dong[tro]-10,tam_mn[4]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[4]-20,dong[tro],menu[tro]);
        if tro=11 then tro:=13
        else dec(tro);
        setfillstyle(1,green);
        bar(tam_mn[4]-30,dong[tro]-10,tam_mn[4]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[4]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    procedure down;
      begin
        setfillstyle(1,7);
        bar(tam_mn[4]-30,dong[tro]-10,tam_mn[4]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[4]-20,dong[tro],menu[tro]);
        if tro=13 then tro:=11
        else inc(tro);
        setfillstyle(1,green);
        bar(tam_mn[4]-30,dong[tro]-10,tam_mn[4]+100,dong[tro]+10);
        setcolor(0);
        outtextxy(tam_mn[4]-20,dong[tro],menu[tro]);
      end;
    (*- - - - - -*)
    begin
      getmem(bitmap,imagesize(tam_mn[4]-32,39,tam_mn[4]+102,122));
      getimage(tam_mn[4]-32,39,tam_mn[4]+102,122,bitmap^);
      setfillstyle(1,7);
      bar(tam_mn[4]-30,41,tam_mn[4]+100,120);

      setlinestyle(0,1,1);
      setcolor(0);
      line(tam_mn[4]+101,40,tam_mn[4]+101,121);
      line(tam_mn[4]+102,40,tam_mn[4]+102,122);

      line(tam_mn[4]-31,121,tam_mn[4]+101,121);
      line(tam_mn[4]-32,122,tam_mn[4]+102,122);

      setcolor(15);
      line(tam_mn[4]-31,40,tam_mn[4]-31,121);
      line(tam_mn[4]-32,40,tam_mn[4]-32,122);

      line(tam_mn[4]-31,40,tam_mn[4]+101,40);

      settextjustify(lefttext,centertext);
      setcolor(0);
      for i:=11 to 13 do outtextxy(tam_mn[4]-20,dong[i],menu[i]);
      tro:=11;
      setfillstyle(1,green);
      bar(tam_mn[4]-30,dong[tro]-10,tam_mn[4]+100,dong[tro]+10);
      setcolor(0);
      outtextxy(tam_mn[4]-20,dong[tro],menu[tro]);
      repeat
        ch:=readkey;
        if ch=#0 then
          begin
            ch:=readkey;
            case ch of
              #72: up;
              #80: down;
            end;
          end;
        if ch=#13 then
          begin
            putimage(tam_mn[4]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[4]-32,39,tam_mn[4]+102,122));
          end;
        if ch=#27 then
          begin
            tro:=0;
            putimage(tam_mn[4]-32,39,bitmap^,0);
            freemem(bitmap,imagesize(tam_mn[4]-32,39,tam_mn[4]+102,122));
          end;
      until (ch=#27) or (ch=#13);
    end;
  (*- - - - - - -*)
  procedure data;
    begin
    end;
  (*- - - - - - -*)
  procedure help;
    begin
    end;
  begin
    settextjustify(centertext,centertext);
    setfillstyle(1,green);
    bar(tam_mn[1]-30,30-8,tam_mn[1]+30,30+10);
    setcolor(0);
    outtextxy(tam_mn[1],30,menu[1]);
    tro_mn:=1;
    tro:=0;
    repeat
      ch:=readkey;
      if ch=#13 then
        begin
          case tro_mn of
            1: file_1;
            2: edit;
            3: insert;
            4: format;
            5: data;
            6: help;
          end;
        end
      else
        if ch=#0 then
          begin
            ch:=readkey;
            case ch of
              #75:left;
              #77:right;
            end;
          end;
      settextjustify(centertext,centertext);
    until (ch=#27) or (tro<>0);
    setfillstyle(1,7);
    bar(tam_mn[tro_mn]-30,30-8,tam_mn[tro_mn]+30,30+10);
    setcolor(0);
    outtextxy(tam_mn[tro_mn],30,menu[tro_mn]);
    case tro of
      1:new_1;
      2:save;
      3:open;
      4:quit;
      5:copy_1;
      6:cut;
      7:paste;
      8:cell;
      9:rows;
      10:columns;
      11:align_left;
      12:center;
      13:align_right;
    end;
  end;
(*----------------------------------------------------*)
procedure delete_block;
  var
    i,j:integer;
  begin
    if dd then
      begin
        for i:=dia_chi_1.dong to dia_chi_2.dong do
          for j:=dia_chi_1.cot to dia_chi_2.cot do
            begin
              kieu[i,j]:=0;
              kieu_dinh_dang[i,j]:=2;
              gia_tri[i,j]:='';
            end;
         for i:=x1 to x2 do
           for j:=y1 to y2 do hien_thi(i-x1+1,j-y1+1,i,j);
         dd:=false;
       end;
  end;
(*----------------------------------------------------*)

procedure marke;
  var
    ch:char;
  procedure insert;
    var
      i,j:integer;
      ch:char;
    begin
      dd:=true;
      setfillstyle(1,0);
      bar(yt[y_tro]-25,xt[x_tro]-5,yt[y_tro]+25,xt[x_tro]+5);
      delay(500);
      setfillstyle(1,1);
      bar(yt[y_tro]-25,xt[x_tro]-5,yt[y_tro]+25,xt[x_tro]+5);
      hien_thi(x_tro,y_tro,x_tro1,y_tro1);

      dia_chi_2.dong:=x_tro1;
      dia_chi_2.cot:=y_tro1;
      if dia_chi_1.dong>dia_chi_1.dong then trao(dia_chi_1.dong,dia_chi_2.dong);
      if dia_chi_1.cot>dia_chi_2.cot then trao(dia_chi_1.cot,dia_chi_2.cot);
      ch:=readkey;
      if ch=#0 then
        begin
          ch:=readkey;
          case ch of
            #46: copy_1;
            #45: cut;
            #83: delete_block;
            #68: menu_1;
            else exit;
          end;
        end
      else exit;
    end;
  (*- - - - - - - -*)
  begin
    dia_chi_1.dong:=x_tro1;
    dia_chi_1.cot:=y_tro1;
    setfillstyle(1,0);
    bar(yt[y_tro]-25,xt[x_tro]-5,yt[y_tro]+25,xt[x_tro]+5);
    delay(500);
    setfillstyle(1,1);
    bar(yt[y_tro]-25,xt[x_tro]-5,yt[y_tro]+25,xt[x_tro]+5);
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
    repeat
      ch:=readkey;
      if ch=#0 then
        begin
          ch:=readkey;
          case ch of
            #82:
              begin
                insert;
                exit;
              end;
            #75: left;
            #77: right;
            #72: up;
            #80: down;
          else exit;
        end;
      end
      else exit;
    until false;
  end;
(*----------------------------------------------------*)
procedure enter;
  begin
    if s<>'' then tinh_gia_tri;
    down;
  end;
(*----------------------------------------------------*)
procedure delete;
  begin
    gia_tri[x_tro1,y_tro1]:='';
    kieu[x_tro1,y_tro1]:=0;
    kieu_dinh_dang[x_tro1,y_tro1]:=2;
    hien_thi(x_tro,y_tro,x_tro1,y_tro1);
    s:='';
  end;
procedure escape;
  begin
    s:='';
    setfillstyle(1,1);
    bar(150,42,630,60);
    bar(yt[y_tro]-26,xt[x_tro]-6,yt[y_tro]+26,xt[x_tro]+6);
    gia_tri[x_tro1,y_tro1]:='';
    kieu[x_tro1,y_tro1]:=0;
  end;
(*----------------------------------------------------*)
procedure xu_ly_kt;
  var
    s1:string;
  begin
    setfillstyle(1,1);
    bar(150,42,630,60);
    if ch=#8 then
      begin
        if length(s)>0 then s[0]:=chr(ord(s[0])-1)
      end
    else s:=s+ch;
    setcolor(14);
    settextjustify(lefttext,centertext);
    outtextxy(160,50,s);

    bar(yt[y_tro]-26,xt[x_tro]-6,yt[y_tro]+26,xt[x_tro]+6);
    s1:=copy(s,1,5);
    outtextxy(yt[y_tro]-18,xt[x_tro],s1);
    settextjustify(centertext,centertext);
  end;
(*----------------------------------------------------*)
procedure logo;
  const pause=150;
  var
    x,y:integer;
    ch:char;
    ErrorCode:Integer;
    MaxColor:word;
  begin
    x:=getmaxx div 2;
    y:=getmaxy div 2;
    setbkcolor(1);
    setcolor(14);
    settextstyle(2,0,5);
    outtextxy(x-235,y-30,'D');
    delay(pause);
    outtextxy(x-210,y-30,'A');
    delay(pause);
    outtextxy(x-185,y-30,'T');
    delay(pause);
    outtextxy(x-160,y-30,'A');
    delay(pause);
    outtextxy(x-135,y-30,'B');
    delay(pause);
    outtextxy(x-105,y-30,'A');
    delay(pause);
    outtextxy(x-80,y-30,'S');
    delay(pause);
    outtextxy(x-55,y-30,'E');
    delay(pause);
    outtextxy(x-15,y-30,'F');
    delay(pause);
    outtextxy(x+10,y-30,'O');
    delay(pause);
    outtextxy(x+35,y-30,'R');
    delay(pause);
    outtextxy(x+75,y-30,'F');
    delay(pause);
    outtextxy(x+100,y-30,'U');
    delay(pause);
    outtextxy(x+125,y-30,'T');
    delay(pause);
    outtextxy(x+150,y-30,'U');
    delay(pause);
    outtextxy(x+175,y-30,'R');
    delay(pause);
    outtextxy(x+200,y-30,'E');
    delay(1000);
    cleardevice;
    settextstyle(1,0,5);
    settextjustify(centertext,centertext);
    setcolor(14);
    outtextxy(x,60,' DATABASE  FOR  FUTURE');
    settextjustify(lefttext,centertext);
    settextstyle(1,0,3);
    setusercharsize(2,1,2,1);
    settextstyle(7,0,3);
    outtextxy(x-100,y-140,'D   .   B   .   F');
    settextstyle(3,0,4);
    settextjustify(centertext,centertext);
    outtextxy(x,y,'EASY TO USE');
    settextstyle(2,0,6);
    outtextxy(x,y+100,'Copyright C 2000 by Nguyen Quoc Hiep');
    circle(x-77,y+103,10);
    outtextxy(x,y+130,'Version 1.0');
    outtextxy(x,y+160,'Press any key to continue...');
    ch:=readkey;
end;
begin
  th_dau:=['+','-','*','/'];
  th_so:=['0'..'9'];
  start:=true;
  dd:=false;
  new(clip_board);
  cl_board:=false;
  clrscr;(*Xoa man hinh*)
  gd:=detect;(*Khoi tao graph dirver*)
  initgraph(gd,gm,'c:\l_ptr_~2\pascal\bgi');
  {logo;}
  setbkcolor(0);
  settextstyle(0,0,1);
  new_1;
  start:=false;
  s:='';(*Khoi tao xau chua du lieu nhap vao*)
  repeat
    ch:=readkey;(*Nhap lenh cua nguoi su dung*)
    if ch=#0 then (*Xu ly cac phim chuc nang*)
      begin
        ch:=readkey;
        case ch of
          {Neu }
          #59: help;
          #60: save;
          #61: open;
          #62: new_1;
          #68: menu_1;
          #72: up;
          #80: down;
          #75: left;
          #77: right;
          #107: quit;
          #82: marke;
          #83: delete;
          #47: paste;
        end;
      end
    else (*Xu ly cac phim du lieu*)
      if ch=#13 then enter (*Xu ly phim enter*)
      else
        if ch=#27 then escape (*Xu ly phim ESC*)
        else xu_ly_kt; (*Xu ly du lieu nhap vao la cac phim ky tu*)
  until false;
  dispose(clip_board);
end.
1: logic;
2: ngay, thang;
3: so;
4: chuoi;