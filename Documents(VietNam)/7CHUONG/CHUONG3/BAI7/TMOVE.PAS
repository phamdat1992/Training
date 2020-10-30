{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;

const    fi     =  'tmove.in6';
         fo     =  'tmove.out';
         max    =  41;
         d      :  array[1..4,1..2] of integer = ((1,0),(-1,0),(0,1),(0,-1));
         p      :  array[1..2,1..2] of byte = ((1,3),(3,1));
         qu     :  array[1..2,1..2] of integer = ((-1,1),(1,-1));

type     pt     =       array[1..3] of byte;

var      tr     :       array[0..max,0..max,1..2] of byte;
         a      :       array[0..max,0..max] of char;
         q ,lq  :       array[0..max*max] of pt;
         xp,dich  :  pt;
         n      :       byte;
         cuoi,lcuoi  :   integer;

procedure docf;
var       f    : text;
          i, j : integer;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for  i:= 1 to n do
          begin
               for j := 1 to n do
                        read(f,a[i,j]);
               readln(f);
          end;
     close(f);
end;

procedure init1;
var       i, j: integer;
begin
     for i := 1 to n do
         for j := 1 to n do
             if a[i,j] = 'b' then
                 begin
                     xp[1] := i; xp[2] := j;
                     if a[i,j+1] = 'b' then
                             xp[3] := 1
                     else xp[3] := 2;
                     exit;
                 end;

end;
procedure init2;
var       i, j: integer;
begin
      for i := 1 to n do
         for j := 1 to n do
             if a[i,j] = 'e' then
                 begin
                     dich[1] := i; dich[2] := j;
                     if a[i,j+1] = 'e' then
                             dich[3] := 1
                     else dich[3] := 2;
                     exit;
                 end;
end;

procedure init3;
var       i, j: integer;
begin
      for  i := 1 to n do
           for j := 1 to n do
               if (a[i,j] ='b')or(a[i,j]='e') then a[i,j] := '0';
end;

function ok(x  : pt)   :   boolean;
var       i, j: integer;
begin
     ok := false;
     for i := 1 to p[x[3],1] do
         for j := 1 to p[x[3],2] do
             if a[i+x[1]-1,j+x[2]-1] <> '0' then exit;
     ok := true;
end;

function bn(x,y : pt)  :  boolean;
begin
     bn := (x[1]=y[1])and(x[2]=y[2])and(x[3]=y[3]);
end;

procedure hien;
var       kq    :  array[1..max*max] of byte;
          top, i:  integer;
          x     :  pt;
          f    :        text;
begin
     assign(f,fo);
     rewrite(f);
     top        := 0;
     x          := q[cuoi];
     while tr[x[1],x[2],x[3]] < 6 do
           begin
                inc(top);
                kq[top] := tr[x[1],x[2],x[3]];
                case tr[x[1],x[2],x[3]] of
                     1 :dec(x[1]);
                     2 :inc(x[1]);
                     3 :dec(x[2]);
                     4 :inc(x[2]);
                     5 :begin
                             inc(x[1],qu[x[3],1]);
                             inc(x[2],qu[x[3],2]);
                             x[3] := ord(x[3]=1)+1;
                        end;
                end;
           end;
     writeln(f,top);
     for i := top downto 1 do
         case kq[i] of
            1 :  write(f,'D');
            2 :  write(f,'U');
            3 :  write(f,'R');
            4 :  write(f,'L');
            5 :  write(f,'T');
         end;
     close(f);
end;

procedure bungRa(x  :   pt);
var       i ,phu    :   byte;
          px        :   pt;
          dd        :   array[1..4] of boolean;
begin
     fillchar(dd,sizeof(dd),false);
     for i := 1 to 4 do
         begin
              px[1] := x[1] + d[i,1];
              px[2] := x[2] + d[i,2];
              px[3] := x[3];
              if (px[1] > 0)and(px[1]<n+1)and(px[2] >0)and(px[2]<n+1) then
                 begin
                      dd[i] := ok(px);
                      if tr[px[1],px[2],px[3]] = 0 then
                         if dd[i] then
                            begin
                                 inc(cuoi);
                                 q[cuoi] := px;
                                 tr[px[1],px[2],px[3]] := i;
                                 if bn(px,dich) then hien;
                            end;
                 end;
         end;

     if x[3] = 2 then phu := 2 else phu := 0;
     for i := 1 to 2 do
         if not dd[i+phu] then exit;
     px[1] := x[1]+qu[x[3],1];
     px[2] := x[2]+qu[x[3],2];
     px[3] := ord(x[3]=1)+1;
     if tr[px[1],px[2],px[3]] > 0 then exit;
     inc(cuoi);
     q[cuoi] := px;
     tr[px[1],px[2],px[3]] := 5;
     if bn(px,dich) then hien;
end;

procedure loang;
var       i: integer;
begin
    Lcuoi := 1;
    lq[1] := xp;
    tr[xp[1],xp[2],xp[3]] := 6;
    Repeat
          for i := 1 to Lcuoi do
              BungRa(lq[i]);
          lcuoi := cuoi;
          cuoi := 0;
          lq    := q;
    Until lcuoi = 0;
end;

BEGIN
     clrscr;
     docf;  init1;
     init2; init3;
     loang;
END.