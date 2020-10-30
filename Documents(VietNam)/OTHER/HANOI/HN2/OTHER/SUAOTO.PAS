
{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
   uses crt;
   type
       ptu=record
         t,s,d,chiso:integer;
      end;
   var     a:array[1..2000] of ptu;
           max,luu,front:array[1..2000] of integer;
           n,i:integer;f:text;
           time1:longint  absolute 0:$46c;
           time2:longint;

   procedure readfile;
   var i,j:integer; name:string;
   begin
     write('FIILNAME INPUT:');readln(name);
     time2:=time1;
    assign(f,name);
    reset(f);
    readln(f,n);
    for i:=1 to n do
     readln(f,a[i].s,a[i].d,a[i].t);
     close(f);
     for i:=1 to n do a[i].chiso:=i;
     writeln('INPUT:');
     writeln(n);
     for i:=1 to n do
     with a[i] do writeln(s:4,d:4,t:4);
   end;

   procedure sort;
   var i,j:integer;tg:ptu;
   begin
     for i:=1 to n-1 do
      for j:=1+i to n do
       if a[i].s>a[j].s then begin tg:=a[i];a[i]:=a[j];a[j]:=tg;end;
     for i:=1 to n-1 do
       begin  luu[i]:=2;
          while (luu[i]<=n)and(a[luu[i]].s<a[i].s+a[i].t) do inc(luu[i]);
       end;
    end;

   procedure  try;
   var  i,j,maxd:integer;
   begin
       for i:=n downto 1 do
        begin
           max[i]:=1;
           for j:=luu[i] to n do
            if max[j]+1>max[i] then begin max[i]:=max[j]+1;front[i]:=j;end;
        end;
        maxd:=0;
        for i:=1 to n do if max[i]>maxd then begin maxd:=max[i];j:=i;end;
        writeln('output');
        writeln(maxd-1);
         i:=0;
        while i<maxd-1 do
         begin writeln(a[j].chiso);
              a[j].chiso:=0;
              inc(i); j:=front[j];
         end;
         for i:=1 to n do
          if a[i].chiso<>0 then writeln(a[i].chiso);
   end;

   begin clrscr;
    fillchar(max,sizeof(max),0);
   readfile;
   sort;
   try;
   readln;
   end.
   6
   1 4 2
   3 8 2
   6 41 9
   3 54 8
   21 50 29
   50 65 3
