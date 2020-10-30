uses crt;
const  fi='latinh.inp';
       fo='latinh.out';
       tong:array[3..5] of integer=(15,34,65);
var    a:array[0..5,0..5] of byte;
       dong,cot:array[0..5]of integer;
       time1:longint;
       time2:longint  absolute 0:$46c;
       n,m:byte;
       cheo1,cheo2:integer;
       ok:array[0..25] of boolean;
       f,f1:text;

procedure  init;
begin
      time1:=time2;
      fillchar(a,sizeof(a),0);
      fillchar(dong,sizeof(dong),0);
      fillchar(cot,sizeof(cot),0);
      fillchar(ok,sizeof(ok),true);
end;

procedure  readfile;
var  i,j,k,l:byte;
begin
     assign(f,fi);
     reset(f);
     readln(f,n,m);
        for i:=1 to m do
              begin
			        readln(f,j,k,l);
                    a[j,k]:=l;
                    inc(dong[j],l);
                    inc(cot[k],l);
                    ok[l]:=false;
                    if k=j then inc(cheo1,l);
                    if k+j=n+1 then inc(cheo2,l);
              end;
     close(f);
end;

function  dienduoc(i,j,k:byte):boolean;
begin
       dienduoc:=false;
         if ok[k]=false then exit;
         if dong[i]+k>tong[n] then exit;
         if cot[j]+k>tong[n] then exit;
         if (i=j) and (cheo1+k>tong[n]) then exit;
         if (i+j=n+1) and (cheo2+k>tong[n]) then exit;
       dienduoc:=true;
end;

function  daydong(i:byte):boolean;
var  j:byte;
begin
      daydong:=false;
        for j:=1 to n do if a[i,j]=0 then exit;
      daydong:=true;
end;

function  daycot(i:byte):boolean;
var  j:byte;
begin
      daycot:=false;
         for j:=1 to n do if a[j,i]=0 then exit;
      daycot:=true;
end;

function  kiemtra:boolean;
var i:byte;
begin
      kiemtra:=false;
      for i:=1 to n do
        begin
              if daydong(i) and (dong[i]<tong[n]) then exit;
              if daycot(i) and (cot[i]<tong[n]) then exit;
        end;
      kiemtra:=true;
end;

function sedien(i,j:byte):boolean;
var  k,l:byte;
begin
      sedien:=false;
      if i>1 then
      for k:=1 to i-1 do
       	for l:=1 to n do
        if a[k,l]=0 then exit;
      if j>1 then
      for k:=1 to j-1 do
       if a[i,k]=0 then exit;
      sedien:=true;
end;

procedure  xuat;
var  i,j:byte;
begin
      for i:=1 to n do
        begin
              for j:=1 to n do write(a[i,j]:4);
              writeln;
        end;
        readln;
end;

procedure  dien(i,j:byte);
var  l:byte;
begin
              if a[i,j]<>0 then dien(i+j div n ,j mod n +1)
              else
                begin
                     for l:=1 to tong[n]-dong[i] do
                      if sedien(i,j) and  dienduoc(i,j,l) then
                          begin
                                a[i,j]:=l;
                                ok[l]:=false;
                                inc(dong[i],a[i,j]);
                                inc(cot[j],a[i,j]);
                                if i=j then inc(cheo1,a[i,j]);
                                if i+j=n+1 then inc(cheo2,a[i,j]);
                                if (i*j=n*n) then begin writeln('dien duoc:');
                                xuat;
								readln;halt;end
                                else
                                if kiemtra then dien(i+j div n ,j mod n +1);
                                ok[l]:=true;
                                dec(dong[i],a[i,j]);
                                dec(cot[j],a[i,j]);
                                if i=j then dec(cheo1,a[i,j]);
                                if i+j=n+1 then dec(cheo2,a[i,j]);
                                a[i,j]:=0;
                          end;
                end ;
end;

begin  clrscr;
   init;
   readfile;
   dien(1,1);
end.

3
8 1 0
3 0 0
0 0 0