Uses crt;
Const
  fn='input.txt';
  fn1='offer.txt';
  gn='output.txt';
Type
  mang=array[1..5] of record  vat,sl:integer; end;
Var
  ten,sl,gt:array[1..5] of integer;
  num:array[1..100] of integer;
  c:array[1..100] of mang;
  cost:array[1..100] of integer;
  b:array[1..100] of boolean;
  a:array[0..5,0..5,0..5,0..5,0..5] of longint;
  cs,d:array[1..5] of byte;
  m,n:byte;
procedure nhap;
  var
    f:text;
    i,j:integer;
  begin
    assign(f,fn);
    reset(f);
    readln(f,n);
    for i:=1 to n do
      begin
        readln(f,ten[i],sl[i],gt[i]);
      end;
    close(f);
    assign(f,fn1);
    reset(f);
    readln(f,m);
    for i:=1 to m do
      begin
        read(f,num[i]);
        for j:=1 to num[i] do read(f,c[i,j].vat,c[i,j].sl);
        readln(f,cost[i]);
      end;
    close(f);
  end;
function tim(x:integer):byte;
  var
    i:integer;
  begin
    for i:=1 to n do
      if ten[i]=x then
        begin
          tim:=i;
          exit;
        end;
    tim:=0;
  end;
procedure khoitao;
  var
    i,j,k:integer;
    ab:mang;
  begin
    if n<5 then
      begin
        for i:=n+1 to 5 do
          begin
            ten[i]:=0; sl[i]:=0; gt[i]:=0;
          end;
        n:=5;
      end;
    for i:=1 to m do
      begin
        b[i]:=true;
        ab:=c[i];
        for j:=1 to 5 do
          begin
            c[i,j].vat:=0; c[i,j].sl:=0;
          end;
        for j:=1 to num[i] do
          if b[i] then
            begin
              k:=tim(ab[j].vat);
              if k=0 then b[i]:=false
              else begin
                     c[i,k].vat:=ab[j].vat;
                     c[i,k].sl:=ab[j].sl;
                   end;
            end;
      end;
  end;
procedure tinh1;
  var
    s,i,min,j:longint;
  begin
    s:=0;
    for i:=1 to 5 do s:=s+gt[i]*cs[i];
    min:=s;
    for i:=1 to 5 do
      begin
        for j:=1 to 5 do d[j]:=0;
        for j:=1 to cs[i] do
          begin
            d[i]:=j;
            s:=a[cs[1]-d[1],cs[2]-d[2],cs[3]-d[3],
		cs[4]-d[4],cs[5]-d[5]]+gt[i]*j;
            if s<min then min:=s;
          end;
      end;
    a[cs[1],cs[2],cs[3],cs[4],cs[5]]:=min;
  end;
procedure tinh2;
  var
    min,s,i:longint;
  begin
    min:=a[cs[1],cs[2],cs[3],cs[4],cs[5]];
    for i:=1 to m do
      if b[i] and (cs[1]>=c[i,1].sl) and (cs[2]>=c[i,2].sl) and
      (cs[3]>=c[i,3].sl) and (cs[4]>=c[i,4].sl) and (cs[5]>=c[i,5].sl) then
        begin
          s:=a[cs[1]-c[i,1].sl,cs[2]-c[i,2].sl,cs[3]-c[i,3].sl,
		cs[4]-c[i,4].sl,cs[5]-c[i,5].sl]+ cost[i];
          if s<min then min:=s;
        end;
    a[cs[1],cs[2],cs[3],cs[4],cs[5]]:=min;
  end;
procedure xuly;
  var
    g:text;
  begin
    khoitao;
    a[0,0,0,0,0]:=0;
    for cs[1]:=0 to sl[1] do
      for cs[2]:=0 to sl[2] do
        for cs[3]:=0 to sl[3] do
          for cs[4]:=0 to sl[4] do
            for cs[5]:=0 to sl[5] do
              begin
                tinh1;
                tinh2;
              end;
    assign(g,gn);
    rewrite(g);
    writeln(g,a[sl[1],sl[2],sl[3],sl[4],sl[5]]);
    close(g);
  end;
Begin
  nhap;
  xuly;
End.
