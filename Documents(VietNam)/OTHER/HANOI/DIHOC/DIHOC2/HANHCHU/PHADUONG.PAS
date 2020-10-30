uses crt;
const fi='phaduong.inp';
      fo='phaduong.out';
var   a:array[1..30,1..30] of 0..1;
      luu:array[0..30] of byte;
      ok:array[0..30] of boolean;
      dd:array[0..30,0..30] of 0..1;
      lp:array[1..100,1..100] of byte;
      dem,s,t:byte;
      n:byte;
      sl:longint;
      dk:boolean;
      f:text;

procedure   readfile;
var  i,j:byte;
begin
      assign(f,fi);
      reset(f);
          readln(f,n);
          for i:=1 to n-1 do
             for j:=i+1 to n do
                 begin
                      read(f,a[i,j]);
                      a[j,i]:=a[i,j];
                 end;
      close(f);
end;

procedure   ghi_nhan;
var  i:byte;
begin
      for i:=1 to dem-1 do
       begin
            dd[luu[i],luu[i+1]]:=1;
            dd[luu[i+1],luu[i]]:=1;
       end;
end;

procedure  try(i:byte);
var  j:byte;
begin
      for j:=2 to n do
        if ok[j] and (a[j,luu[dem]]=1) then
           begin
                 ok[j]:=false;
                 inc(dem);
                 luu[dem]:=j;
                 if j = n then ghi_nhan
                 else  try(i+1);
                 dec(dem);
                 ok[j]:=true;
		   end;
end;

procedure  khoitao;
begin
    fillchar(ok,sizeof(ok),true);
    ok[1]:=false;
    readfile;
    fillchar(dd,sizeof(dd),0);
    fillchar(lp,sizeof(lp),0);
    dem:=1;
    luu[dem]:=1;
    try(1);
end;

procedure lop(i,j:byte);
var  l:byte;
begin
      for l:=1 to n do
        if (lp[l,i]>0) and ((lp[i,j]=0) or (lp[i,j]>lp[l,i]+1))  then
           lp[i,j]:=lp[l,i]+1;
end;

procedure   phanlop;
var  i,j:byte;
begin
      fillchar(lp,sizeof(lp),0);
      for i:=2 to n do
        if a[1,i]=1 then lp[1,i]:=1;
      for i:=1 to n-1 do
        for j:=2 to n-1 do
          if a[i,j]>0 then  lop(i,j);
end;

procedure  chon;
var  i,j,max,min,k,dem,luu:byte;
begin
      max:=0;
      min:=100;
      for i:=1 to n do
        for j:=1 to n do
          if lp[i,j]>max then max:=lp[i,j];
       for i:=1 to n-1 do
         if a[i,n]=1 then lp[i,n]:=max+1;
		 inc(max);
      for k:=1 to max do
        begin
              dem:=0;
              for i:=1 to n-1 do
                for j:=i+1 to n do
                  if lp[i,j]=k then inc(dem);
              if dem<min then begin  min:=dem;luu:=k;end;
        end;
        writeln(min);
        for i:=1 to n-1 do
          for j:=i+1 to n do
            if lp[i,j]=luu then writeln(i,'  ',j );
end;

procedure  ghinhan1;
var    i:byte;
begin
      for i:=1 to dem-1 do
        if (luu[i]=s) and (luu[i]=t) then begin inc(sl);exit;end;
end;

procedure  try1(i:byte);
var  j:byte;
begin
      for j:=1 to n do
        if ok[j] and (a[j,luu[dem]]=1) then
           begin
                 ok[j]:=false;
                 inc(dem);
                 luu[dem]:=j;
                 if j = n then ghi_nhan
                 else  try(i+1);
                 dec(dem);
                 ok[j]:=true;
		   end;
end;

begin  clrscr;
  khoitao;
  phanlop;
  chon;
end.

6
1 1 0 0 0
0 0 1 0
1 0 1
0 1
1