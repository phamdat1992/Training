uses crt;
const  fi='chungchi.in1';
       fo='chungchi.out';
var    a,b:array[0..20,0..20] of byte;
       sl1,sl2:array[0..20] of byte;
       luum,luun:array[0..20] of byte;
       th:array[0..20] of byte;
       ok:array[0..20] of boolean;
       sm,sc,tc,sl,minsl:byte;
       tap:set of byte;
       time1:longint;
       time2:longint absolute 0:$46c;
       f:text;

procedure  init;
begin
      time1:=time2;
      tap:=[];
      fillchar(a,sizeof(a),0);
      fillchar(b,sizeof(b),0);
      fillchar(sl1,sizeof(sl1),0);
      fillchar(luum,sizeof(luum),0);
      fillchar(th,sizeof(th),0);
      fillchar(sl2,sizeof(sl2),0);
end;

procedure  readfile;
var i,j:byte;
begin
      assign(f,fi);
      reset(f);
      sc:=0;
          readln(f,sm,tc);
          for i:=1 to sm do
            begin
                  j:=1;
                  while not eoln(f) do
                   begin
                        read(f,a[i,j]);
                        b[j,i]:=a[i,j];
                        inc(sl1[i],a[i,j]);
                        inc(sl2[j],a[i,j]);
                        inc(j);
                   end;
                   if sc=0 then sc:=j-1;
                   readln(f);
            end;
      fillchar(luun,sizeof(luun),0);
      sl:=0;minsl:=sm;
      close(f);
end;

function  maxmh:byte;
var  max,i,luu:byte;
begin
      max:=0;
      for i:=1 to sm do
       if not ok[i] then
         if sl1[i]>max then
           begin
                 max:=sl1[i];
                 luu:=i;
           end;
     maxmh:=luu;
end;

procedure  sort;
var i,k:byte;
begin
       fillchar(ok,sizeof(ok),0);
       i:=1;
       while i<=sm do
         begin
               k:=maxmh;
               th[i]:=k;
               ok[k]:=true;
               inc(i);
         end;
end;

function inside(i:byte):boolean;
var  j:byte;
begin
      inside:=false;
      for j:=1 to sm do
        if (b[i,j]=1) and  not (j in tap) then exit;
      inside:=true;
end;

function  sotc:byte;
var  dem,i:byte;
begin
      dem:=0;
      for i:=1 to sc do
        if inside(i) then inc(dem);
      sotc:=dem;
end;

procedure  ghi_nhan;
begin
      minsl:=sl;
      luun:=luum;
end;

procedure  xuat;
var i:byte;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,minsl);
     for i:=1 to minsl do  write(f,th[luun[i]],' ');
     close(f);
     halt;
end;

procedure  try;
var  i:byte;
begin
      if ((time2-time1)/18.21)>=5 then xuat
	  else
      begin
      for i:=luum[sl]+1 to sm do
        if ok[th[i]] then
          begin
               inc(sl);
               luum[sl]:=i;
               tap:=tap+[th[i]];
               ok[th[i]]:=false;
               if (sotc>=tc) and (sl<minsl) then ghi_nhan
               else  if sl<minsl then try;
               dec(sl);
               ok[th[i]]:=true;
               tap:=tap-[th[i]];
          end;
    end;
end;

begin clrscr;
  init;
  readfile;
  sort;
  try;
  xuat;
end.

