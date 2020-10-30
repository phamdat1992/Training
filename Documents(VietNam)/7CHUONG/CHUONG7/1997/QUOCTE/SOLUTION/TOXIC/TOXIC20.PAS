{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  inp = 'toxic.inp';
  out = 'toxic.out';
  dx  : array [1..6] of shortint=(-1, 0, 0, 0, 0, 1);
  dy  : array [1..6] of shortint=( 0, 1, 0, 0,-1, 0);
  dz  : array [1..6] of shortint=( 0, 0, 1,-1, 0, 0);
type
  mang = array [1..20000] of shortint;
var
  f                             : text;
  a                             : array [0..33,0..33,0..33] of byte;
  dd                            : mang;
  maxdd                         : ^mang;
  h,l,w,num,max,i,j,x,y,z       : integer;
  time                          : longint;
{}
 procedure nhap;
  begin
    assign(f,inp);
    reset(f);
      readln(f,l,w,h);
    close(f);
  end;
{}
 procedure cbi;
  var i,j,k : integer;
  begin
    fillchar(a,sizeof(a),0);
    for k := 1 to h do begin
      for i := 0 to l+1 do begin
        a[i,0,k] := 1;
        a[i,w+1,k] := 1;
      end;
      for i := 0 to w+1 do begin
        a[0,i,k] := 1;
        a[l+1,i,k] := 1;
      end;
    end;
    for i := 0 to l+1 do
      for j := 0 to w+1 do begin
        a[i,j,0] := 1;
        a[i,j,h+1] := 1;
      end;
    new(maxdd);
  end;
{}
 procedure eat;
  var i : integer;
  begin
    inc(a[x+1,y,z]);
    inc(a[x,y+1,z]);
    inc(a[x,y,z+1]);
    inc(a[x-1,y,z]);
    inc(a[x,y-1,z]);
    inc(a[x,y,z-1]);
  end;
{}
 procedure noeat;
  var i : integer;
  begin
    dec(a[x+1,y,z]);
    dec(a[x,y+1,z]);
    dec(a[x,y,z+1]);
    dec(a[x-1,y,z]);
    dec(a[x,y-1,z]);
    dec(a[x,y,z-1]);
  end;
{}
 procedure di;
  begin
    if keypressed then exit;
    if a[x,y,z] <> 0 then begin
      if num>max then begin
        max := num;
        maxdd^ := dd;
        write(max,#13);
      end;
      exit;
    end;
    inc(num);
    inc(a[x,y,z]);
    eat;

      dd[num] := 1;
      dec(x);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      inc(x);

      dd[num] := 2;
      inc(y);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      dec(y);

      dd[num] := 3;
      inc(z);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      dec(z);

      dd[num] := 4;
      dec(z);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      inc(z);

      dd[num] := 5;
      dec(y);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      inc(y);

      dd[num] := 6;
      inc(x);
      dec(a[x,y,z]);
        di;
      inc(a[x,y,z]);
      dec(x);

    dec(a[x,y,z]);
    noeat;
    dec(num);
  end;
{}
 procedure xuly;
  var i,j : integer;
  begin
    num := 0;
    max := 0;
    time := meml[0:$46c];
    x := 1; y := 1 ; z := 1;
    di;
  end;
{}
 procedure writeout;
  var i,j,k : integer;
  begin
    for k := 1 to h do begin
      writeln;
      for j := 1 to w do begin
        for i := 1 to l do write(a[i,j,k]:4);
        writeln;
      end;
    end;
  end;
{}
 procedure inkq;
  var  k,i,j,t,num : integer;
  begin
    fillchar(a,sizeof(a),0);
    x := 1; y := 1; z := 1;
     for i := 1 to max do begin
      a[x,y,z] := 1;
      inc(x,dx[maxdd^[i]]);
      inc(y,dy[maxdd^[i]]);
      inc(z,dz[maxdd^[i]]);
    end;
    for k := 1 to h do begin
      for i := 1 to l do
        for j := 1 to w do if a[i,j,k] = 0 then begin
          num := 0;
          for t := 1 to 6 do inc(num,a[i+dx[t],j+dy[t],k+dz[t]]);
          if num = 1 then begin
            inc(max);
            a[i,j,k] := 2;
          end;
        end;
    end;
    write(max);
{    writeout;}
  end;
{}
begin
  WriteLn;
  time := meml[0:$46c];
  nhap;
  cbi;
  xuly;
  inkq;
  writeln;
  writeln(' Time = ',meml[0:$46c]-time,' clocks , ',(meml[0:$46c]-time)/18.2:5:2,' seconds');
end.

toxic.inp
2 3 2