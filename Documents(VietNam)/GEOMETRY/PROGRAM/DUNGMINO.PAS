{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 63840,0,655360}
const 	max	= 10;
      	fi	= '6_mino.in4';
      	fo	=   'dung.out';
      	ddt	: array[1..4,1..2] of integer = ((-2,-1),(0,0),(2,1),(0,0));
      	dct	: array[1..4,1..2] of integer = ((0,0),(2,1),(0,0),(-2,-1));
      	ddc	: array[1..8,1..2] of integer =
                ((-1,0),(-1,0),(0,-1),(0,1),(1,0),(1,0),(0,1),(0,-1));
      	dcc	: array[1..8,1..2] of integer =
                ((0,-1),(0,1),(1,0),(1,0),(0,1),(0,-1),(-1,0),(-1,0));
type 	m1	= array[-3..max,-3..max] of integer;
     	m2	= array[1..max] of integer;
var 	a	: m1;
    	kq	: m2;

procedure init_data;
	begin
        	fillchar(a,sizeof(a),0);
                fillchar(kq,sizeof(kq),0);
        end;

procedure read_inp;
	var f	:	text;
            i,j	:	integer;
        begin
        	assign(f,fi);
                reset(f);
                for i := 1 to 6 do
                begin
	                for j := 1 to 6 do
                        	read(f,a[i,j]);
                        readln(f);
        	end;
                close(f);
        end;

procedure write_out_1;
	var f	:	text;
        begin
        	assign(f,fo);
                rewrite(f);
                writeln(f,0);
                close(f);
        	halt;
        end;

procedure ktra(x,y : integer);
	var i,j	:	integer;
            p	:	integer;
            x1,y1:	integer;
	begin
        p := a[x,y];
        for i := 1 to 4 do
        begin
            x1 := x + ddt[i,2];
            y1 := y + dct[i,2];
           	x := x + ddt[i,1];
            y := y + dct[i,1];
            if a[x,y] <> 0 then
            if a[x1,y1] <> 0 then
            if kq[p] = 0 then
            begin
           		kq[p] := a[x,y];
                kq[a[x,y]] := p;
            end
            else
            if kq[p] <> a[x,y] then
                  	write_out_1;
            x := x - ddt[i,1];
            y := y - dct[i,1];
        end;
        for i := 1 to 8 do
        begin
           	x := x + ddc[i,1];
            y := y + dcc[i,1];


            x1 := x; y1 := y;
            if a[x,y] <> 0 then
            for j := 1 to 3 do
            begin
	            x1 := x1 + ddc[i,2];
                y1 := y1 + dcc[i,2];
                if a[x1,y1] = 0 then
                         	break;
                if a[x1 + ddc[i,1],y1 + dcc[i,1]] <> 0 then
                if kq[p] = 0 then
                begin
                   	kq[p] := a[x1 + ddc[i,1],y1 + dcc[i,1]];
                    kq[a[x1 + ddc[i,1],y1 + dcc[i,1]]] := p;
                end
                else
                if kq[p] <> a[x1 + ddc[i,1],y1 + dcc[i,1]] then
                                	write_out_1;
           end;
           x := x - ddc[i,1];
           y := y - dcc[i,1];
     end;
     if kq[p] = 0 then
                	write_out_1;
end;

procedure work;
	var i,j	:	integer;
	begin
        for i := 1 to 6 do
        for j := 1 to 6 do
            if a[i,j] <> 0 then
        		ktra(i,j);
    end;

procedure write_out;
	var 	f	:	text;
            i	:	integer;
    begin
      	assign(f,fo);
        rewrite(f);
        writeln(f,1);
        for i := 1 to 6 do
        if kq[i] <> 0 then
        begin
            write(f,i,' ',kq[i],' ');
            kq[kq[i]] := 0;
        end;
        close(f);
    end;

BEGIN
	init_data;
    read_inp;
    work;
    write_out;
END.