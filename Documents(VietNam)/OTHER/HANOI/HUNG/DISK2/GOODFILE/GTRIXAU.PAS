Program lap_gia_tri_tu_xau;
uses crt;
const fin='gtrixau.inp';
      fou='gtrixau.out';
var  va:array[0..100] of byte;
     n,m,last:byte;
     st:string;
     q:array[1..200] of byte;
     a:array[1..4,1..4] of byte;
     f:text;
     time1:longint absolute 0:$46c;
     time2:longint;

procedure readfile;
var  i,j:byte;
     ch:char;
begin
 last:=0;
 writeln('INPUT:');
 fillchar(q,sizeof(q),0);
 assign(f,'gtrixau.inp');
 reset(f);
 write('   ');
 for i:=1 to 4 do write(chr(ord('a')+i-1),'  ');writeln;
 for i:=1 to 4 do
 begin
  write(chr(ord('a')+i-1),'  ');
  for j:=1 to 4 do
   begin
    read(f,ch);
    a[i,j]:=ord(ch)-ord('a')+1;
    write(chr(ord('a')+a[i,j]-1),'  ');
   end;
   readln(f);
   writeln;
  end;
 close(f);
end;

procedure push(i:byte);
begin
 inc(last);
 q[last]:=i;
end;

function pop:byte;
begin
 pop:=q[last];
 dec(last);
end;

procedure writeinput;
begin
  write('st=');readln(st);
  n:=length(st)-1;
  m:=length(st);
  writeln('OUTPUT:');
end;

function Chuyen:string;
var i,j,j1,d1,i1:byte;
    ch,s1:string;
begin
  i:=1;s1:='';
  repeat
    i1:=length(s1);
    if st[i] ='*' then
     begin
       d1:=0;
       ch:=s1[i1];
       if ch=')' then d1:=1;
       j:=i1;
       while d1>0 do
        begin
          dec(j);
          if s1[j]=')' then inc(d1)
          else if s1[j]='(' then dec(d1);
        end;
        s1:=s1+')';
        d1:= 0;
        ch:=s1[j-1];
        if ch=')' then inc(d1);
        j1:=j-1;
        while d1>0 do
         begin
          dec(j1);
          if s1[j1]=')' then inc(d1)
          else if s1[j1]='(' then dec(d1);
         end;
         ch:='(';
         insert(ch,s1,j1);
    end
  else s1:=s1+st[i];
     inc(i);
   until i>length(st);
   chuyen:=s1;
end;

function tinh(st:string):byte;
var i,x,k:byte;
begin
 i:=1;
 repeat
  x:=0;
  if st[i]='*' then
    begin
    k:=pop;
    x:=a[pop,k];
    push(x);
    end
  else push(ord(st[i])-ord('a')+1);
  inc(i);
 until i>length(st);
 tinh:=pop;
end;

procedure xuli;
var i,j:byte;
    ch,st1:string;
begin
 st1:=st;
 i:=1;
 while i<=va[0] do
  begin
    for j:=1 to va[i] do
    begin
    ch:='*';
    insert(ch,st,m-i+2);
    end;
    inc(i);
   end;
   if tinh(st)=1 then  writeln(chuyen);
   st:=st1;
end;


 procedure  try;
 var i,l:byte;
 begin
 if n=0 then xuli
 else
   for i:=1 to n do
    begin
      inc(va[0]);
      va[va[0]]:=i;
      n:=n-i;
      try;
      n:=n+i;
      dec(va[0]);
    end;
 end;

 begin  clrscr;
  readfile;
  writeinput;
  time2:=time1;
  try;
  writeln('time run:',((time1-time2)/18.21):6:6);
  readln
 end.
