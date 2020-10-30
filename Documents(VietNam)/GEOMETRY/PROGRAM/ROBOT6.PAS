const   fi	= 'robot.in6';
     	fo	= 'robot.ou6';
var 	f	: text;
		a	: array[-101..101,-101..101] of byte;
   		s,shs,min	: longint;
   		tx,ty,px,py : longint;
   		t			: char;

procedure nhap;
var  	c	: char;k,i,x,y:longint;
	begin
		assign(f,fi+t);reset(f);
		fillchar(a,sizeof(a),0);
		readln(f,x,y);
		while not(seekeof(f)) do
      	begin
      		read(f,c);readln(f,k);
            case c of
            'U':
                for i:=1 to k do
                begin
                a[x,y]:=a[x,y] or 8;a[x-1,y]:=a[x-1,y] or 2;
                inc(y);
                end;
            'D':
                for i:=1 to k do
                begin
                a[x,y-1]:=a[x,y-1] or 8;a[x-1,y-1]:=a[x-1,y-1] or 2;
                dec(y);
                end;
            'L':
                for i:=1 to k do
                begin
                a[x-1,y]:=a[x-1,y] or 4;a[x-1,y-1]:=a[x-1,y-1] or 1;
                dec(x);
                end;
            'R':
                for i:=1 to k do
                begin
                a[x,y]:=a[x,y] or 4;a[x,y-1]:=a[x,y-1] or 1;
                inc(x);
                end;
            end;
    	end;
		close(f);
	end;
procedure tim;
    var i,j,u,v,p,q,h,k:longint;
    begin
	    min:=maxlongint;
	    for i:=-101 to 101 do
	    for j:=-101 to 101 do
        begin
        if a[i,j]=15 then
        begin
    	    min:=1;
		    tx:=i;ty:=j;
		    px:=tx+1;py:=ty+1;
       	    exit;
        end;
        if a[i,j]=13 then
        begin
       	    v:=j+1;u:=i;
       	    while (v<=100)and(a[u,v]=5) do inc(v);
       	    if (v<=100)and(a[u,v]=7) then
            begin
          	    s:=v-j+1;
          	    if s<min then
			    begin
				    min:=s;
				    tx:=i;ty:=j;
				    px:=tx+1;py:=v+1;
			    end;
            end;
        end;
        if a[i,j]=14 then
        begin
       	    v:=j;u:=i+1;
       	    while (u<=100)and(a[u,v]=10) do inc(u);
       	    if (u<=100)and(a[u,v]=11) then
            begin
          	    s:=u-i+1;
          	    if s<min then
			    begin
				    min:=s;
				    tx:=i;ty:=j;
				    px:=u+1;py:=ty+1;
			    end;
            end;
        end;
        if a[i,j]=12 then
        begin
       	    v:=j;u:=i+1;
       	    while (u<=100)and(a[u,v]=4) do inc(u);
       	    if (i=7) and (j=3) then
		        				    writeln('U = ',u);
       	    if (u<=100) and( a[u,v]=6) then
            begin
          	    p:=i;q:=j+1;
          	    while (q<=100)and(a[p,q]=8) do inc(q);
          	    if (i=7)and(j=3) then
								    writeln('Q = ',q);
          	    if (q<=100)and(a[p,q]=9)and(a[u,q]=3) then
                begin
             	    h:=i+1;
             	    while a[h,q]=1 do inc(h);
             	    if (i=7)and(j=3) then
								    writeln('H = ',h);
             	    if h=u then
                    begin
                	    k:=j+1;
                	    while a[u,k]=2 do inc(k);
                	    if (i=7)and(j=3) then
								    writeln('K = ',k);
                	    if k=q then
                   	    begin
                   		    s:=(u-i+1)*(q-j+1);
                   		    if s<min then
                      	    begin
							    min:=s;
							    tx:=i;ty:=j;
							    px:=u+1;py:=q+1;
						    end;
                   	    end;
                    end;
                 end;
              end;
           end;
        end;
    end;

procedure viet;
    begin
	    assign(f,fo+t);rewrite(f);
	    if min=maxlongint then
	                           min:=0;
	    writeln(f,min);
	    if min>0 then
   	    begin
		    writeln(f,tx:5,ty:5);
		    writeln(f,px:5,py:5);
	    end;
	    close(f);
    end;

BEGIN
	for t:='6' to '6' do
	begin
		nhap;
		tim;
		viet;
	end;
END.

