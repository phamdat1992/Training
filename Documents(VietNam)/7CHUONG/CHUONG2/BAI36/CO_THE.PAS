uses crt;
const   fi='chess.in1';
        fo='chess.out';
        b:array[1..4] of shortint=(1,-1,4,-4);
type    mang1=array[1..15000] of word;
        mang2=array[1..15000,1..2] of byte;
var     q:array[1..15000] of longint;
        lt:array[0..16] of longint;
        luu2:^mang2;
        luu1:^mang1;
        s1,s2:string;
        last,first,kq:longint;
        f:text;

procedure  readfile;
var  s3:string;
     i:byte;
begin
     assign(f,fi);
     reset(f);
     s1:='';s2:='';
     for i:=1 to 4 do
      begin
          readln(f,s3);
          s1:=s1+s3;
      end;
     for i:=1 to 4 do
      begin
          readln(f,s3);
          s2:=s2+s3;
      end;
     close(f);
end;

function  mu(i:byte):longint;
var  j:byte;
     d:longint;
begin
      d:=1;
      for j:=1 to i do d:=d*2;
      mu:=d;
end;

function giatri(st:string):longint;
var  i,gia:longint;
begin
       gia:=0;
       for i:=1 to length(st) do gia:=gia+(ord(st[i])-ord('0'))*mu(length(st)-i+1);
       giatri:=gia;
end;

procedure  init;
var i:byte;
begin
       for i:=0 to 16 do lt[i]:=mu(i);
       fillchar(q,sizeof(q),0);
       last:=1;first:=0;
       kq:=giatri(s2);
       q[1]:=giatri(s1);
       new(luu1);
       new(luu2);
       fillchar(luu1^,sizeof(luu1^),0);
       fillchar(luu2^,sizeof(luu2^),0);
end;

function  ok(i:longint):boolean;
var  j:longint;
begin
     ok:=false;
     for j:=1 to last do
       if q[j]=i then exit;
     ok:=true;
end;

function pop:longint;
var  l:longint;
begin
     inc(first);
     pop:=q[first];
end;

procedure  get(i:longint);
begin
     inc(last);
     q[last]:=i;
end;

procedure  xuat(i:longint);
begin
     while luu1^[i]>0 do
       begin
            writeln((luu2^[i,1]-1) div 4+1,'  ',(luu2^[i,1]-1) mod 4 +1,'  ',(luu2^[i,1]+b[luu2^[i,2]]-1) div 4+1,'  ',
			(luu2^[i,1]+b[luu2^[i,2]]-1) mod 4 +1);
            i:=luu1^[i];
       end;
      dispose(luu1);
      dispose(luu2);
      halt;
end;

function  oko(i,j:byte;w:LONGINT):boolean;
begin
      oko:=true;
      if  (w and lt[16-i-b[j]+1])=0 then
      begin
      if (j=1) and (i mod 4<>0) THEN exit;
      if (j=4) and (i>4) then exit;
      if (j=2) and (i mod 4<>1) then exit;
      if (j=3) and (i<13) then exit;
      end;
      oko:=false;
end;

procedure  xuli;
var u,w,wq,l:longint;
    i,j:byte;
begin
      repeat
             w:=pop;
             for i:=1 to 16 do
              if (w and lt[16-i+1])=lt[16-i+1] then
                for j:=1 to 4 do
                  if oko(i,j,w) then
               begin
                    u:=w-lt[16-i+1]+lt[16-i-b[j]+1];
                    if ok(u) then
                      begin
                            get(u);
                            luu1^[last]:=first;
                            luu2^[last,1]:=i;luu2^[last,2]:=j;
                            if u=kq then xuat(last);
                            if last mod 1000=0 then writeln(last);
                            if last>=15000 then halt;
                      end;
		   	   end;
      until last<1;
end;

begin  clrscr;
  readfile;
  init;
  xuli;
end.
1111
0000
1110
0010
1010
0101
1010
0101