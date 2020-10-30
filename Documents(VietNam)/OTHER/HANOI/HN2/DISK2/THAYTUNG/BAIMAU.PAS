const   fi='bai.inp';
        fo='bai.out';
type    mangs=array[0..100] of byte;
var     a:array[0..100,0..100] of byte;
        b,luu:mangs;
        m,n:byte;
        f,f1:text;

procedure  init;
begin
     fillchar(a,sizeof(a),0);
     fillchar(luu,sizeof(luu),0);
     b:=luu;
end;

procedure  readfile;
var  i,j,ik:byte;
begin
      assign(f,fi);
      reset(f);
      readln(f,n);
      for i:=1 to n do
        begin
              J:=1;
              read(f,a[i,0],a[i,1]);
              while not eof(f) do
                begin
                      read(f,ik);
                      if ik=a[i,j] then dec(a[i,0])
                      else
                        begin
                              inc(j);
                              a[i,j]:=ik;
                        end;
                end;
                luu[i]:=1;
        end;
      close(f);
end;

function  demlt:byte;
var
     i,j,dem,j1:byte;
begin
     fillchar(b,sizeof(b),0);
     for i:=1 to n do b[i]:=1;
     dem:=0;
   repeat
       j1:=1;
       while ( b[j1]>a[j1,0] ) and ( j1<=n ) do inc(j1);
       if j1<=n then
       begin
         j:=j1;
         repeat
              while (a[j,b[j]]=a[j+1,b[j+1]]) and (j<n) do
                begin
                      inc(j);
                      dec(b[j]);
                      dec(b[j+1]);
                end;
              inc(dem);
         until j>=n;
       end;
   until j1>n;
   demlt:=dem;
end;

procedure  xoa(i:byte;mg:mangs);
begin
      while a[i+1,mg[i+1]]=a[i,mg[i]] do
        begin
              inc(mg[i]);
        end;
end;

Function chon:byte;
var  i,luu1,min,k:byte;
begin
      min:=200;
      luu1:=0;
      b:=luu;
      for i:=1 to n do
        begin
              xoa(i,b);
              k:=demlt;
              if k<min then begin min:=k ;luu1:=i;end;
        end;
end;

function ketthuc:boolean;
var  i:byte;
begin
     ketthuc:=false;
       for i:=1 to n do
        if luu[i]<=a[i,0] then exit;
     ketthuc:=true;
end;

procedure  xuli;
var  k,dem:byte;
begin
       dem:=0;
       repeat
              inc(dem);
              k:=chon;
              xoa(k,luu);
       until  ketthuc;
       writeln(dem);
end;

begin
init;
readfile;
xuli;
end.