{loi giai bai BUSWAYS.DOC}
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
  var s: string;
      i, j: byte;
  begin
    write('Doc file du lieu: ');
    readln(fn);
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
      writeln(f, s);
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
  begin
    write('Ghi ket qua len file: '); readln(fn);
    if fn = '' then fn := 'CON';
    assign(f, fn); rewrite(f);
    for i := 1 to nbai do TimHanhTrinh(bai[i][1], bai[i][2]);
    close(f);
    write('Go Enter de ket thuc ... '); readln;
  end;

BEGIN
  Nhap; XuLy;
END.



