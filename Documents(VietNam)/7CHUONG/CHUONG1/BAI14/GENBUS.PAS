{sinh du lieu ngau nhien cho BUSWAYS}
uses crt;
const
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

  procedure Nhap;
  var
      i, j, np, nn, dodai: byte;
      p, q: array[1..52] of byte;
      s: sttuyen;

    function NgauNhien(n: byte): string;
    var
      s: string;
      i, j: byte;
    begin
      np := nn;
      for i := 1 to np do p[i] := i;
      s := '';
      for i := 1 to n do
      begin
        j := 1+random(np);
        s := s+chr(q[p[j]]);
        p[j] := p[np]; dec(np);
      end;
      NgauNhien := s;
    end;

  begin  {Nhap}
    clrscr;
    randomize;
    for i := 1 to 26 do q[i] := 64+i;
    for i := 27 to 52 do q[i] := 70+i;
    write('So tuyen: '); readln(ntuyen);
    if ntuyen < 10 then nn := 26 else nn := 52;
    nga := 0;
    for i := 1 to ntuyen do
    begin
      dodai := 4+random(6);
      s := NgauNhien(dodai);
      for j := 1 to length(s) do
      begin
        inc(nga); ga[nga] :=j; tuyen[nga] := i;
      end;
      ten[i] := s;
      writeln(s);
    end;
    writeln('====================================');
  end;  {Nhap}

  procedure TimHanhTrinh(dau, cuoi: char);
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
    var s: string;
        i, dem, l: word;
        x, ch: char;
    begin
      if b^[p] >= vocung then
      begin
        writeln('Khong di duoc tu ', dau, ' den ', cuoi); exit;
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
      writeln(s, ' (chuyen tuyen ', dem, ' so ga ', l, ')');
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
  var dau, cuoi, chon: char;
      td, tc, gd, gc, i: byte;

    function Ok: boolean;
    var i: byte;
    begin
      for i := 1 to ntuyen do
      if (Pos(dau, ten[i]) > 0) and (Pos(cuoi, ten[i]) > 0) then
      begin
        OK := false; exit;
      end;
      OK := true;
    end;

  begin
    new(a); new(b);
    nbai := 0;
    repeat
      td := 1+random(ntuyen);
      gd := 1+random(length(ten[td]));
      dau := ten[td][gd];
      repeat
        tc := 1+random(ntuyen);
        gc := 1+random(length(ten[tc]));
        cuoi := ten[tc][gc];
      until (random < 0.2) or OK;
      TimHanhTrinh(dau, cuoi);
      repeat
        write('chon / bo qua / ket thuc: ');
        chon := readkey; writeln(chon);
      until chon in ['c', 'b', 'k'];
      writeln('====================================');
      if chon = 'c' then
      begin
        inc(nbai); bai[nbai] := dau+cuoi;
      end;
    until chon = 'k';
    write('Ghi len file: '); readln(fn);
    if fn <> '' then
    begin
      assign(f, fn); rewrite(f);
      writeln(f, ntuyen);
      for i := 1 to ntuyen do writeln(f, ten[i]);
      writeln(f, nbai);
      for i := 1 to nbai do writeln(f, bai[i]);
      close(f);
    end;
  end;

BEGIN
  Nhap; XuLy;
END.



