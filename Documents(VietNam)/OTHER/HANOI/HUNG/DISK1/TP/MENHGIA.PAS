uses crt;
const  fi='menhgia.inp';
       fo='menhgia.out';
       maxsl=30000;
type   mang=array[0..30000] of byte;
       mang2=array[0..100] of word;
var    sl,gt:array[0..100] of word;
       mind:array[0..30000] of word;
       fr:^mang;
       luu:^mang2;
       n:byte;
       m:word;
       f,f1:text;

procedure init;
var  i:word;
begin
      fillchar(mind,sizeof(mind),0);
      fillchar(sl,sizeof(sl),0);
      fillchar(gt,sizeof(gt),0);
      new(luu);
      fillchar(luu^,sizeof(luu^),0);
      mind[0]:=1;
      new(fr) ;
      fillchar(fr^,sizeof(fr^),0);
      for i:=1 to maxsl do fr^[i]:=1;
end;

procedure  readfile;
var  i:byte;
begin
      assign(f,fi);
      reset(f);
          readln(f,n,m);
          for i:=1 to n do readln(f,sl[i],gt[i]);
      close(f);
end;

procedure   process;
var i,j,k,tong:longint;
begin
     i:=1;j:=0;
     tong:=0;
     repeat;
           inc(j);
           if j>sl[i] then begin j:=1;inc(i); end ;
           inc(tong,gt[i]);
           if tong > maxsl then tong:=maxsl;
           for k:=gt[i] to tong do
               if (mind[k-gt[i]]>0) and ((mind[k]=0) or (mind[k]>mind[k-gt[i]]+1)) then
               begin
                    mind[k]:=mind[k-gt[i]]+1;
                    fr^[k]:=i;
               end;
     until (j>=sl[i]) and (i>=n);
end;


procedure  try(i:word);
begin
      if fr^[i] >0 then
        begin
              try(i-gt[fr^[i]]);
              inc(luu^[fr^[i]]);
	    end;
end;

procedure result;
var  i:word;
begin
     assign(f1,fo);
     rewrite(f1);
     try(m);
     writeln(f1,mind[m]-1);
     for i:=1 to n do if luu^[i]>0 then
       writeln(f1,gt[i],'  ',luu^[i]);
     close(f1);
     dispose(fr);
     dispose(luu);
end;

procedure  main;
begin
     init;
     readfile;
     process;
     result;
end;

begin  clrscr;
     main;
end.

