uses   	crt;
const  	fi  = '6_mino.in4';
        fo  = '6_mino.out';
        dd  : array[1..8] of -2..2 = (0,1,2,2,2,2,2,1);
        dc  : array[1..8] of -2..2 = (2,2,2,1,0,-1,-2,-2);
type    m1	= array[1..6,1..6] of integer;
        m2  = array[1..6] of integer;
var     a   : m1;
        b	: m1;
        r	: m2;
        ok  : boolean;
        d,c : byte;

procedure nhap;
var  f : text;
     i,j : byte;
begin
    fillchar(a,sizeof(a),0);
    fillchar(b,sizeof(b),0);
    assign(f,fi);
    reset(f);
    for i:=1 to 6 do
    begin
        for j:=1 to 6 do read(f,a[i,j]);
		readln(f);
    end;
    close(f);
end;


procedure ghi_vn;
var f : text;
begin
    assign(f,fo);
    rewrite(f);
    writeln(f,0);
    close(f);
    halt;
end;
procedure ghi_cn;
var f : text;
    i,j : byte;
    dx  : m2;
begin
    fillchar(dx,sizeof(dx),0);
    assign(f,fo);
    rewrite(f);
    writeln(f,1);
    for i:=1 to 5 do
    if dx[i]=0 then
    begin
        for j:=i+1 to 6 do
        if dx[j]=0 then
        if (r[i]=j)  and (r[j]=i) then
        begin
            write(f,i,' ',j,' ');
            dx[i] := 1;
            dx[j] := 1;
            break;
        end;
    end;
    close(f);
    halt;
end;

function duoc(r : m2) : boolean;
var i : byte;
begin
    duoc := false;
    for i:=1 to 6 do
    if r[i]=0 then exit;
    duoc := true;
end;

procedure tim(var d,c : integer);
var i,j : byte;
begin
    d := 0;
    c := 0;
    ok := false;
    for i:=1 to 6 do
    for j:=1 to 6 do
    if a[i,j]>0 then
    if b[i,j]=0 then
    begin
        d := i;
        c := j;
        ok := true;
        exit;
    end;
end;

function trong(u,v : integer) : boolean;
begin
    trong := (0<u) and (u<7) and (v>0) and (v<7);
end;

procedure duyet(i : integer);
var j,k,u,v,d,c : integer;
begin
    if i>3 then
    begin
    	if duoc(r) then
		            ghi_cn;
    end
    else
    begin
        tim(d,c); { a[d,c]>0, b[d,c]=0 }
        if (d=0) or (c=0) then exit;
        for k:=1 to 8 do
        begin
            u := d + dd[k];
            v := c + dc[k];
            if trong(u,v) then
            begin
                if a[u,v]=0 then continue;
                case k of
                1: if a[d,c+1]=0 then continue;
                2: if (a[d,c+1]=0) or (a[d+1,c+1]=0) then continue;
                3: if not
				    (((a[d,c+1]>0) and (a[d+1,c+1]>0) and (a[d+2,c+1]>0))
					 or ((a[d+1,c]>0) and(a[d+1,c+1]>0)and(a[d+1,c+2]>0)))then continue;
                4: if (a[d+1,c]=0) or (a[d+1,c+1]=0) then continue;
                5: if (a[d+1,c]=0) then continue;
                6: if (a[d+1,c]=0) or (a[d+1,c-1]=0) then continue;
                7: if not
				     ( ((a[d,c-1]>0) and (a[d+1,c-1]>0) and (a[d+2,c-1]>0))
					 or ((a[d+1,c]>0) and (a[d+1,c-1]>0) and (a[d+1,c-2]>0)))then continue;
                8: if (a[d,c-1]=0) or (a[d+1,c-1]=0) then continue;
                end;
                {tu day a[u,v]>0}
                if b[u,v]=0 then
                begin
                    b[u,v] := a[d,c];
                    b[d,c] := a[u,v];
                    r[a[d,c]] := a[u,v];
                    r[a[u,v]] := a[d,c];
                    duyet(i+1);
                    b[u,v] := 0;
                    b[d,c] := 0;
                    r[a[d,c]] := 0;
                    r[a[u,v]] := 0;
                end
                else {b[u,v]>0}
                begin
                    if b[u,v]<>a[d,c] then continue;
                    if b[u,v]=a[d,c] then
                    begin
                        b[d,c] := a[u,v];
                        r[a[d,c]] := a[u,v];
                        r[a[u,v]] := a[d,c];
                        duyet(i+1);
                        b[u,v] := 0;
                        b[d,c] := a[d,c];
                        r[a[d,c]] := 0;
                        r[a[u,v]] := 0;
                    end;
                end;
            end;
        end;
    end;
end;

BEGIN
    nhap;
    duyet(1);
    ghi_vn;
END.