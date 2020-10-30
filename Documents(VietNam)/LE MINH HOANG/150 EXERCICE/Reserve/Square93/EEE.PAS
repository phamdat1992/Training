{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
 const
      inp  = 'FUJIWARA.INP';
      out  = 'FUJIWARA.OUT';
      n    = 9;
      bit  : array [0..8] of integer = (1,2,4,8,16,32,64,128,256);
 type
     mang1 = array [1..n] of char;
     mang2 = array [1..n] of mang1;
     mang3 = array [1..n] of integer;
 var
    a,res:mang2;
    line,column,square:mang3;
    f:text;

 function getbit(d,x:integer):integer;
  begin
       getbit:=(x shr d) and 1;
  end;

 function getbithv(d,i,j:integer):integer;
  begin
       if (i<=3) and (j<=3) then getbithv:=getbit(d,square[1]) else
       if (i<=3) and (j>3) and (j<=6) then getbithv:=getbit(d,square[2]) else
       if (i<=3) and (j>6) and (j<=9) then getbithv:=getbit(d,square[3]) else
       if (i>3) and (i<=6) and (j<=3) then getbithv:=getbit(d,square[4]) else
       if (i>3) and (i<=6) and (j>3) and (j<=6) then getbithv:=getbit(d,square[5]) else
       if (i>3) and (i<=6) and (j>6) and (j<=9) then getbithv:=getbit(d,square[6]) else
       if (i>6) and (j<=3) then getbithv:=getbit(d,square[7]) else
       if (i>6) and (j>3) and (j<=6) then getbithv:=getbit(d,square[8]) else
       if (i>6) and (j>6) and (j<=9) then getbithv:=getbit(d,square[9]);
  end;

 procedure nhethv(i,j,t:integer);
  begin
       if (i<=3) and (j<=3) then square[1]:=square[1] or bit[t] else
       if (i<=3) and (j>3) and (j<=6) then square[2]:=square[2] or bit[t] else
       if (i<=3) and (j>6) and (j<=9) then square[3]:=square[3] or bit[t] else
       if (i>3) and (i<=6) and (j<=3) then square[4]:=square[4] or bit[t] else
       if (i>3) and (i<=6) and (j>3) and (j<=6) then square[5]:=square[5] or bit[t] else
       if (i>3) and (i<=6) and (j>6) and (j<=9) then square[6]:=square[6] or bit[t] else
       if (i>6) and (j<=3) then square[7]:=square[7] or bit[t] else
       if (i>6) and (j>3) and (j<=6) then square[8]:=square[8] or bit[t] else
       if (i>6) and (j>6) and (j<=9) then square[9]:=square[9] or bit[t];
  end;

 procedure bohv(i,j,t:integer);
  begin
       if (i<=3) and (j<=3) then square[1]:=square[1] xor bit[t] else
       if (i<=3) and (j>3) and (j<=6) then square[2]:=square[2] xor bit[t] else
       if (i<=3) and (j>6) and (j<=9) then square[3]:=square[3] xor bit[t] else
       if (i>3) and (i<=6) and (j<=3) then square[4]:=square[4] xor bit[t] else
       if (i>3) and (i<=6) and (j>3) and (j<=6) then square[5]:=square[5] xor bit[t] else
       if (i>3) and (i<=6) and (j>6) and (j<=9) then square[6]:=square[6] xor bit[t] else
       if (i>6) and (j<=3) then square[7]:=square[7] xor bit[t] else
       if (i>6) and (j>3) and (j<=6) then square[8]:=square[8] xor bit[t] else
       if (i>6) and (j>6) and (j<=9) then square[9]:=square[9] xor bit[t];
  end;

 procedure init(i,j:integer);
  var
     t:integer;
  begin
       t:=ord(a[i,j])-49;
       line[i]:=line[i] or bit[t];
       column[j]:=column[j] or bit[t];
       nhethv(i,j,t);
  end;

 procedure input;
  var
     f:text;
     i,j:integer;
  begin
       assign(f,inp);reset(f);
       fillchar(line,sizeof(line),0);
       fillchar(column,sizeof(column),0);
       for i:=1 to n do
       begin
            for j:=1 to n do
            begin
                 read(f,a[i,j]);
                 if a[i,j]<>'.' then init(i,j);
            end;
            readln(f);
       end;
       close(f);
  end;

 procedure print;
  var
     i,j:integer;
  begin
       for i:=1 to n do
       begin
            for j:=1 to n do write(f,a[i,j]);
            writeln(f);
       end;
       close(f);
       halt;
  end;

 procedure try(i,j:integer);
  var
     k:integer;
  begin
       if i=n+1 then
       begin
            print;
            exit;
       end;
       if j=n+1 then
       begin
            try(i+1,1);
            exit;
       end;
       if a[i,j]<>'.' then try(i,j+1) else
       for k:=1 to n do
           if (getbit(k-1,line[i])=0) and (getbit(k-1,column[j])=0)
           and (getbithv(k-1,i,j)=0) then
           begin
                line[i]:=line[i] or bit[k-1];
                column[j]:=column[j] or bit[k-1];
                nhethv(i,j,k-1);
                a[i,j]:=chr(k+48);
                try(i,j+1);
                a[i,j]:='.';
                bohv(i,j,k-1);
                line[i]:=line[i] xor bit[k-1];
                column[j]:=column[j] xor bit[k-1];
           end;
  end;

 BEGIN
      assign(f,out);rewrite(f);
      input;
      try(1,1);
      writeln(f,'IMPOSSIBLE');
      close(f);
 END.