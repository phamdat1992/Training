uses crt, graph;
const
  maxdiem = 101;
  eps = 1e-6;
  dapan: array['0'..'9'] of real =
         (1.5, 0.5, 2.5, 1.0, 5.5, 12.5, 36.0, 29.0, 0.5, 1.5);
type
  kieudiem = record
               x, y: real;
             end;
  mangdiem = array[1..maxdiem] of kieudiem;
  daydiem  = record
               sodiem: integer;
               diem  : mangdiem;
             end;
var S, T: daydiem;
    ch: char;
    f: text;
    ii, jj: integer;

  function Phia(var A, B, C: kieudiem): integer;
  { tra lai 0 neu C thuoc duong thang AB,
            1 neu C thuoc mot phia cua AB,
           -1 neu C thuoc phia kia cua AB }
  var g: real;
  begin
    g := (A.y-B.y)*(C.x-A.x)+(B.x-A.x)*(C.y-A.y);
    if abs(g) < eps then Phia := 0
    else if g > 0 then Phia := 1
         else Phia := -1;
  end;

  function ViTri(var A, B, C: kieudiem): integer;
  { tra lai 2 neu C khong thuoc duong thang AB,
            0 neu C nam trong doan AB,
            1 neu C nam ve phia B cua doan AB,
           -1 neu C nam ve phia A cua doan AB }
  var t, tu, mau: real;
  begin
    if Phia(A, B, C) <> 0 then
      ViTri := 2
    else
    begin
      tu := C.x-A.x; mau := B.x-A.x;
      if abs(mau) < abs(B.y-A.y) then
      begin
        tu := C.y-A.y; mau := B.y-A.y;
      end;
      t := tu/mau;
      if t > 1 then ViTri := 1
      else if t < 0 then ViTri := -1
           else ViTri := 0;
    end;
  end;

  function KhongCat(var A, B, C, D: kieudiem): boolean;
  { kiem tra doan AB co cat doan CD hay khong? }
  begin
    KhongCat := (Phia(A, B, C)*Phia(A, B, D)=1) or
                (Phia(C, D, A)*Phia(C, D, B)=1) or
                (ViTri(A, B, C)*ViTri(A, B, D)=1);
  end;

  function Xet(i, j: integer): boolean;
  var k, kk: integer;
  begin
    with s do
    begin
      if (i = 1) and (j = sodiem) then
      begin
        Xet := false; exit;
      end;
      for k := 1 to sodiem do
      begin
        kk := k+1; kk := (k mod sodiem)+1;
        if not ((i = k) or (i = kk) or (j = k) or (j = kk) or
           KhongCat(diem[i], diem[j], diem[k], diem[kk])) then
        begin
          Xet := false; exit;
        end;
      end;
    end;
    Xet := true;
  end;

 function DienTich(var S: daydiem): real;
  var i: integer;
      dt: real;
  begin
    with S do
    begin
      dt := (diem[sodiem].y+diem[1].y)/2*(diem[1].x-diem[sodiem].x);
      for i := 1 to sodiem-1 do
        dt := dt+(diem[i].y+diem[i+1].y)/2*(diem[i+1].x-diem[i].x);
    end;
    DienTich := abs(dt);
  end;

  procedure ReadData;
  var i: integer;
      name: string;
  begin
    name := 'c:\data\hung\quocgia\test\2000\Testpoly\POLY.IN';
    write('File du lieu: ', name);
    ch := readkey; writeln(ch);
    name := name+ch;
    assign(f, name); reset(f);
    with S do
    begin
      readln(f, sodiem);
      for i := 1 to sodiem do readln(f, diem[i].x, diem[i].y);
    end;
    close(f);
  end;

  procedure ReadResult;
  var i: integer;
  begin
    assign(f, 'C:\Data\Hung\QuocGia\2000\BangB\Bai4.Out');
    reset(f);
    readln(f, ii, jj);
    close(f);
    if ii > jj then
    begin
      i := ii;
      ii := jj;
      jj := i;
    end;
  end;

  procedure Test;
  var
    i, k, cmin, cmax, dmin, dmax, c, d, c1, d1: integer;
    xmin, xmax, ymin, ymax, p, q, u, v: real;
    intst, mess: string;
    poly: array[1..maxdiem] of pointtype;
    dt, dt1, dt2, lech, kq: real;

    procedure InitG;
    var grd, grm: integer;
    begin
      grd := detect;
      InitGraph(grd, grm, 'C:\laptrinh\pascal\bgi');
      cmin := 100; cmax := getmaxx-10;
      dmin :=  80; dmax := getmaxy-10;
      SetTextJustify(centertext, centertext);
    end;

    procedure TinhMinMax;
    var i: integer;
        u, v: real;
    begin
      xmin := 1e+37; xmax := -xmin;
      ymin := xmin; ymax := xmax;
      with S do
      for i := 1 to sodiem do
      begin
        u := diem[i].x; v := diem[i].y;
        if u < xmin then xmin := u;
        if v < ymin then ymin := v;
        if u > xmax then xmax := u;
        if v > ymax then ymax := v;
      end;
    end;

  begin
    InitG; TinhMinMax;
    p := (cmax-cmin)/(xmax-xmin);
    q := (dmin-dmax)/(ymax-ymin);

    { ---- ve da giac S ---- }
    with S do
    begin
      for i := 1 to sodiem do
      begin
        poly[i].x := round(p*(diem[i].x-xmin)+cmin);
        poly[i].y := round(q*(diem[i].y-ymin)+dmax);
      end;
    end;
    { to mien trong da giac S }
    setfillstyle(1, cyan);
    fillpoly(S.sodiem, poly);

    { ---- ve day diem S ---- }
    setfillstyle(solidfill, white);
    settextstyle(smallfont, horizdir, 4);
    with S do
    for i := 1 to sodiem do
    begin
      c := round(p*(diem[i].x-xmin)+cmin);
      d := round(q*(diem[i].y-ymin)+dmax);
      fillellipse(c, d, 7, 7);
      setcolor(0);
      str(i, intst); OutTextXY(c, d, intst);
      setcolor(white);
    end;
    settextstyle(smallfont, horizdir, 6);
    dt := DienTich(S);
    str(dt:1:1, intst);
    OutTextXY((cmin+cmax) div 2, (dmin+dmax)
     div 2, 'Dien tich: '+intst);
    gotoxy(1, 1); write('vach chia  : ', ii, ', ', jj);
    gotoxy(32, 1); write('Test ', ch);
    if (ii < 1) or (ii > S.sodiem) or (jj < 1) or (jj > S.sodiem) then
    begin
      gotoxy(1, 2);
      write('chi so vach chia sai');
      mess := 'Error'; kq := 0.0;
    end else
  begin
    if not Xet(ii, jj) then
    begin
      gotoxy(1, 2);
      write('vach chia cat bien');
      mess := 'Error'; kq := 0.0;
    end else
    begin
      {xet hinh i, i+1, ..., j}
      T.sodiem := jj-ii+1;
      for k := 1 to jj-ii+1 do
        T.diem[k] := S.diem[k-1+ii];
      dt1 := DienTich(T);
      if dt1 >= dt then
      begin
        gotoxy(1, 2);
        write('vach chia nam ngoai');
        mess := 'Error'; kq := 0.0;
      end else
      begin
        {xet hinh i, j, j+1, ..., n, 1, ..., i-1}
        T.sodiem := S.sodiem-jj+ii+1;
        T.diem[1] := S.diem[ii];
        for k := 2 to S.sodiem-jj+2 do
          T.diem[k] := S.diem[k-2+jj];
        for k := S.sodiem-jj+3 to S.sodiem-jj+ii+1 do
          T.diem[k] := S.diem[k-S.sodiem+jj-2];
        dt2 := DienTich(T);
        if dt2 >= dt then
        begin
          gotoxy(1, 2);
          write('vach chia nam ngoai');
          mess := 'Error'; kq := 0.0;
        end else
        begin
          lech := abs(dt1-dt2);
          gotoxy(1, 2); write('dien tich 1: ', dt1:6:1);
          gotoxy(1, 3); write('dien tich 2: ', dt2:6:1);
          gotoxy(1, 4); write('do lech    : ', lech:6:1);
          if lech > dapan[ch] then
          begin
            str(dapan[ch]:1:1, mess);
            mess := 'Chua toi uu (dap an '+mess+')'; kq := 0.0;
            if ch > '5' then kq := 0.5;
          end else
          begin
            mess := 'OK'; kq := 1.0;
          end;
        end;
      end;
    end;
    with s do
    begin
      c := round(p*(diem[ii].x-xmin)+cmin);
      d := round(q*(diem[ii].y-ymin)+dmax);
      c1 := round(p*(diem[jj].x-xmin)+cmin);
      d1 := round(q*(diem[jj].y-ymin)+dmax);
    end;
    SetColor(LightRed);
    Line(c, d, c1, d1);
    SetColor(white);
  end;
    gotoxy(40, 1); write(mess);
    gotoxy(70, 1); write('Diem: ', kq:1:1);
    ch := readkey;
    CloseGraph;
  end;

BEGIN
  ClrScr;
  writeln('           Chuong trinh TEST bai CHIA DAT (bai 4, Bang B, nam 2000)');
  writeln;
  ReadData;
  ReadResult;
  DirectVideo := false;
  Test;
END.