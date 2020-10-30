const  fi='period.inp';
       fo='period.out';
var    a,b:array[0..1000] of longint;
       mg:array[0..10000] of longint;
       m,n,slmin:longint;
       f:text;

procedure  init;
begin
    fillchar(a,sizeof(a),0);
    fillchar(b,sizeof(b),0);
end;

procedure  readfile;
var  i:longint;
begin
      assign(f,fi);
      reset(f);
         readln(f,m);
         for i:=1 to m do read(f,a[i]);readln(f);
         readln(f,n);
         for i:=1 to n do read(f,b[i]);
      close(f);
end;

function ok(w,d:longint):longint;
var  i:longint;
begin
      ok:=0;
      for i:=1 to d do
	   if  mg[i]=w then
          begin
               ok:=i;
               exit;
          end;
end;

function chuki(i:integer):longint;
var d,j,w:longint;
    dk:boolean;
begin
      fillchar(mg,sizeof(mg),0);
      d:=1;
      mg[d]:=b[i];
      w:=a[b[i]];
      dk:=true;
      while dk do
	     begin
                j:=ok(w,d);
                if j=0 then
                begin
                      inc(d);
                      mg[d]:=w;
		      w:=a[w];
                end
               else
                   begin
                         dk:=false;
                         slmin:=j-1;
                   end;
		 end;
      chuki:=d+1-j;
end;

function  ucln(i,j:longint):longint;
begin
      while (i mod j<> 0 ) and (j mod i<>0) do
       begin
             if i>j then i:=i mod j
             else j:=j mod i;
       end;
       if i mod j=0 then ucln:=j
       else  ucln:=j;
end;

function bcnn(i,j:longint):longint;
begin
     bcnn:=i*j div ucln(i,j);
end;

function  max(i,j:longint):longint;
begin
     max:=i;
     if j>i then max:=j;
end;

procedure  xuli;
var  k,i,slm:longint;
begin
      k:=chuki(1);
      slm:=slmin;
      for i:=2 to n do
      begin
	        k:=bcnn(k,chuki(i));
                slm:=max(slm,slmin);
      end;
      assign(f,fo);
      rewrite(f);
      writeln(f,slm,'  ',k);
      close(f);
end;

procedure  main;
begin
     init;
     readfile;
     xuli;
end;

begin
      main;
end.



