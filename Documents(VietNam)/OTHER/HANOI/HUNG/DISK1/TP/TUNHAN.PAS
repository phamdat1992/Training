uses crt;
const  fi='tu.inp';
       fo='tu.out';
type   mang=array[1..3] of word;
       mang1=array[0..10000] of word;
var    q:array[0..10000] of mang;
       fr:^mang;
       n,last,first,dem:longint;
       dk:boolean;
       f,f1:text;

procedure  init;
begin
       fillchar(q,sizeof(q),0);
       fillchar(fr^,sizeof(fr^),0);
	   last:=1;first:=0;
       dem:=0;
       new(fr);
end;

procedure    readfile;
begin
       assign(f,fi);
       reset(f);
          readln(f,q[1][1],q[1][2],q[1][3]);
       close(f);
end;

procedure  pop(var a:mang);
begin
      inc(first);
      a:=q[first]
end ;

procedure get(a:mang);
begin
      inc(last);
      q[last]:=a;
end ;

function bang(a,b:mang):boolean;
var  t1,t2: set of byte;
begin
      bang:=true;
      t1:=[a[1],a[2],a[3]];
      t2:=[b[1],b[2],b[3]];
      if t1=t2 then exit;
      bang:=false;
end;

function  ok(a:mang):boolean;
var  i:longint;
begin
      ok:=false;
          for i:=1 to last do
           if bang(q[last],a) then exit;
      ok:=true;
end;

procedure  xuat(i:longint);
begin
      inc(dem);
      if i>1 then
        begin
             xuat(fr^[i]);
             writeln(f1,q[i][1],'  ',q[i][2],'  ',q[i][3])
        end
      else
	  begin
              writeln(f1,dem);
	          writeln(f1,q[1][1],'  ',q[1][2],'  ',q[1][3]);
      end;
end;

procedure  xuli(i,j:byte;a:mang);
var  b:mang;
begin
       b:=a;
       if b[i]>=b[j] then
         begin
              b[i]:=b[i]-b[j];
              b[j]:=2*b[j];
         end
      else
         begin
              b[j]:=b[j]-b[i];
              b[i]:=2*b[i];
         end;
    if ok(b)  then
    begin
	        get(b);
            fr^[last]:=first;
            if last mod 1000=0 then writeln(last);
            if (b[1]=0) or (b[2]=0) or (b[3]=0) then begin xuat(last);close(f1);dispose(fr);halt;end;
    end;
end;

procedure  loang(a:mang);
var i,j:byte;
begin
      for i:=1 to 2 do
         for j:=i+1 to 3 do xuli(i,j,a);
end;

procedure  main;
var a:mang;
begin
      assign(f1,fo);
      rewrite(f1);
      repeat
             pop(a);
             loang(a);
      until  first>last;
      close(f1);
end;

begin  clrscr;
  init;
  readfile;
  main;
end.

