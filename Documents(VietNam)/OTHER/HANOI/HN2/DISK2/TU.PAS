uses crt;
const
     fi='tu.inp';
     fo='tu.out';
type
    kpt=array[1..3] of word;
var
   q:array[0..10000] of kpt;
   fr:^kpt;
   n,cuoi,dau,dem:longint;
   dk:boolean;
   f1:text;

procedure readf;
Var
   f:text;
begin
       assign(f,fi);
       reset(f);
       readln(f,q[1][1],q[1][2],q[1][3]);
       close(f);
end;

procedure init;
begin
       fillchar(q,sizeof(q),0);
       fillchar(fr^,sizeof(fr^),0);
	   cuoi:=1;dau:=0;
       dem:=0;
       new(fr);

       readf;
end;

procedure  lay(var a:kpt);
begin
      inc(dau);
      a:=q[dau]
end ;

procedure nap(a:kpt);
begin
      inc(cuoi);
      q[cuoi]:=a;
end ;

function ok(a,b:kpt):boolean;
var  t1,t2: set of byte;
begin
      ok:=true;
      t1:=[a[1],a[2],a[3]];
      t2:=[b[1],b[2],b[3]];
      if t1=t2 then exit;
      ok:=false;
end;

function ok2(a:kpt):boolean;
var  i:longint;
begin
      ok2:=false;
          for i:=1 to cuoi do
           if ok(q[cuoi],a) then exit;
      ok2:=true;
end;

procedure out(i:longint);
begin
      inc(dem);
      if i>1 then
        begin
             out(fr^[i]);
             writeln(f1,q[i][1],'  ',q[i][2],'  ',q[i][3])
        end
      else
	  begin
           writeln(f1,dem);
	       writeln(f1,q[1][1],'  ',q[1][2],'  ',q[1][3]);
      end;
end;

procedure  try(i,j:byte;a:kpt);
var  b:kpt;
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

    if ok2(b)  then
    begin
	        nap(b);
            fr^[cuoi]:=dau;
            if (b[1]=0) or (b[2]=0) or (b[3]=0) then
            begin
                 out(cuoi);
                 close(f1);
                 dispose(fr);
                 halt;
            end;
    end;
end;

procedure  xuly(a:kpt);
var i,j:byte;
begin
      for i:=1 to 2 do
         for j:=i+1 to 3 do try(i,j,a);
end;

procedure  main;
var a:kpt;
begin
      assign(f1,fo);
      rewrite(f1);
      repeat
             lay(a);
             xuly(a);
      until  dau>cuoi;
      close(f1);
end;

begin
     clrscr;
     init;
     main;
end.

