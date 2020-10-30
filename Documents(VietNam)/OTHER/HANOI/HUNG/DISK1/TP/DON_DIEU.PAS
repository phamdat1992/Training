Uses crt;
const fi='don_dieu.inp';
      fo='don_dieu.out';
var   a,maxd1,fro1,maxd2,fro2,sl,arr:array[0..1000] of integer;
      m,n,luu,max:integer;
      f:text;

procedure  readfile;
var  i:integer;
begin
     fillchar(a,sizeof(a),0);
     arr:=a;
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do
      begin
        read(f,a[i]);
        arr[i]:=a[i]-a[i-1];
      end;
end;

function  Dem_don_dieu:byte;
var  i,dem:byte;
begin
     i:=1;dem:=0;
     fillchar(sl,sizeof(sl),0);
     while i<n do
      begin
           inc(sl[dem]);
           if (a[i]>=a[i-1]) and (a[i]>a[i+1]) then inc(dem);
           if (a[i]<a[i-1]) and (a[i]<a[i+1]) then  inc(dem);
           inc(i);
      end;
      for i:=1 to dem do write(sl[i],' ');
      writeln;
      dem_don_dieu:=dem;
end;

procedure bot_phan_tu1;
var  i:byte;
begin
     i:=1;
     while I<n do
      begin
           if (a[i]<a[i-1]) and (a[i]<a[i+1]) then write(a[i],'  ');
           if (a[i]>a[i+1]) and (a[i]>a[i-1]) then write(a[i],'  ');
           inc(i);
      end;
      write(a[n]);
end;

procedure  cau_3;
var   i,j:byte;
begin
     fillchar(maxd1,sizeof(maxd1),0);
     fro1:=maxd1;maxd2:=maxd1;fro2:=fro1;
     for i:=2 to n do
      for j:=1 to i-1 do
          if a[j]<=a[i] then
             if (maxd1[i]=0) or (maxd1[i]<maxd1[j]+1) then
              begin
                   maxd1[i]:=maxd1[j]+1;
                   fro1[i]:=j;
              end;
        for i:=n downto 1 do
         for j:=i+1 to n do
           if a[j]>=a[i] then
             if (maxd2[i]=0) or (maxd2[i]<maxd2[j]+1) then
              begin
                   maxd2[i]:=maxd2[j]+1;
                   fro2[i]:=j;
              end;
end;

procedure  tim_max;
var  i:byte;
begin
     max:=0;
     for i:=1 to n do
      begin
        if maxd1[i]>max then begin max:=maxd1[i];luu:=i;end;
        if maxd2[i]>max then begin max:=maxd2[i];luu:=-i;end;
      end;
end;

procedure init_xuat;
begin
     if luu<0 then
     begin
       maxd1:=maxd2;
       fro1:=fro2;luu:=abs(luu);
     end;
end;

procedure  xuat3;
begin
     tim_max;init_xuat;
     writeln(max+1);
     while fro1[luu]>0 do
      begin
           write(a[luu],'  ');
           luu:=fro1[luu];
      end;
      write(a[luu],'  ');
end;

procedure  cau4;
begin

end;

begin  clrscr;
     readfile;
     writeln(dem_don_dieu);
     {bot_phan_tu1;
     writeln;}
     cau_3;xuat3;
     readln
end.


