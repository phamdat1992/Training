{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 16384,0,655360}

uses crt;
type  mang=array[1..8] of 1..8;
      mang1=array[1..30200] of word;
      mang2=array[1..10300]of word;
      mang3=array[1..30200] of 0..1;
      mang4=array[1..13000] of 0..1;
var q:^mang2;
    p1,t1:^mang2;
    t:^mang1;
    p:mang1;
    last,first:word;
    oko:^mang3;
    oko1:^mang4;
    TIME1:LONGINT   ABSOLUTE 0:$46C;
    TIME2:LONGINT;
    cha:char;
    a,tg,a1:mang;
    stop,dem1,lastt:word;
    ch:array[1..300] of char;
    f:text;

  procedure  readfile;
  var i:1..8;
  begin
    TIME2:=TIME1;
    lastt:=0;
    last:=0;
    first:=0;
    assign(f,'magic.inp');
    reset(f);
    for i:=1 to 8 do read(f,a[i]);
    close(f);
    for i:=1 to 4 do write(a[i]:4);
    a1:=a;
    writeln;
    for i:=8 downto 5 do write(a[i]:4);
    fillchar(oko^,sizeof(oko^),0);
    fillchar(oko1^,sizeof(oko1^),0);
   end;

  function gthua(i:byte):word;
 var j,thua:word;
 begin thua:=1;
  for j:=1 to i do thua:=thua*j;
 gthua:=thua;
 end;
 (******************************************)
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
   function  chuyen2(a:mang):word;
   var   i,j:byte;x:word;
   begin
     i:=1;x:=1;
     repeat x:=(a[i]-1)*gthua(8-i)+x;
         for j:=i+1 to 8 do
           if a[j]>a[i] then dec(a[j]);
           inc(i);
      until i>=9;
     chuyen2:=x;
     end;
  (**********************************)
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
  (****************************)
  procedure get(i:word);
  begin
      inc(last);
      inc(lastt);
      q^[lastt]:=i;
  end;

  function  put:word;
  var  i:word;
  begin
      inc(first);
      put:=q^[1];
      for i:=2 to lastt do
       q^[i-1]:=q^[i];
      dec(lastt);
  end;

  function ok1(d:word):boolean;
  var  i:integer;
  begin
  ok1:=true;
  if (d>30000) and (oko1^[d-30000]=0) then exit;
  if (d<=30000) and (oko^[d]=0) then exit;
  ok1:=false;
  end;

  procedure xuat(i:word);
  var j:byte;
  begin
      dem1:=0;
      while i<>1 do
       begin
           inc(dem1);
           if i>30000 then
            begin
             ch[dem1]:=chr(64+p1^[i-30000]);
             i:=t1^[i-30000];
             end
            else
             begin
               ch[dem1]:=chr(64+p[i]);
               i:=t^[i];
              end;
         end;
         writeln(dem1);
         for j:= dem1 downto 1 do writeln(ch[j]);
  end;

  (*********************************)
  procedure  xuli;
  var dk:boolean;l,k:word;
      i,i1:1..8;
     begin   dk:=false;get(1);
     oko^[1]:=1;
          repeat  k:=put;
           chuyen1(k,a);
           i:=1;
           while (i<=3)and (dk=false) do
            begin  bd(i,a,tg);
                  l:=chuyen2(tg);
                 if ok1(l) then
                   begin
                         if l>30000 then oko1^[l-30000]:=1
                         else oko^[l]:=1;
                         get(l);
                         if last<=30000 then
                         begin
                         t^[last] :=first;
                         p[last]:=i;
                         end
                         else
                          begin
                             t1^[last-30000]:= first;
                             p1^[last-30000]:=i;
                          end;
                         if l=stop then begin xuat(last);dk:=true;end;
                   end;
                         inc(i);
              end;
           until dk=true;

      end;
     (*****************************************)
    BEGIN clrscr;
    new(oko1);
    new(q);
    new(oko);
    WRITELN('*****INPUT****');
    readfile;
    WRITELN;
    WRITELN;
    WRITELN('          *****PROGRAM MAGIC SQUARE STARTS******');
    new(t);
    new(p1);
    new(t1);
    dem1:=0;
    stop:=chuyen2(a);
    writeln('*****OUTPUT*****');
    xuli;
    WRITELN('************TIMERUN=',(TIME1-TIME2)/18.21:6:6,'**********');
    WRITELN;
    WRITELN('          *****PROGRAM MAGIC SQUARE FINISHED******');
    dispose(oko1);
    dispose(oko);
    dispose(t);
    dispose(q);
    dispose(t1);
    dispose(p1);
    writeln('   ban co muon chuong trinh kiem tra ket qua khong ? (c/k)');
    cha:=readkey;
    if upcase(cha)='C' then
     begin
       clrscr;
       writeln('****INPUT***  ');
       for last:=1 to 8 do write(a1[last]:4);
       writeln;writeln;
       writeln('****OUTPUT****  ');
       writeln(dem1);
       for last:=dem1 downto 1 do write(ch[last]:3);
       writeln;
       writeln('MANG BAN DAU  1 2 3 4 5 6 7 8');
       for last:=1 to 8 do a[last]:=last;
       writeln;
       for last:=dem1 downto 1 do
        begin
          write('phep bien doi  ',dem1-last+1,'  ',ch[last],' *********>>');
          bd(ord(ch[last])-64,a,tg);
          for lastt:=1 to 8 do write (tg[lastt]:4 );  readln;
          a:=tg;
         end;
      end;
      readln
    END.
