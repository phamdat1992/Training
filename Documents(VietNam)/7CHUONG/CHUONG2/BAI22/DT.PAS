program asd;
uses crt;
const
     fi='pv1.';
     fo='dt.out';
type
    mang=array[1..100] of  string;
    lk=record
    sl:integer;
    ma:set of 0..100;
    end;

var
    ma: mang;
    KA: array[1..100] of char;
    dd : array[1..100] of lk;
    m ,k : word;
    f :  text;

procedure ini;
var
   i ,j :  word;
   s: string;
begin
     assign(f,fi);
     reset(f);
     readln(f,m,k);
     for i:=1 to m do
         readln(f,ma[i]);
     readln(f,s);
     for i:=1 to k do
         ka[i]:=s[i];
     close(f);
end;

procedure makedt;
var
   i ,j ,p,l :  word;

begin
     for i:=1 to k do
         dd[i].ma:=[];
     for i:=1 to k do
         begin
              l:=0;
          for j:=1 to m do
             if pos(ka[i],ma[j])<>0 then
                begin
                dd[i].ma:=dd[i].ma+[j];
                inc(l);
                end;
             dd[i].sl:=l;
         end;
end;

procedure xuli;
type
    luu=record
   ka,ma : integer
   end;
var
   i ,j ,l ,max ,li:  integer;
   ok :  boolean;
   chon :  array [1..100] of luu;
   xet: array[1..100] of boolean;

begin
     fillchar(xet,sizeof(xet),true);
     ok :=true;
     l :=1;
     for i:=1 to k do
         chon[i].ka:=0;
     while ok do
           begin
           ok:=false;
           max:=0;
           for i:=1  to k do
               if (dd[i].sl > max)and xet[i] then
                  begin
                  max:=dd[i].sl;
                  li:=i;
                  end;
           xet[li]:=false;
           chon[l].ka:=li;
           dd[li].sl:= dd[li].sl-1;
           for i:=1 to m do
               if i in dd[li].ma then
                  begin
                  ok:=true;
                  break;
                  end;
           if ok then
              begin
            chon[l].ma:=i;
            for j:=1 to k do
                begin
                if i in dd[j].ma then
                   begin
                dd[j].ma:=dd[j].ma-[i];
                dd[j].sl:=dd[j].sl-1;
                  end;
                end;
            end;
             inc(l);
           end;
     writeln(f,l-3);
         writeln(l-3);
     for i:=1 to l-3 do
         begin
         writeln(f,chon[i].ka,' ',chon[i].ma,' ');
         writeln(chon[i].ka,chon[i].ma:3);
         end;

end;

procedure inkq;
var
   i ,j  : word;

begin
     clrscr;
     assign(f,fo);
     rewrite(f);
     writeln('Ma may la');
     for i:=1 to m do
         writeln(ma[i]);
     writeln;
     writeln('Ma cua khach la');
     for i:=1 to k do
     write(ka[i]:2);
     writeln;
     makedt;
     xuli;
     close(f);
end;

begin
ini;
inkq;


readln;
end.
4 5
cd
ab
be
abc
acaad

20  15
IKLVX
KRTW
FRUW
OQY
FGHJOR
CFHJMPQX
HJNW
DFIRUY
ADFP
FQV
JPRT
DHIKMY
FGRSUW
FPSY
CFPRTXY
AGR
AEIKYZ
BFGKP
ADFGPRUX
FIJR
CCMCOBNQSQQMHFW


20  15
IKLVX
KRTW
FRUW
OQY
FGHJOR
CFHJMPQX
HJNW
DFIRUY
ADFP
FQV
JPRT
DHIKMY
FGRSUW
FPSY
CFPRTXY
AGR
AEIKYZ
BFGKP
ADFGPRUX
FIJR
CCMCOBNQSQQMHFW
