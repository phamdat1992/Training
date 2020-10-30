{$M 65000,0,655360}
const
     fi='nh3.dat';
     fo='gp.dat';
type
   nh=array[1..10000] of word;
   nhb=array[1..10000] of byte;
var
   giu,kq1,kq2:nh;
   gn:^nhb;
   vong:^nh;
   n,k,maxk:word;
   f:text;
procedure nhap;
var
   i:word;
begin
     fillchar(giu,sizeof(giu),0);
     assign(f,fi);reset(f);
     readln(f,n);
     for i:=1 to n do read(f,giu[i]);
     close(f);
end;

procedure xuly;
var
   i,j,tg,r,s:word;
begin
     assign(f,fo);
     rewrite(f);
     new(gn);
     new(vong);
     maxk:=0;
     fillchar(gn^,sizeof(gn^),0);
     fillchar(kq1,sizeof(kq1),0);
     fillchar(kq2,sizeof(kq2),0);
     i:=1;
     while i<=n do
     begin
          if gn^[i]=0 then
          begin
               j:=i;
               fillchar(vong^,sizeof(vong^),0);
               k:=1;
               vong^[k]:=j;
               gn^[j]:=1;
               while (giu[j]<>i) do
               begin
                    inc(k);
                    vong^[k]:=giu[j];
                    j:=giu[j];
                    gn^[j]:=1;
               end;
               if k=1 then
               begin
                    kq1[i]:=i;
                    kq2[i]:=i;
               end;
               if k=2 then
               begin
                    maxk:=1;
                    kq1[i]:=vong^[k];
                    kq2[i]:=kq1[i];
                    kq1[vong^[k]]:=i;
                    kq2[vong^[k]]:=kq1[vong^[k]];
               end;
               if k>=3 then
               begin
                    maxk:=2;
                    r:=1;
                    s:=k;
                    while r<s do
                    begin
                         kq1[vong^[r]]:=vong^[s];
                         kq1[vong^[s]]:=vong^[r];
                         inc(r);
                         dec(s);
                    end;
                    if r=s then kq1[vong^[r]]:=vong^[r];
                    kq2[i]:=i;
                    r:=2;
                    s:=k;
                    while r<s do
                    begin
                         kq2[vong^[r]]:=vong^[s];
                         kq2[vong^[s]]:=vong^[r];
                         inc(r);
                         dec(s);
                    end;
                    if r=s then kq2[vong^[r]]:=vong^[r];
               end;
          end;
          inc(i);
     end;
     if maxk=0 then writeln(f,0);
     if maxk=1 then
     begin
          writeln(f,maxk);
          for i:=1 to n do
          begin
               write(f,kq1[i]:8);
               if i mod 10 = 0 then writeln(f);
          end;
     end;
     if maxk=2 then
     begin
          writeln(f,maxk);
          for i:=1 to n do
          begin
                write(f,kq1[i]:8);
                if i mod 10 = 0 then writeln(f);
          end;
          if i mod 10<>0 then writeln(f);
          for i:=1 to n do
          begin
               write(f,kq2[i]:8);
               if i mod 10 = 0 then writeln(f);
          end;
          if i mod 10<>0 then writeln(f);
     end;
     dispose(gn);
     dispose(vong);
     close(f);
end;

BEGIN
     nhap;
     xuly;
END.
