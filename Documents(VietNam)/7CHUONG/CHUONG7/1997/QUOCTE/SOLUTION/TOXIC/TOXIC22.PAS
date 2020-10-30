{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
uses crt;
const
  inp = 'toxic.inp';
  out = 'toxic.out';
  dx  : array [1..6] of shortint=(-1, 0, 0, 0, 0, 1);
  dy  : array [1..6] of shortint=( 0, 1, 0, 0,-1, 0);
  dz  : array [1..6] of shortint=( 0, 0, 1,-1, 0, 0);
  Timeover = 20*18;
type
  mang = array [1..16000] of shortint;
var
  f                               : text;
  a                               : array [-1..34,-1..34,-1..34] of byte;
  dd                              : mang;
  maxdd                           : ^mang;
  h,l,w,num,max,i,j,t,x,y,z,dodai : integer;
  min,mini                        : integer;
  time                            : longint;
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
        a[i,-1,k] := 1;
        a[i,w+2,k] := 1;
      end;
      for i := 0 to w+1 do begin
        a[0,i,k] := 1;
        a[l+1,i,k] := 1;
        a[-1,i,k] := 1;
        a[l+2,i,k] := 1;
      end;
    end;
    for i := 0 to l+1 do
      for j := 0 to w+1 do begin
        a[i,j,0] := 1;
        a[i,j,h+1] := 1;
        a[i,j,-1] := 1;
        a[i,j,h+2] := 1;
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
  var i,mini : integer;
      ts     : array [1..6] of byte;
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

      for i := 1 to 6 do begin
        ts[i] := 0;
        for j := 1 to 6 do
          if a[x+dx[i]+dx[j],y+dy[i]+dy[j],z+dz[i]+dz[j]]=0 then inc(ts[i]);
      end;
      for i := 1 to 6 do begin
        min := maxint;
        for j := 1 to 6 do if ts[j]<min then begin
          min := ts[j];
          mini := j;
        end;
        ts[mini] := 255;
          dd[num] := mini;
          inc(x,dx[mini]);
          inc(y,dy[mini]);
          inc(z,dz[mini]);
            dec(a[x,y,z]);
              di;
            inc(a[x,y,z]);
          dec(x,dx[mini]);
          dec(y,dy[mini]);
          dec(z,dz[mini]);
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
    max := 0;
    time := meml[0:$46c];
    x := 1; y := 1 ; z := 1;
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
    writeln(f,max);
      writeout1;
      writeout2;
    close(f);
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
toxic.out

2 3 2