{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 65000,0,655360}

uses crt;
const   fi='stable.inp';
        fo='stable.out';
var     a,b:array[0..200] of word;
        f1,f2:text;
        n:byte;
        time1:longint;
        time2:longint absolute 0:$46c;
        m,p:byte;

procedure  mofile;
begin
     assign(f1,fi);
     reset(f1);
     assign(f2,fo);
     rewrite(f2);
end;

procedure  khoitao;
begin
     time1:=time2;
     fillchar(a,sizeof(a),0);
     a[0]:=6;a[1]:=7;a[2]:=3;a[3]:=9;
     m:=3;
end;

procedure  docfile;
begin
      readln(f1,n);
end;

procedure  dongfile;
begin
       close(f1);
       close(f2);
end;

procedure  ghifile;
var  i:byte;
begin
     for i:=n-1 downto 0 do write(f2,a[i]);
     writeln('Run Time : ',(time2-time1)/18.21:4:2);
end;

function  giatri(i:byte):word;
var tich:word;
    k,j:byte;
begin
      tich:=0;
      for k:=0 to i do tich:=tich+a[k]*a[i-k];
      giatri:=tich;
end;

procedure  lapsodo;
var  i:byte;
begin
       fillchar(b,sizeof(b),0);
       for i:=0 to m do b[i]:=giatri(i);
end;

procedure  morongmang;
var  i,di,lu:word;
begin
      i:=0;di:=0;
      repeat
            lu:=(b[i]+di) mod 10;
            di:=(b[i]+di) div 10;
            b[i]:=lu;
            inc(i);
      until  (i>m) and (di=0);
      p:=i-1;
end;

function  doisanh:boolean;
var  i:byte;
begin
      doisanh:=false;
          for i:=0 to m do
              if a[i]<>b[i] then exit;
      doisanh:=true;
end;

procedure  xuli;
var  k:byte;
begin
     for k:=0 to 9 do
       begin
              a[m]:=k;
              lapsodo;
              morongmang;
              if doisanh then exit;
       end;
end;

procedure  chuongtrinh;
var i,l:byte;
begin
      l:=m;
      for i:=l+1 to n-1 do
        begin
             inc(m);
             xuli;
        end;
end;

begin  clrscr;
  mofile;
  khoitao;
  docfile;
  chuongtrinh;
  ghifile;
  dongfile;
end.

