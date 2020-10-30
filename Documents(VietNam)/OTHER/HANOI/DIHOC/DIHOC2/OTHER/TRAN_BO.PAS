uses crt;
const  fi='tran.inp';
       fo='tran.out';
       b:array[1..4] of shortint=(0,-1,0,1);
       c:array[1..4] of shortint=(-1,0,1,0);
       kt:array[-1..1] of char=('R','T','P');
type   arrnl=array[1..100,1..100] of byte;
       arrvt=array[1..100,1..100] of shortint;
       arrgo=array[0..20000] of 0..4;
var    a:arrvt;
       nl:arrnl;
       m,n,cd,x,y:byte;
       luu:arrgo;
       d,tt,k:longint;
       f:text;

procedure  init;
begin
       fillchar(a,sizeof(a),0);
       fillchar(nl,sizeof(nl),0);
       fillchar(luu,sizeof(luu),0);
       tt:=0;
end;

procedure  xuatxem;
var  i,j:byte;
begin
      clrscr;
      for i:=1 to n do
       begin
             for j:=1 to n do
               begin
                    if a[i,j]=0 then write('T ');
                    if a[i,j]>0 then write('P ');
                    if a[i,j]=-1 then write('R ');
               end;
             writeln;
       end;
       readln;
end;

procedure  readfile;
var   i,j,k,l:byte;
      ch:char;
begin
       assign(f,fi);
       reset(f);
            readln(f,n,m);
			Readln(f,i,j,k,l);
            x:=i;y:=j;
            a[x,y]:=2;a[k,l]:=1;cd:=2;
            for i:=1 to m do
               begin
                     readln(f,j,k,l);
                     a[j,k]:=-1;
                     nl[j,k]:=l;
			   end;
           d:=0;
            while not eof(f) do
              begin
                    j:=4;
                    readln(f,ch,i);
                    if ch='L' then j:=1;
                    if ch='U' then j:=2;
                    if ch='R' then j:=3;
                    while i>0 do begin inc(d);luu[d]:=j;dec(i);end;
              end;
       close(f);
end;

function  vipham1:boolean;
begin
       vipham1:=false;
       if  (x+b[luu[tt]] in [1..n] ) and (y+c[luu[tt]] in [1..n]) then exit;
       vipham1:=true;
end;

function  vipham2:boolean;
begin
       vipham2:=true;
       if  a[x+b[luu[tt]],y+c[luu[tt]]]>0 then exit;
       vipham2:=false;
end;

procedure  xuat1;
begin
     writeln(f,1);
     writeln(f,tt);
     close(f);
     HALT;
end;

procedure  xuat2;
begin
     writeln(f,2);
     writeln(f,tt);
     close(f);
     HALT;
end;

procedure  xuat3;
begin
     writeln(f,3);
     writeln(f,tt);
     close(f);
     HALT;
end;

procedure  go1;
var j,l:byte;
begin
       if vipham1 then xuat1;
       if vipham2 then xuat2;
        for j:=1 to n do
          for l:=1 to n do
             if a[j,l]>0 then dec(a[j,l]);
        x:=x+b[luu[tt]];y:=y+c[luu[tt]];
        a[x,y]:=cd;
end;

function  gaptho:boolean;
begin
       gaptho:=true;
       if a[x+b[luu[tt]],y+c[luu[tt]]]=-1 then exit;
       gaptho:=false;
end;

procedure  go2;
begin
       if vipham1 then xuat1;
       if vipham2 then xuat2;
       inc(cd);
       x:=x+b[luu[tt]];y:=y+c[luu[tt]];
       a[x,y]:=cd;
end;

procedure  an_tho;
begin
      go1;
      dec(m);
      repeat
             inc(tt);
             if gaptho then begin inc(k,a[x+b[luu[tt]],y+b[luu[tt]]]);a[x+b[luu[tt]],y+c[luu[tt]]]:=0;dec(m);end;
             go2;
             dec(k);
      until k<=0;
end;

procedure  tran_bo;
begin
      assign(f,fo);
      rewrite(f);
      tt:=1;
      k:=1;
      repeat
             if vipham1 then xuat1;
             if vipham2 then xuat2;
             if gaptho then an_tho
             else  go1;
             inc(tt);
      until  tt>=d;
      xuat3;
      close(f);
end;

begin  clrscr;
  init;
  readfile;
  tran_bo;
end.
5 4
4 4 4 5
1 5 1
1 1 0
3 3 2
5 5 1
U 1
L 1
U 2
L 2
D 4
R 4
U 1
L 1
D 1
L 3

