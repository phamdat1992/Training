{ bai lam cua ba minh }
{$A+,B+,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
  const
    MN = 21; SN = 11;
    fn = 'resalo.inp';
    gn = 'resalo1.out';
  type
    mang2 = array[1..SN,1..SN] of longint;
    mang1n = array[0..SN] of byte;
    mang1t = array[0..SN] of longint;
    mangng= array[1..MN] of mang1n;
    mangst = array[1..MN] of mang1t;
    manggt = array[1..MN] of mang2;
    mang1 = array[1..MN] of longint;
  var
    t:mangst;
    n:mangng;
    gt,gt1 :manggt;
    ngn,ngt,ngnc,ngtc,nc:mang1;
    d,p,b,tong,tongc,snd,sndc,stcl:longint;
    time:longint absolute 0:$46C;
    time1:longint;
    f:text;
(*----------*)
procedure nhap;
  var i,i1,j:integer;
begin
  assign(f,fn); reset(f);
  read(f,d,p,b); fillchar(nc,sizeof(nc),0);
  for i:=1 to  d do
    begin
      read(f,n[i,0]);
      for j:=1 to n[i,0]  do read(f,n[i,j]);
      read(f,t[i,0]);
      for j:=1 to t[i,0]  do read(f,t[i,j]);
      for i1:=1 to n[i,0] do
      for j:=1 to t[i,0] do
        begin
          read(f,gt[i,i1,j]);
          if gt[i,i1,j] > nc[i] then nc[i]:=gt[i,i1,j];
        end;
    end;
  close(f);
end;

procedure init;
  var i:integer;
begin
  tong:=0; tongc:=0;
  for i:=d-1 downto 1 do
    nc[i]:=nc[i]+nc[i+1];
end;

procedure ghinhan;
begin
  if tong > tongc then
    begin
      tongc:=tong;
      sndc:=snd;
      stcl:=b;
      ngtc:=ngt;
      ngnc:=ngn;
    end;
  writeln(tongc);
end;

procedure xuly(k:integer);
  var i,j:byte;
begin
  if time - time1 > 300 then exit;
  if k <= d then
    begin
      for i:= n[k,0] downto 1 do
      for j:= t[k,0] downto 1 do
      if (n[k,i] <= p) and (t[k,j] <= b) then
         begin
           ngn[k]:=i; ngt[k]:=j;
           p:=p - n[k,i]; b:=b - t[k,j];
           tong:=tong+gt[k,i,j];
           snd:=snd+ n[k,i];
           if tong + nc[k+1] > tongc then xuly(k+1);
           p:=p + n[k,i]; b:=b + t[k,j]; snd:=snd- n[k,i];
           tong:=tong - gt[k,i,j];
         end;
    end else ghinhan;
end;

procedure viet;
  var i:byte;
begin
  assign(f,gn); rewrite(f);
  writeln(f,b -stcl);
  writeln(f,sndc);
  writeln(f,tongc);
  for i:=1 to d do
    begin
      writeln(f,t[i,ngtc[i]]);
      writeln(f,n[i,ngnc[i]]);
      writeln(f,gt[i,ngnc[i],ngtc[i]]);
    end;
  close(f);
end;

procedure tinh;
begin
end;

BEGIN
  clrscr;
  time1:=time;
  nhap;
  init;
  tinh;
  xuly(1);
  viet;
END.