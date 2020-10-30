{$A+,B-,D+,E+,F-,G-,I-,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
{
  Teacher : Anh Nam
  Ngay    : 20/12/97
  Buoi    : 1
  Bai toan thap so hinh tam giac. Tim duong di tu dinh den day tong dat max
  Phuong phap quy hoach dong Bottom-Up
}
Program DuongDiCoTongMaxTrongThapSo;
  Uses
    Crt;
  const
    inname  = 'c:\turbo\input\thapso.inp';
    outname = 'c:\turbo\output\thapso.out';
    crtname = 'c:\turbo\maketest\thap_so.mkt';
  var
    A      : array[1..5050] of word;
    f      : text;
    i, j   : longint;
    n, dem : longint;

  function max(a, b  : longint) : longint;
    begin
      if a>b then max:=a
      else max:=b
    end;

  begin
    Clrscr;
    assign(f, inname);  reset(f);
    readln(f, n);
    writeln(' Reading input ..');
    for i:=1 to (n * (n+1)) div 2 do
      read( f, a[i] );
    close(f);
    dem := (n * (n-1)) div 2;
    for i := n-1 downto 1 do
      begin
        for j := dem downto dem - i + 1 do
          a[j] := max(a[j+i], a[j+i+1])+a[j];
        dem := dem - i;
      end;
    Assign(f, outname); rewrite(f);
    writeln(f,a[1]);
    Close(f);
  end.