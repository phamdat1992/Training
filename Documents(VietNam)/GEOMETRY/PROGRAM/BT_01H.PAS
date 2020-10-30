const   fi		= 'gd.inp';
     	fo		= 'gd.out';
var     f		: text;
   		x,y 	: array['a'..'d'] of real;
   		a,b,c	: real;
procedure nhap;
var     c	: char;
	begin
		assign(f,fi);reset(f);
		for c:='a' to 'd' do readln(f,x[c],y[c]);
		close(f);
	end;
procedure ptdt(p,q:char;var a,b,c:real);
	begin
		a:=y[p]-y[q];b:=x[q]-x[p];c:=x[p]*y[q]-x[q]*y[p];
	end;
function khacphia(p,q:char;a,b,c:real):boolean;
	begin
		khacphia:=(a*x[p]+b*y[p]+c)*(a*x[q]+b*y[q]+c)<0;
	end;
procedure lam;
	begin
		assign(f,fo);rewrite(f);
		ptdt('a','b',a,b,c);
		if khacphia('c','d',a,b,c) then
   		begin
   			ptdt('c','d',a,b,c);
   			if khacphia('a','b',a,b,c) then
      		begin
      			writeln(f,1);
                close(f);
				exit;
      		end;
   		end;
		writeln(f,0);
		close(f);
	end;
BEGIN
	nhap;
	lam;
END.
