{$R+}
const
     fi='piton.inp';
     fo='piton.out';
var
   tran:array[1..50,1..50] of integer;
   luoi:array[1..50,1..50] of char;
   st,n,m,dd,cd,dc,cc,dai,sb,b:integer;
   c,k:integer;p:char;
   f:text;kt:byte;grow:boolean;
procedure di;
var
   r,s:integer;
begin
inc(b);
if grow then
   begin
    case p of
     'L':
         begin
         dec(cd);
         if cd<1 then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);
            end;
         dec(c);inc(dai);
         tran[dd,cd]:=dai;
         end;
     'R':
         begin
         inc(cd);
         if cd>n then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);
            end;
         dec(c);inc(dai);
         tran[dd,cd]:=dai;
         end;
     'D':
         begin
         inc(dd);
         if dd>n then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);
            end;
         dec(c);inc(dai);
         tran[dd,cd]:=dai;
         end;
     'U':
         begin
         dec(dd);
         if dd<1 then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);
            end;
         dec(c);inc(dai);
         tran[dd,cd]:=dai;
         end;
     end;
   end
else
    begin
    case p of
     'L':
         begin
         dec(cd);
         if cd<1 then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         for r:=1 to n do
         for s:=1 to n do if tran[r,s]>0 then dec(tran[r,s]);
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);if c>0 then grow:=true;
            end;
         tran[dd,cd]:=dai;
         end;
     'R':
         begin
         inc(cd);
         if cd>n then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         for r:=1 to n do
         for s:=1 to n do if tran[r,s]>0 then dec(tran[r,s]);
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);if c>0 then grow:=true;
            end;
         tran[dd,cd]:=dai;
         end;
     'D':
         begin
         inc(dd);
         if dd>n then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         for r:=1 to n do
         for s:=1 to n do if tran[r,s]>0 then dec(tran[r,s]);
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);if c>0 then grow:=true;
            end;
         tran[dd,cd]:=dai;
         end;
     'U':
         begin
         dec(dd);
         if dd<1 then begin kt:=1;exit;end;
         if tran[dd,cd]>0 then begin kt:=2;exit;end;
         for r:=1 to n do
         for s:=1 to n do if tran[r,s]>0 then dec(tran[r,s]);
         if tran[dd,cd]<0 then
            begin
            c:=c-tran[dd,cd]-1;dec(st);if c>0 then grow:=true;
            end;
         tran[dd,cd]:=dai;
         end;
     end;
     end;
if c=0 then
   begin
   grow:=false;
   if st=0 then kt:=3;
   end;
end;
procedure nhap;
var
   i,j,u,v,w:integer;
begin
fillchar(tran,sizeof(tran),0);
assign(f,fi);reset(f);
readln(f,n,m);st:=m;
read(f,dd,cd);tran[dd,cd]:=2;
readln(f,dc,cc);tran[dc,cc]:=1;
for i:=1 to m do begin readln(f,u,v,w);tran[u,v]:=-w-1;end;
c:=0;kt:=0;dai:=2;grow:=false;b:=0;
while not(seekeof(f)) do
      begin
      readln(f,p,k);
      while k>0 do
            begin
            di;
            if kt>0 then begin close(f);exit;end;
            dec(k);
            end;
      end;
close(f);
end;
procedure viet;
var
   r,s:byte;
begin
assign(f,fo);rewrite(f);
writeln(f,kt);
if kt>0 then writeln(f,b)
else
    begin
    fillchar(luoi,sizeof(luoi),'T');
    for r:=1 to n do
    for s:=1 to n do
        begin
        if tran[r,s]>0 then luoi[r,s]:='P';
        if tran[r,s]<0 then luoi[r,s]:='R';
        end;
    for r:=1 to n do
        begin
        for s:=1 to n do write(f,luoi[r,s]);writeln(f);
        end;
    end;
close(f);
end;
BEGIN
nhap;viet;
END.