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
  mang = array [0..15000] of shortint;
var
  f                                              : text;
  a                                              : array [-1..34,-1..34,-1..34] of byte;
  dd                                             : mang;
  maxdd                                          : ^mang;
  h,l,w,num,max,i,j,k,x,y,z,dodai,t,maxplus      : integer;
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
    fillchar(a,sizeof(a),4);
    for k := 1 to h do
      for i := 1 to l do
        for j := 1 to w do a[i,j,k] := 0;
    new(maxdd);
    num := 0; max := 0; maxplus := 0;
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
 procedure di;
  begin
    if keypressed or (meml[0:$46c]-time>Timeover) then exit;
    if a[x,y,z] <> 0 then exit;
    inc(num);
    if (a[x+1,y,z]<>0)and(a[x,y+1,z]<>0)and(a[x,y,z+1]<>0)and(a[x-1,y,z]<>0)
        and(a[x,y-1,z]<>0)and(a[x,y,z-1]<>0) then begin
          if num>max then begin
            max := num;
            maxdd^ := dd;
            write(max,#13);
          end;
          dec(num);
          exit;
        end;
    inc(a[x,y,z]);
    eat;

    case dd[num-1] of
      1 : begin

            dd[num] := 3;
            inc(z);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            dec(z);

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

            dd[num] := 6;
            inc(x);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            dec(x);

            dd[num] := 5;
            dec(y);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(y);

            dd[num] := 1;
            dec(x);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(x);

            dd[num] := 4;
            dec(z);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
            inc(z);

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
          for t := 1 to 6 do
            if a[i+dx[t],j+dy[t],k+dz[t]] <> 4 then inc(num,a[i+dx[t],j+dy[t],k+dz[t]]);
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
      writeln(f);
      writeln(f);
{      writeout2;}
    close(f);
  end;
{}
 procedure try(num,x,y,z : integer);
  var i,j,plus,t,u : integer;
      ok           : boolean;
  begin
    if (a[x,y,z] <> 0)or(meml[0:$46c]-time>Timeover) then exit;
    a[x,y,z] := 1;
    ok := false;
    for i := 1 to 6 do if a[x+dx[i],y+dy[i],z+dz[i]] = 0 then begin
      dd[num] := i;
      t := 0;
      for j := 1 to 6 do
        if a[x+dx[i]+dx[j],y+dy[i]+dy[j],z+dz[i]+dz[j]]=1 then inc(t);
      if t=1 then begin
        try(num+1,x+dx[i],y+dy[i],z+dz[i]);
        ok := true;
      end;
    end;
    if not ok then begin
      plus := 0;
      for k := 1 to h do
        for i := 1 to l do
          for j := 1 to w do if a[i,j,k] = 0 then begin
            t := 0;
            for u := 1 to 6 do
              if a[i+dx[u],j+dy[u],k+dz[u]] <> 4 then inc(t,a[i+dx[u],j+dy[u],k+dz[u]]);
            if t = 1 then begin
              a[i,j,k] := 2;
              inc(plus);
            end;
          end;
      for k := 1 to h do
        for i := 1 to l do
          for j := 1 to w do if a[i,j,k] = 2 then a[i,j,k] := 0;
      if num+plus>max+maxplus then begin
        max := num;
        maxplus := plus;
        maxdd^ := dd;
        write(max+maxplus,#13);
      end;
    end;
    a[x,y,z] := 0;
  end;
{}
begin
  writeln;
  time := meml[0:$46c];
  nhap;
  cbi;
  time := meml[0:$46c];
  if h*l*w<=40 then try(1,1,1,1) else xuly;
  inkq;
  writeln;
  writeln(' Time = ',meml[0:$46c]-time,' clocks , ',(meml[0:$46c]-time)/18.2:5:2,' seconds');
end.

toxic.inp
toxic.out

2 3 2