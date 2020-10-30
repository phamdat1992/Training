{$R+}
uses crt;
const
     fi='xoso0.';
     fo='xoso.out';
     maxn=100;
     maxk=50;
     maxm=10;
var  a:array[1..maxn,1..maxk]of byte;
     diem:array[1..maxn]of byte;
     n,k,m:byte;
     day:array[1..maxk]of byte;
     s1,s2:set of byte;
     g:text;

procedure khoitao;
var i,j:byte;
begin
  s1:=[];s2:=[];
  fillchar(diem,sizeof(diem),0);
  fillchar(day,sizeof(day),0);
  fillchar(a,sizeof(a),0);
  for i:=1 to n do
    if diem[i]=0 then
      for j:=1 to k do
        s1:=s1+[a[i,j]];
end;

function kt(so:byte):boolean;
var i,j,d:byte;
begin
  kt:=false;
  s2:=s2+[so];
  for i:=1 to n do
    begin
      d:=0;
      for j:=1 to k do
         if a[i,j] in s2 then inc(d);
      if d>diem[i]then
        begin
          s2:=s2-[so];
          exit;
        end;
    end;
  kt:=true;
  s2:=s2-[so];
end;

function duoc:boolean;
var i,j,d:byte;
begin
  duoc:=false;
  for i:=1 to n do
    begin
      d:=0;
      for j:=1 to k do
        if a[i,j] in s2 then inc(d);
      if d<>diem[i] then exit;
    end;
   duoc:=true;
end;

procedure docfile;
var f:text;
    i,j:byte;
begin
  assign(f,fi);
  reset(f);
    readln(f,n,m,k);
    for i:=1 to n do
      begin
        for j:=1 to k do read(f,a[i,j]);
        readln(f,diem[i]);
      end;
  close(f);
end;

procedure xuat;
var l:byte;
begin
  if not duoc then exit
  else
    begin
      for l:=1 to k do write(g,day[l],' ');
      writeln(g);
    end;
end;

procedure xuly(i:byte);
var j:byte;
begin
  if i>k then
    begin
      xuat;
      exit;
    end;
  for j:=day[i-1]+1to m do
    if not (j in s1) and kt(j)then
    begin
      day[i]:=j;
      s1:=s1+[j];
      s2:=s2+[j];
      xuly(i+1);
      day[i]:=0;
      s1:=s1-[j];
      s2:=s2-[j];
    end;
end;

procedure ghifile;
begin
  close(g);
end;

BEGIN
  assign(g,fo);
  rewrite(g);
  khoitao;
  docfile;
  xuly(1);
  ghifile;
END.
