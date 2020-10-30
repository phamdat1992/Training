uses crt;
const  fi='ghepgo.inp';
       fo='ghepgo.out';
var    a:array[0..1000] of integer;
       mind:array[0..15000] of integer;
       fr:array[0..15000] of integer;
       min,dem,tong,n:integer;
       tap:set of byte;
       dk:boolean;
       f,f1:text;

procedure  init;
begin
     fillchar(a,sizeof(a),0);
     dem:=0;
     tap:=[];
end;

procedure  readfile;
var  i:integer;
begin
       assign(f,fi);
       reset(f);
        readln(f,n);
        tong:=0;
        min:=0;
        for i:=1 to n do
        begin
		     read(f,a[i]);
             if min<a[i]  then min:=a[i];
             inc(tong,a[i]);
        end;
       close(f);
end;

procedure  sort;
var  i,j,tg:integer;
begin
     for i:=1 to n -1 do
      for j:=i+1 to n do
       if a[i]>a[j] then
         begin
               tg:=a[i];
               a[i]:=a[j];
               a[j]:=tg;
         end;
end;

procedure  khoitao;
begin
     fillchar(mind,sizeof(mind),0);
     mind[0]:=1;
     fillchar(fr,sizeof(fr),0);
end;

procedure  xuat;
var i:integer;
begin
      i:=min;
      if mind[i]>1 then
      begin
      repeat
             write(f1,a[fr[i]],'  ');
             if not ( fr[i] in tap) then tap:=tap+[fr[i]];
             i:=i-a[fr[i]];
             inc(dem);
      until  i<=0;
      writeln(f1);
      end
      else  begin dk:=false;rewrite(f1);dem:=0;end;
end;

procedure  xuli;
var  i,j,max:integer;
begin
      max:=0;
      for i:=1 to n do
       if not (i in tap) then
           begin
                 max:=max+a[i];
          {       for j:=1 to max do write(mind[j],'  ');readln;}
                 for j:=a[i] to max do
                   if mind[j-a[i]]>0 then
                     if (mind[j]=0) or (mind[j]>mind[j-a[i]]+1) then
                       begin
                              mind[j]:=mind[j-a[i]]+1;
                              fr[j]:=i;
                       end;
           end;
end;

procedure  xu;
var  i:integer;
begin
      assign(f1,fo);
      rewrite(f1);
      repeat
            if tong mod min = 0 then
              begin
                    dk:=true;
                    writeln(f1,min);
                    tap:=[];
                    while (dem<=n) and (dk) do
                    begin
                          khoitao;
					      xuli;
                          xuat;
                    if dem>=n then  begin  close(f1);halt; end;
                    end;
              end;
              inc(min);
      until min>tong;
    close(f1);
end;

begin  clrscr;
  init;
  readfile;
  sort;
  xu;
end.

7
8 3 2 1 9 10 11