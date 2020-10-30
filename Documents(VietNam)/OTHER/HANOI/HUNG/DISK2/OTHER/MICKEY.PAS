{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;
const  fi='mickey.inp';
       fo='mickey.out';
var    dem,x,dich,frdich:longint;
       f1,f2:text;

procedure  mofile;
begin
       assign(f1,fI);
       reset(f1);
       assign(f2,fo);
       rewrite(f2);
end;

procedure  dongfile;
begin
      close(f1);
      close(f2);
end;

procedure khoitao;
begin
       dem:=0;
       frdich:=0;
       dich:=0;
end;

procedure  docfile;
begin
       readln(f1,x);
end;

procedure  ghifile;
begin
      writeln(f2,x);
end;

procedure tinh(var i:longint);
begin
      i:=x;i:=i div 100;
      i:=i mod 10;
end;

procedure giam;
begin
       inc(dem);
       dec(x);
       if x<=0 then begin  writeln(f2,-1);close(f1);close(f2);halt; end;
end;

procedure  vietnguoc(var y:longint);
var  i:longint;
begin
       i:=x;y:=0;
       while i>0 do
          begin
                y:=y*10 + i mod 10;
                i:=i div 10;
          end;
end;

function  sochuso(i:longint):byte;
var  dd:byte;
begin
      dd:=0;
      while i>0 do
         begin
               inc(dd);
               i:=i div 10;
         end;
      sochuso:=dd;
end;

procedure  nutdichuyen;
var  y:longint;
begin
      if dich=0 then
           begin
                  tinh(y);
                  giam;
                  frdich:=dich;
                  dich:=9;
                  if y<=7 then  dich:=7;
           end;
      if dich=2 then
           begin
                 frdich:=dich;
                 if x mod 3 = 0 then dich:=7;
                 if x mod 3 = 2 then dich:=4;
                 if x mod 3 = 1 then begin dich:=1;writeln(f2,x-1);close(f2);close(f1);halt;end;
                 giam;
           end;
      if dich=4 then
           begin
                  frdich:=dich;
                  dich:=2;
                  vietnguoc(y);
                  if y>x then dich:=6;
                  giam;
           end;
      if dich=6 then
           begin
                 frdich:=dich;
                 dich:=4;
                 if odd( sochuso(x)) then dich:=7;
                 giam;
           end;
      if dich=7 then
           begin
                 y:=x mod 7;
                 y:=(y*y) mod 7;
                 frdich:=dich;
                 dich:=0;
                 if y=0 then dich:=2;
                 if y=1 then dich:=6;
                 if y=2 then dich:=8;
                 giam;
           end;
     if dich=8 then
           begin
                 y:=x mod 5;
                 frdich:=dich;
                 dich:=9;
                 if (y=2) or (y=3) then dich:=7;
           end;
     if dich=9 then
           begin
                 if frdich=0 then
                    begin
                           frdich:=dich;
                           dich:=8;
                    end
                 else
                 begin
                           frdich:=dich;
                           dich:=0;
                 end;
                 giam;
           end;
end;

procedure  mickeydichuyen;
begin
       nutdichuyen;
end;

procedure  xuli;
begin
      repeat
             mickeydichuyen;
      until (x<=0) or (dich=1);
end;

procedure  chuongtrinh;
begin
     mofile;
     docfile;
     khoitao;
     xuli;
     ghifile;
     dongfile;
end;

begin clrscr;
    chuongtrinh;
end.

