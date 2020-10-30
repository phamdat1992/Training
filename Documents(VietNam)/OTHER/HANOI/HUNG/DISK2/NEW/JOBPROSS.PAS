 uses crt;
 type mang=array[1..30] of byte;
 var a,b,timea,timeb:mang;
 n,i,j,luu,m1,m2,timeaa,timebb:longint;
 fn:text;
 t1:longint absolute 0:$46c;
 t2:longint;
 dk1,dk2:boolean;

 procedure  readfile;
 var i,j:byte;
 begin
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
     assign(fn,'inp.job');
     reset(fn);
     readln(fn,n);
     readln(fn,m1);
     writeln(n);
     writeln(m1);
     for i:=1 to m1 do begin read(fn,a[i]);write(a[i],' ');end;
     readln(fn);
     writeln;
     readln(fn,m2);writeln(m2);
     for i:=1 to m2 do begin read(fn,b[i]);write(b[i],' ');end;
     close(fn);
   end;

 procedure sort;
 var i,j,tg:byte;
 begin
    for i:=1 to m1-1 do
       for j:=1+i to m1 do
         if a[i]>a[j] then begin tg:=a[i];a[i]:=a[j];a[j]:=tg;end;
   for i:=1 to m2-1 do
 for j:=1+i to m2 do
     if b[i]>b[j] then begin tg:=b[i];b[i]:=b[j];b[j]:=tg;end;
 end;

 begin clrscr;
 writeln('INPUT:');
 readfile;writeln;
 sort;
 t2:=t1;
 fillchar(timeb,sizeof(timeb),0);
 timea:=timeb;
  i:=1;
  while (i<=m1) and (n>0) do
    begin timea[i]:=a[i];dec(n); inc(i);end;
      luu:=0; timeaa:=0;timebb:=0;
       repeat
       dk1:=false; dk2:=false;
        for i:=1 to m1 do
        begin
        if timea[i]>0 then
           begin
                 dec(timea[i]);
                   if timea[i]=0 then
                     begin   j:=1;
                      while  ( j<=m2 ) and (timeb[j]>0) do inc(j);
                        if j<=m2 then   timeb[j]:=b[j]
                        else inc(luu);
                        if n>0 then begin dec(n);timea[i]:=a[i];end;
                     end;
              dk1:=true;
           end;
       end;
  for i:=1 to m2 do
     begin
           if (timeb[i]=0) and ( luu>0) then begin timeb[i]:=b[i];dec(luu);dk2:=true;end
           else
            if timeb[i]>0 then
              begin dec(timeb[i]);
                    if timeb[i]=0 then
                      if luu>0 then begin dec(luu);timeb[i]:=b[i];end;
                    dk2:=true;
              end;
     end;
    if dk1 then inc(timeaa);
    if  dk2 or dk1 then inc(timebb);
   until (dk2=false) and (dk1=false);
   writeln('OUTPUT');
   writeln(timeaa,'  ',timebb);
   writeln('TIME RUN:',((t1-t2)/18.21):6:6);
   readln
   end.
   8 4 6
   4 4 5 4
   3 4 5 3 8 4

5 3 3
1 1 2
3 1 4
100 7 8
1 4 5 6 10 3 7
4 5 6 8 7 12 13 15
900000
14
90 80 70 10 13 25 24 81 21 34 64 87 95 114
11
30 80 100 101 54 68 79 120 50 18 19







