{$r+}
uses 	crt;
const   dd:array[1..17] of integer=(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    	mes1	= 'H';
     	mes2	= 'MOVETO ';
     	mes3	= 'LT';
     	mes4	= 'RT';
     	mes5	= 'STOP';
     	fi		= 'robot5.inp';
     	fo		= 'robot.out';
type    th		= set of byte;
var     fin,fout	: text;
   		sd			: integer;
		found		: boolean;
   		a			: array[1..16,1..2] of integer;
   		qua			: array[1..17] of byte;

procedure init;
var  ir:integer;
begin
	fillchar(a,sizeof(a),0);
	fillchar(qua,sizeof(qua),0);
	assign(fin,fi);reset(fin);
	readln(fin,sd);
	for ir:=1 to sd do
		readln(fin,a[ir,1],a[ir,2]);
	close(fin);
end;

procedure xuly;
var
   	i,j,nr	: integer;
	s		: th;
   	cothe	: array[1..2,1..16] of integer;
   	chon	: byte;

   	function kc(p1,p2:integer):real;
    begin
        kc:=sqr(a[p1,2]-a[p2,2])+sqr(a[p1,1]-a[p2,1])
    end;{kc}

   	function quay(p1,p2,p3:integer):boolean;
   			{bang true <=> p1p2 vuong goc voi p2p3}
   	var  	at,bt,ct:real;
   	begin
   		at:=sqr(a[p1,1]-a[p2,1])+sqr(a[p1,2]-a[p2,2]);
   		bt:=sqr(a[p2,1]-a[p3,1])+sqr(a[p2,2]-a[p3,2]);
   		ct:=sqr(a[p1,1]-a[p3,1])+sqr(a[p1,2]-a[p3,2]);
   		quay:=at+bt-ct=0
   	end;{quay}

   	function thang(c1,c2,c3:integer):boolean;
    var  p1  : real;
   	begin
        p1 		:= (a[c1,1]-a[c2,1])*(a[c3,2]-a[c2,2]);
   		thang	:= p1=(a[c1,2]-a[c2,2])*(a[c3,1]-a[c2,1]);
   	end;

   	function ok(c1,c2,c3:integer):boolean;
   	{gia su c1, c2, c3 thang hang,
   	ok bang true <=> c2 nam giua c1 va c3}
   	var  o1,o2:boolean;
   	begin
	   	o1:=(a[c1,1]-a[c2,1])*(a[c3,1]-a[c2,1])<0;
   		o2:=(a[c1,2]-a[c2,2])*(a[c3,2]-a[c2,2])<0;
   		ok:=o1 or o2;
   	end;{ok}

   	procedure tim(p1,p2,n:integer);
   	{tim cac diem co the di chuyen den sau khi
   	di tu p1 den p2 o buoc thu n}
   	var id		: integer;
      	min,d	: real;
      	sd1		: th;
   	begin{tim}
   		sd1:=[];min:=1e38;
   		for id:=1 to sd do
   		if (not(id in [p1,p2]))and(quay(p1,p2,id)) then
       	begin
       		sd1:=sd1+[id];d:=kc(p2,id);
       		if d < min then begin min:=d;cothe[1,n]:=id end
       	end;
   		sd1:=sd1-[cothe[1,n]];
   		min:=1e38;
   		while (sd1<>[]) do
        for id:=1 to sd do if id in sd1 then
        if (ok(cothe[1,n],p2,id))and(kc(p2,id)< min) then
		begin cothe[2,n]:=id;min:=kc(p2,id);sd1:=sd1-[id];end
        else sd1:=sd1-[id];
   	end;{tim}

   	procedure viet;
   	var  it,u,v,z,t : integer;
   	begin
   		dd[sd+1]:=1;
   		writeln(fout,1);
   		write(fout,mes1,'      ');
   		writeln(fout,a[dd[2],1]:4,'     ' ,a[dd[2],2]:4);
   		write(fout,mes2);
   		writeln(fout,a[dd[2],1]:4,'     ' ,a[dd[2],2]:4);
   		for it:=3 to sd + 1 do
   		begin{for}
   			u:=a[dd[it-1],1]-a[dd[it-2],1];
   			v:=a[dd[it-1],2]-a[dd[it-2],2];
   			z:=a[dd[it],1]-a[dd[it-1],1];
   			t:=a[dd[it],2]-a[dd[it-1],2];
   			if u*t>z*v then
				writeln(fout,mes3)
			else writeln(fout,mes4);
   			write(fout,mes2);
   			writeln(fout,a[dd[it],1]:4,'     ' ,a[dd[it],2]:4);
   		end;
   	end;{viet}

	begin{xuly}
		s:=[];qua[1]:=1;
		nr :=2;	{nr la diem thu hai tren hanh trinh}
		while nr< sd do
      	begin
      		chon:=0;
      		for i:=2 to sd do
          	if (i<>nr) and thang(1,i,nr) and ok(1,i,nr) then
			begin chon:=1;break;end;
      		if chon=1 then inc(nr)
      		else
          	begin{else}
          		writeln(nr);
          		dd[2]:=nr;qua[nr]:=1;
          		fillchar(cothe,sizeof(cothe),0);
          		i :=2;
          		while i>1 do
          		begin
          			tim(dd[i-1],dd[i],i);
          			if (i=sd)and(1 in [cothe[1,i],cothe[2,i]]) then
					begin viet;found:=true;exit;end;
          			if (cothe[1,i]<>0) and (qua[cothe[1,i]]=1) then
						cothe[1,i]:=0;
          			if (cothe[2,i]<>0) and (qua[cothe[2,i]]=1) then
						cothe[2,i]:=0;
          			{quay lui}
          			while (i>1) and (cothe[1,i]=0) and (cothe[2,i]=0) do
                	begin qua[dd[i]]:=0;dd[i]:=0;i:=i-1;end;
          			if i>1 then
             		begin
             			inc(i);
             			if cothe[1,i-1]=0 then
	        			begin
							dd[i]:=cothe[2,i-1];
							qua[cothe[2,i-1]]:=1;
							cothe[2,i-1]:=0;
						end
             			else
             			begin
							dd[i]:=cothe[1,i-1];
							qua[cothe[1,i-1]]:=1;
							cothe[1,i-1]:=0
						end;
             		end;
          		end;{while i>1}
          		inc(nr);
      		end;{else}
		end;{while nr<sd}
	end;

BEGIN
	found:=false;
	assign(fout,fo);rewrite(fout);
	init;
	xuly;
	if found then
			writeln(fout,mes5)
	else 	writeln(fout,0);
	close(fout)
END.
