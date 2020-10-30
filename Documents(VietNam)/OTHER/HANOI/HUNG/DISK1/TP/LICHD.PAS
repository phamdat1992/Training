uses crt;
const fi='lich2.inp';
      fo='lichd.out';
type  ds=record
        p,d:longint;
      end;
var   a:array[1..2000] of ds;
      n:integer;
      f,f1:text;
      maxd,fro,timef:array[0..2000] of longint;
      chiso:array[0..2000] of integer;

procedure readfile;
var  i:integer;
begin
     fillchar(chiso,sizeof(chiso),0);
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do read(f,a[i].p);
     readln(f);
     for i:=1 to n do begin read(f,a[i].d);chiso[i]:=i;end;
     close(f);
end;

procedure quicksort(l,r:integer);
  var i,j,k:integer;x:longint;tg:ds;
  begin
      i:=l;j:=r;x:=a[(i+j) div 2].d;
    repeat
      while a[i].d<x do inc(i);
      while a[j].d>x do dec(j);
      if i<=j then
       begin
          k:=chiso[i];
          chiso[i]:=chiso[j];
          chiso[j]:=k;
          tg:=a[i];
          a[i]:=a[j];
          a[j]:=tg;
          inc(i);dec(j);
       end;
     until i>j;
     if i<r then quicksort(i,r);
     if j>l then quicksort(l,j);
  end;

procedure init;
var i:integer;
begin
     fillchar(maxd,sizeof(maxd),0);
     fro:=maxd;timef:=maxd;
     quicksort(1,n);
end;

procedure xuat;
var  i,max,luu:integer;
     bg:array[1..2000] of integer;
     logic:array[1..2000] of boolean;
begin
   fillchar(logic,sizeof(logic),true);
   assign(f1,fo);
   rewrite(f1);
   max:=0;
   fillchar(bg,sizeof(bg),0) ;
   for i:=1 to n do
    if maxd[i]>max then begin max:=maxd[i];luu:=i;end;
    writeln(f1,max); i:=max;
    while max>0 do
     begin
        bg[max]:=luu;
        logic[chiso[luu]]:=false;
        luu:=fro[luu];
        dec(max);
     end;
     max:=i;
     for i:=1 to max do write(f1,chiso[bg[i]],'  ');
     for i:=1 to n do if logic[i] then write(f1,i,'  ');
     close(f1);
end;

procedure  xuli;
var   i,j:integer;
begin
    for i:=1 to n do
      for j:=0 to i-1 do
       if timef[j]+a[i].p<=a[i].d then
         if (maxd[i]<maxd[j]+1) or ((maxd[i]=maxd[j]+1)  and (timef[i]>timef[j]+a[i].p)) then
           begin
                  maxd[i]:=maxd[j]+1;
                  fro[i]:=j;
                  timef[i]:=timef[j]+a[i].p;
           end;
        xuat;
end;

begin clrscr;
  readfile;
  init;
  xuli
end.
