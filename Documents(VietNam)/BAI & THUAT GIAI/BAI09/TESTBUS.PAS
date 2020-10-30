{test bai BUSWAYS.DOC}
{dl : bus1.
kq  : bus}
uses crt ;
const
  kq1     =      'busway.out';
  maxga1 = 50;
  maxtuyen = 100;
  maxga = maxga1*maxtuyen;
  trongsoga = 1;
  trongsotuyen = maxga+1;
  vocung = 1000000000;

type
  sttuyen = string[maxga1+1];
  st2 = string[2];
  arra = array[1..maxga] of word;
  arrb = array[1..maxga] of longint;
var
  ten: array[1..maxtuyen] of sttuyen;
  ga, tuyen: array[1..maxga] of byte;
  bai: array[1..maxtuyen] of st2;
  ntuyen, nbai: byte;
  nga: word;
  a: ^arra;
  b: ^arrb;
  f: text;
  fn: string;
  X:CHAR ;

  procedure Nhap;
  var s: string;
      i, j: byte;
  begin
       clrscr;
    write('Doc file du lieu: ');
    FN:='BUS';
    readln(X);
    FN:=FN+X;
    if fn = '' then fn := 'BUS1';
    assign(f, fn); reset(f);
    readln(f, ntuyen);
    nga := 0;
    for i := 1 to ntuyen do
    begin
      readln(f, s); ten[i] := s;
      for j := 1 to length(s) do
      begin
        inc(nga); ga[nga] :=j; tuyen[nga] := i;
      end;
    end;
    readln(f, nbai);
    for i := 1 to nbai do readln(f, bai[i]);
    close(f);
    writeln(ntuyen);
    for i := 1 to ntuyen do writeln(ten[i]);
    writeln(nbai);
    for i := 1 to nbai do writeln(bai[i]);
    writeln('====================================');
    new(a); new(b);
  end;

  procedure TestHanhTrinh(dau, cuoi: char; kq: string);
  var
     u: arra;
     nu: word;
     p: word;

    procedure KhoiTao;
    var i, j, k: word;
    begin
      {gan nhan}
      for i := 1 to nga do
      begin
        a^[i] := 0; b^[i] := vocung;
      end;
      {gan nhan cho dinh dau va xac dinh tap U}
      for i := 1 to nga do
      begin
        j := ga[i]; k := tuyen[i];
        if ten[k][j] = dau then b^[i] := 1;
      end;
      nu := nga;
      for i := 1 to nu do u[i] := i;
    end;

    procedure CoDinh;
    var i, j: word;
    begin
      j := 1;
      for i := 2 to nu do
        if b^[u[i]] < b^[u[j]] then j := i;
      p := u[j];  {dinh duoc co dinh}
      u[j] := u[nu]; dec(nu); {loai p ra khoi U}
    end;

    procedure SuaNhan;
    var i, x: word;
        g, t: byte;
        ch: char;
    begin
      g := ga[p]; t := tuyen[p];
      if g > 1 then
      begin
        x := p-1;
        if b^[x] > b^[p]+trongsoga then
        begin
          a^[x] := p;
          b^[x] := b^[p]+trongsoga;
        end;
      end;
      if g < length(ten[t]) then
      begin
        x := p+1;
        if b^[x] > b^[p]+trongsoga then
        begin
          a^[x] := p;
          b^[x] := b^[p]+trongsoga;
        end;
      end;
      ch := ten[t][g];
      for i := 1 to nu do
      begin
        x := u[i];
        if ten[tuyen[x]][ga[x]] = ch then
        if b^[x] > b^[p]+trongsotuyen then
        begin
          a^[x] := p;
          b^[x] := b^[p]+trongsotuyen;
        end;
      end;
    end;

    procedure KetQua;
    var s, t, tt: string;
        i, j, dem, l, ls, lkq, err, u, soct, soga, lt: word;
        x, ch: char;
    begin
      if b^[p] >= vocung then
      begin
        writeln(f, 'Khong di duoc tu ', dau, ' den ', cuoi); exit;
      end;
      s := ''; i := p; dem := 0; l := 0;
      ch := #0;
      while i <> 0 do
      begin
        x := ten[tuyen[i]][ga[i]];
        if x = ch then
        begin
          inc(dem); s := ch+' '+s;
        end else
        begin
          ch := x; inc(l);
          s := ch+s;
        end;
        i := a^[i];
      end;
      writeln(s);
      ls := length(s);
      lkq := length(kq);
      {phan tich kq}
      writeln(kq);
      err := 0;
      if (kq[1] <> s[1]) or (kq[lkq] <> s[ls]) then err := 1
      else
      begin
        i := 1; ch := #0; soct := 0;
        while (i <= lkq) do
        begin
          t := '';
          while (i <= lkq) and (kq[i] <> ' ') do
          begin
            t := t+kq[i]; inc(i);
          end;
          if (ch <> #0) then
          begin
            if ch <> t[1] then
            begin
              err := 2; break;
            end;
          end;
          lt := length(t);
          ch := t[lt];
          tt := '';
          for j := 1 to lt do
            tt := tt+t[lt-j+1];
          u := 0;
          for j := 1 to ntuyen do
            if (Pos(t, ten[j]) > 0) or (Pos(tt, ten[j]) > 0) then
            begin
              u := 1; break;
            end;
          if u = 0 then
          begin
            err := 3; break;
          end;
          inc(soct);
          inc(i);
        end;
        dec(soct);
        if err = 0 then
          if soct > dem then err := 4
          else
          begin
            soga := lkq-(2*soct);
            if soga > l then err := 5;
          end;

      end;
      write('--> ');
      case err of
        0: writeln('Ok');
        1: writeln('Error 1: sai ga dau, ga cuoi');
        2: writeln('Error 2: ga cuoi chang truoc khong trung voi ga dau chang sau');
        3: writeln('Error 3: chang ', t, ' khong thuoc tuyen nao');
        4: writeln('Error 4: khong toi uu so lan chuyen tuyen');
        5: writeln('Error 5: khong toi uu so ga');
      end;
    end;

  begin  {TimHanhTrinh}
    KhoiTao; CoDinh;
    while ten[tuyen[p]][ga[p]] <> cuoi do
    begin
      SuaNhan; CoDinh;
    end;
    KetQua;
  end;

  procedure XuLy;
  var i: word;
      kq: string;
  begin
    writeln('Ten file ket qua:  BUSWAY.OUT ' ); FN:= kq1;{'BUSWAY.OUT';}
    if fn <> '' then
    begin
      assign(f, fn); reset(f);
      for i := 1 to nbai do
      begin
        readln(f, kq);
        TestHanhTrinh(bai[i][1], bai[i][2], kq);
      end;
      close(f);
    end;
    write('Go Enter de ket thuc ... '); readln;
  end;

BEGIN
  Nhap;
  XuLy;
END.
