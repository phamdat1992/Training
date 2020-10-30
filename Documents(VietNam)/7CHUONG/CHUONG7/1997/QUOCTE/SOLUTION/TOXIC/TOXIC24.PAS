{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  inp = 'toxic.inp';
  out = 'toxic.out';
  dx  : array [1..6] of shortint=(-1, 0, 0, 0, 0, 1);
  dy  : array [1..6] of shortint=( 0, 1, 0, 0,-1, 0);
  dz  : array [1..6] of shortint=( 0, 0, 1,-1, 0, 0);
  Timeover = 10*18;
type
  mang = array [0..18000] of shortint;
  khoi = array [0..33,0..33,0..33] of byte;
var
  f                                              : text;
  a                                              : khoi;
  dd                                             : mang;
  maxdd                                          : ^mang;
  h,l,w,num,max,maxt,i,j,k,x,y,z,dodai,t,u       : integer;
  time                                           : longint;
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
        a[i,0,k] := 2;
        a[i,w+1,k] := 2;
      end;
      for i := 0 to w+1 do begin
        a[0,i,k] := 2;
        a[l+1,i,k] := 2;
      end;
    end;
    for i := 0 to l+1 do
      for j := 0 to w+1 do begin
        a[i,j,0] := 2;
        a[i,j,h+1] := 2;
      end;
    new(maxdd);
  end;
{}
 procedure eat;
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
  begin
    dec(a[x+1,y,z]);
    dec(a[x,y+1,z]);
    dec(a[x,y,z+1]);
    dec(a[x-1,y,z]);
    dec(a[x,y-1,z]);
    dec(a[x,y,z-1]);
  end;
{}
 procedure tinht;
  begin
    t := 0;
    for k := 1 to h do
      for i := 1 to l do
        for j := 1 to w do if a[i,j,k] = 1 then inc(t);
    t := 0;
    for k := 1 to h do
      for i := 1 to l do
        for j := 1 to w do
          for u := 1 to 6 do
            if a[i+dx[u],j+dy[u],k+dz[u]] = 1 then inc(t);
  end;
{}
 procedure di;
  begin
    if keypressed or (meml[0:$46c]-time>Timeover) then exit;
    if a[x,y,z] <> 0 then exit;
    inc(num);
    if (a[x+1,y,z]<>0)and(a[x,y+1,z]<>0)and(a[x,y,z+1]<>0)and(a[x-1,y,z]<>0)
        and(a[x,y-1,z]<>0)and(a[x,y,z-1]<>0) then begin
          t:= 0;
{          tinht;}
          if num+t>max+maxt then begin
            max := num;
            maxt := t;
            maxdd^ := dd;
            write(max{+maxt},#13);
          end;
          dec(num);
          exit;
        end;
    inc(a[x,y,z]);
    eat;

    case dd[num-1] of
      1 : begin
            dd[num] := 1;
            dec(x);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(x);

            dd[num] := 6;
            inc(x);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            dec(x);

            dd[num] := 2;
            inc(y);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            dec(y);

            dd[num] := 5;
            dec(y);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(y);

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

          end;
      2 : begin

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

          end;
      3 : begin
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

            dd[num] := 4;
            dec(z);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(z);


          end;
      4 : begin
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

          end;
      5 : begin
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

          end;
      6 : begin
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

          end;
    end;

    dec(a[x,y,z]);
    noeat;
    dec(num);
  end;
{}
 procedure xuly;
  var i,j : integer;
  begin
    num := 0;
    max := 0;maxt := 0;
    time := meml[0:$46c];
    x := 1; y := 1 ; z := 1;
    dd[0] := 1;
    di;
  end;
{}
 procedure writeout1;
  var i,j,k : integer;
  begin
    x := 1; y := 1; z := 1;
      for k := 1 to dodai do begin
        writeln(f,'E ',x,' ',y,' ',z);
        writeln(f,'M ',x,' ',y,' ',z);
        for i := 1 to 6 do if a[x+dx[i],y+dy[i],z+dz[i]]=2 then
            writeln(f,'E ',x+dx[i],' ',y+dy[i],' ',z+dz[i]);
        inc(x,dx[maxdd^[k]]);
        inc(y,dy[maxdd^[k]]);
        inc(z,dz[maxdd^[k]]);
      end;
    writeln(f,'E ',x,' ',y,' ',z);
    writeln(f,'M ',x,' ',y,' ',z);
    for i := 1 to 6 do if a[x+dx[i],y+dy[i],z+dz[i]]=2 then
        writeln(f,'E ',x+dx[i],' ',y+dy[i],' ',z+dz[i]);
  end;
{}
 procedure writeout2;
  var i,j,k : integer;
  begin
    for k := 1 to h do begin
      writeln(f);
      for j := 1 to w do begin
        for i := 1 to l do write(f,a[i,j,k]:4);
        writeln(f);
      end;
    end;
  end;
{}
 procedure inkq;
  var  k,i,j,t,num : integer;
  begin
    fillchar(a,sizeof(a),0);
    x := 1; y := 1; z := 1;
    dodai := max-1;
      for i := 1 to dodai do begin
        a[x,y,z] := 1;
        inc(x,dx[maxdd^[i]]);
        inc(y,dy[maxdd^[i]]);
        inc(z,dz[maxdd^[i]]);
      end;
    a[x,y,z] := 1;
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
    assign(f,out);
    rewrite(f);
      writeout1;
      writeout2;
    close(f);
  end;
{}
begin
  writeln;
  time := meml[0:$46c];
  nhap;
  cbi;
  xuly;
  inkq;
  writeln;
  writeln(' Time = ',meml[0:$46c]-time,' clocks , ',(meml[0:$46c]-time)/18.2:5:2,' seconds');
end.

toxic.inp
toxic.out

2 3 2