{Resalo 2.0}
{$A-,B-,D+,E-,F+,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V-,X+}
{$M 65520,0,655360}
uses crt;
type
  nh = record
           n , k : byte;
           person : array [0..21] of byte;
           money : array [0..21] of longint;
           hs : array [0..21,0..21] of longint;
         end;
var
  f : text;
  b , p , ngc , nguoi , sndc , usesperson : byte;
  d , tongc , tong , stconlai : longint;
  ng : array [0..21] of nh;
  nc , ngt , tiencan : array [0..21] of longint;
  ngn , ngcan: array [0..21] of byte;
  time : longint;

procedure init;
  var
    i , j , q : byte;
  begin
    assign(f,'resalo1.inp');
    reset(f);
    readln(f,b,p,d);
    for i := 1 to b do
      begin
        readln(f,ng[i].n);
        for j := 1 to ng[i].n do
          read(f,ng[i].person[j]);
        readln(f);
        readln(f,ng[i].k);
        for j := 1 to ng[i].k do
          read(f,ng[i].money[j]);
        readln(f);
        for j := 1 to ng[i].n do
          begin
            for q := 1 to ng[i].k do
              read(f,ng[i].hs[j,q]);
            readln(f);
          end;
      end;
    close(f);
  end;

procedure sort;
  var
    i , j , q : byte;
    tg : longint;

  procedure doicho(i , j , t , a : byte);
    var
      tg : longint;
      x : byte;
    begin
      with ng[a] do
        begin
          if t = k then
            begin
              for x := 1 to t do
                begin
                  tg := hs[x,i];
                  hs[x,i] := hs[x,j];
                  hs[x,j] := tg;
                end;
            end
          else
            begin
              for x := 1 to t do
                begin
                  tg := hs[i,x];
                  hs[i,x] := hs[j,x];
                  hs[x,j] := tg;
                end;
            end;
        end;
    end;

  begin
    for q := 1 to b do
      begin
        with ng[q] do
          begin
            for i := 1 to n - 1 do
              for j := i + 1 to n do
                if person[i] > person[j] then
                  begin
                    tg := person[i];
                    person[i] := person[j];
                    person[j] := tg;
                    doicho(i,j,n,q);
                  end;
            for i := 1 to k - 1 do
              for j := i + 1 to k do
                if money[i] > money[j] then
                  begin
                    tg := money[i];
                    money[i] := money[j];
                    money[j] := tg;
                    doicho(i,j,k,q);
                  end;
          end;
      end;
  end;

procedure loaibo2;
  var
    i , j , q : byte;
  begin
    for q := 1 to b do
      begin
        with ng[q] do
          begin
            for i := 1 to n do
              if person[i] > p then
                for j := 1 to k do
                  hs[i,j] := -1;
            for i := 1 to k do
              if money[i] > d then
                for j := 1 to n do
                  hs[i,j] := -1;
          end;
      end;
  end;

procedure loaibo;
  var
    i , j , q : byte;
    max : longint;
    luu : array [0..21,0..21] of byte;
  begin
    tongc := 0;
    for q := 1 to b do
      begin
        fillchar(luu,sizeof(luu),0);
        with ng[q] do
          begin
            for i := 1 to n do
              begin
                max := hs[i,1];
                for j := 2 to k do
                  begin
                    if hs[i,j] <= max then
                       begin
                         hs[i,j] := max;
                         luu[i,j] := 1;
                       end
                       else max := hs[i,j];
                  end;
               end;
            {}
            for i := 1 to k do
              begin
                max := hs[1,i];
                for j := 2 to n do
                  begin
                    if hs[j,i] <= max then
                      begin
                        hs[j,i] := max;
                        luu[j,i] := 1;
                      end
                      else max := hs[j,i];
                  end;
              end;
           for i := 1 to n do
             for j := 1 to k do
               if luu[i,j] = 1 then
                 hs[i,j] := -1;
          end;
      end;
  end;

procedure can;
  var
    i , j , q : byte;
  begin
    fillchar(nc,sizeof(nc),0);
    for q := 1 to b do
      begin
        for i := 1 to ng[q].n do
          for j := 1 to ng[q].k do
            if ng[q].hs[i,j] > nc[q] then nc[q] := ng[q].hs[i,j];
      end;
    for i := b - 1 downto 1 do
      nc[i] := nc[i] + nc[i + 1];
  end;

procedure ghinhan;
  begin
    if tong > tongc then
      begin
        tongc := tong;
        sndc := usesperson;
        stconlai := d;
        tiencan := ngt;
        ngcan := ngn;
      end;
  end;

procedure try(k : byte);
  var
    i , j : byte;
  begin
    if k <= b then
      begin
        for i := ng[k].n downto 1 do
          if ng[k].person[i] <= p then
            for j := ng[k].k downto 1 do
               if ng[k].money[j] <= d then
                 if ng[k].hs[i,j] > -1 then
                   begin
                     p := p - ng[k].person[i];
                     d := d - ng[k].money[j];
                     tong := tong + ng[k].hs[i,j];
                     ngn[k] := i; ngt[k] := j;
                     usesperson := usesperson+ ng[k].person[i];
                     if tong + nc[k + 1] > tongc then try(k+1);
                     p := p + ng[k].person[i];
                     d := d + ng[k].money[j];
                     usesperson := usesperson- ng[k].person[i];
                     tong := tong - ng[k].hs[i,j];
                   end;
      end
    else ghinhan;
  end;

procedure viet;
  var
    i , j , q : byte;
  begin
    for q := 1 to b do
      begin
        with ng[q] do
          begin
            for i := 1 to n do
              write(f,person[i],' ');
            writeln(f);
            {}
            for i := 1 to k do
              write(f,money[i]:7);
            writeln(f);
            for i := 1 to n do
              begin
                for j := 1 to k do
                  write(f,hs[i,j]:7);
                writeln(f);
              end;
          end;
        writeln(f);
      end;
  end;

procedure writeout;
  var
    i : byte;
  begin
    writeln(f,d - stconlai);
    writeln(f,sndc);
    writeln(f,tongc);
    writeln(f,'**********************************************');
    for i := 1 to b do
      begin
        writeln(f,ng[i].money[tiencan[i]]);
        writeln(f,ng[i].person[ngcan[i]]);
        writeln(f,ng[i].hs[ngcan[i],tiencan[i]]);
        writeln(f,'**********************************************');
      end;
  end;


BEGIN
  clrscr;
  time := meml[0:$46c];
  init;
  assign(f,'resalo.out');
  rewrite(f);
  sort;
  loaibo2;
  loaibo;
  can;
  try(1);
  writeout;
  writeln(meml[0:$46c]-time);
  close(f);
END.
