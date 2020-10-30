{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const max=30000;
type  mang=array[1..8] of 1..8;
      mang1=array[1..30200] of word;
var a,tg:mang;
    q:^mang1;
    q1:array[1..11020] of word;
    first,stop,last,lastt:word;
    f2:file of word;
    f3:file of byte;
    ok:array[1..40320] of boolean;
    TIME1:LONGINT   ABSOLUTE 0:$46C;
    TIME2:LONGINT;
    ch:array[1..300] of char;
    f:text;
  (***********************************)
  procedure  readfile;
  var i:1..8;
  begin
    writeln('INPUT:');
    TIME2:=TIME1;
    first:=0;last:=1;lastt:=0;
    assign(f,'magic.inp');
    reset(f);
    for i:=1 to 8 do read(f,a[i]);
    close(f);
    for i:=1 to 4 do write(a[i]:4);
    writeln;
    for i:=8 downto 5 do write(a[i]:4);
    fillchar(ok,sizeof(ok),true);
    ok[1]:=false;
    fillchar(q,sizeof(q),0);
    fillchar(q1,sizeof(q1),0);
    q^[1]:=1;
    writeln;
    writeln('OUTPUT');
   end;
  (******************************************)
  function gthua(i:byte):word;
  var j,thua:word;
  begin
       thua:=1;
       for j:=1 to i do thua:=thua*j;
       gthua:=thua;
  end;
 (******************************************)
  (* chuyen tu so sang  mang *)
  procedure  chuyen1(k:word;var a:mang);
  var  i,j,d,m:byte;b:mang;
  begin
     m:=8;
     for i:=1 to m do  b[i]:=i;
     i:=1;
     repeat j:=1;
         while j*gthua(8-i)<k do inc(j);
         k:=k-(j-1)*gthua(8-i);
         a[i]:=b[j];
         for d:=j+1 to m do
             b[d-1]:=b[d];
         m:=m-1;
         inc(i);
     until i>=9;
   end;
 (**********************************)
 (* chuyen tu mang sang so*)
   function  chuyen2(a:mang):word;
   var   i,j:byte;x:word;
   begin
      i:=1;x:=1;
      repeat
             x:=(a[i]-1)*gthua(8-i)+x;
             for j:=i+1 to 8 do
             if a[j]>a[i] then dec(a[j]);
             inc(i);
      until i>=9;
      chuyen2:=x;
    end;
  (**********************************)
  (* ba phep bien doi*)
     procedure  bd(i:byte;a:mang;var tg:mang);
     var  x,j:1..8;
     begin
         if i=1 then
          begin tg:=a;
            for j:=1 to 4 do
             begin x:=tg[j];
                   tg[j]:=tg[9-j];
                   tg[9-j]:=x;
             end;
           end;
          if i=2 then
            begin
                tg[1]:=a[4];
                tg[2]:=a[1];
                tg[3]:=a[2];
                tg[4]:=a[3];
                tg[8]:=a[5];
                tg[7]:=a[8];
                tg[6]:=a[7];
                tg[5]:=a[6];
             end;
          if i=3 then
            begin  tg:=a;
                   x:=tg[7];
                   tg[7]:=tg[6];
                   tg[6]:=tg[3];
                   tg[3]:=tg[2];
                   tg[2]:=x;
             end;
        end;

  procedure  get(k:word);
  begin
     inc(last);
     if last<=max then q^[last]:=k
     else begin inc(lastt);q1[last-max]:=k;end;
   {  seek(f2,filesize(f2));
    write(f2,j);
    seek(f3,filesize(f3));
    write(f3,k);}
  end;

  function put:word;
  begin
   inc(first);
   if first<=max then put:=q^[first]
   else put:=q1[first-max];
  end;

  {procedure xuat;}

  procedure xu_li;
  var dk:boolean;
      i,j:byte;k,s:word;
  begin
    dk:=true;
    time2:=time1;
    repeat
    s:=put;
    i:=1;
    chuyen1(s,a);
    while (i<=3) and dk do
      begin
        bd(i,a,tg);
{        for j:=1 to 8 do write(tg[j],'  ');readln;}
        k:=chuyen2(tg);
        if ok[k] then
         begin
          ok[k]:=false;
          get(k);
          if k=stop then begin  writeln('   program fishish');
          writeln(((time1-time2)/18.21):9:6);
	  dk:=false;end;
         end;
        inc(i);
       end;
   until dk=false;
 end;


begin  clrscr;
 mark(q);
 new(q);
 assign(f2,'data2.dat');
 rewrite(f2);
 assign(f3,'data3.dat');
 rewrite(f3);
 readfile;
 stop:=1;
 stop:=chuyen2(a);
 xu_li;
 close(f2);
 close(f3);
 release(q);
 readln
end.

8 7 6 5 4 3 2 1
1 3 2 4 5 6 7 8
8 7 6 5 4 3 2 1