uses crt;
const  fi='xoso.inp';
       fo='xoso.out';
       maxtime=10;
var    a:array[0..100,0..11] of byte;
       ok:array[0..51] of boolean;
       m,n,k:byte;
       diem:integer;
       b:array[0..11] of byte;
       f:text;
       time1:longint;
       time2:longint absolute  0:$46c;
       logic:array[0..101,0..51] of boolean;

procedure  init;
begin
      time2:=time1;
      fillchar(a,sizeof(a),0);
      fillchar(b,sizeof(b),0);
      fillchar(ok,sizeof(ok),true);
      fillchar(logic,sizeof(logic),false);
      diem:=0;
end;

procedure   readfile;
var   i,j:byte;
begin
       assign(f,fi);
       reset(f);
           readln(f,n,m,k);
           for i:=1 to n do
             begin
                   for j:=1 to k do begin read(f,a[i,j]);logic[i,a[i,j]]:=true;end;
                   read(f,a[i,k+1]);
                   inc(diem,a[i,k+1]);
             end;
             for i:=1 to n do
               if a[i,k+1]=0 then
                 for j:=1 to k do ok[a[i,j]]:=false;
       close(f);
end;

function  oko(i,j:byte):boolean;
var  k1:byte;
begin
     oko:=false;
           if (a[j,k+1]=0) and logic[j,i] then  exit;
     oko:=true;
end;

function  chapnhan(j:byte):boolean;
var  l:byte;
begin
      chapnhan:=false;
      for l:=1 to n do
        if not oko(j,l) then exit;
      chapnhan:=true;
end;

procedure rutgon(j:byte);
var  i:byte;
begin
      for  i:=1 to n do
        if logic[i,j] then
		  begin
		        dec(a[i,k+1]);
                dec(diem);
          end;
end;

procedure morong(j:byte);
var  i:byte;
begin
      for  i:=1 to n do
        if logic[i,j] then
          begin
		       inc(a[i,k+1]);
               inc(diem);
          end;
end;

procedure  xuat;
var  d:byte;
begin
       for d:=1 to k do write(f,b[d]:4);
       writeln(f);
end;

procedure  try(i:byte);
var   j:byte;
begin
      if  (time2-time1)/18.21>=maxtime then begin close(f);halt;end;
      for j:=b[i-1]+1 to m do
        if ok[j]  and chapnhan(j)  then
           begin
                 b[i]:=j;
                 ok[j]:=false;
                 rutgon(j);
                 if (diem=0) and (i=k) then xuat
                 else if i<k then try(i+1);
                 ok[j]:=true;
                 morong(J);
           end;
end;

procedure  main;
begin
     init;
     readfile;
     assign(f,fo);
     rewrite(f);
     try(1);
     close(f);
end;

begin
       main;
end.