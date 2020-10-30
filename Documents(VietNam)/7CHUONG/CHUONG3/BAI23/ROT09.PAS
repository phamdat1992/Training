{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
uses crt;
const fi='rot.inp';
      fo='rot.out';
      fu='rot.oiu';
      d:array[1..4] of shortint=(-1,0,1,0);
      c:array[1..4] of shortint=(0,-1,0,1);
type poiu=record
     d,c,ch:byte;
       end;
var a:array[1..10,1..10] of byte;
    luu,luu1:array[1..100] of poiu;
    dk:array[0..3,1..4] of byte;
    n,pmin,sp:byte;
    timenow:longint absolute $00C:46;
    timesave:longint;

procedure init;
begin
     fillchar(a,sizeof(a),0);
     fillchar(luu,sizeof(luu),0);
     luu1:=luu;
     sp:=0;
     pmin:=0;
     dk[0,1]:=3;
     dk[0,2]:=1;
     dk[0,3]:=3;
     dk[0,4]:=1;
     dk[1,1]:=2;
     dk[1,2]:=0;
     dk[1,3]:=2;
     dk[1,4]:=0;
     dk[2,1]:=1;
     dk[2,2]:=3;
     dk[2,3]:=1;
     dk[2,4]:=3;
     dk[3,1]:=0;
     dk[3,2]:=2;
     dk[3,3]:=0;
     dk[3,4]:=2;
end;

procedure readfile;
var f:text;
    i,j,dem1,dem2,dem3,dem0:byte;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     dem0:=0;dem1:=0;dem2:=0;dem3:=0;
     for i:=1 to n do
	 for j:=1 to n do
	    begin
		     read(f,a[i,j]);
             case a[i,j] of
             0: inc(dem0);
             1: inc(dem1);
             2: inc(dem2);
             3: inc(dem3);
             end;
        end;
	 close(f);
     if pmin<dem0 then pmin:=dem0;
     if pmin<dem1 then pmin:=dem1;
     if pmin<dem2 then pmin:=dem2;
     if pmin<dem3 then pmin:=dem3;
end;

procedure writefile;
var f:text;
    i:byte;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,pmin);
     for i:=1 to pmin do writeln(f,luu[i].d,#32,luu[i].c,#32,luu[i].ch*90);
	 close(f);
end;

procedure print;
begin
     if pmin>sp then
        begin
             pmin:=sp;
             luu:=luu1;
        end;
end;

function quay(u,i,j:byte):boolean;
var v:byte;
    ok:boolean;
begin
     quay:=false;
            ok:=true;
            for v:=1 to 4 do
            if ok then
            if (i+d[v] in [1..n]) and (j+c[v] in[1..n]) then
            begin
                 if a[i+d[v],j+c[v]]<>a[i,j] then ok:=false;
			end;
            if ok then begin quay:=true;exit;end;
            for v:=1 to 4 do
            if (i+d[v] in [1..n]) and (j+c[v] in[1..n]) then
            begin
                 if a[i+d[v],j+c[v]]<>dk[u,v] then exit;
            end;
     quay:=true;
end;

procedure try(i,j:byte);
var u:byte;
begin
     if timenow-timesave>10 then begin print;exit;end;
     if i=n+1 then begin print;exit;end;
     if j=n+1 then begin try(i+1,1);exit;end;
     if sp>pmin then exit;
     for u:=0 to 3 do
     if quay(u,i,j) then
        begin
             a[i,j]:=abs(a[i,j]-u);
             inc(sp);
             luu1[sp].d:=i;
             luu1[sp].c:=j;
             luu1[sp].ch:=u;
             try(i,j+1);
             dec(sp);
        end;
end;

procedure process;
begin
     timesave:=timenow;
     try(1,1);
end;

BEGIN
     init;
     readfile;
     process;
     writefile;
END.
4
2 0 1 0
2 0 3 0
2 0 2 3
1 2 1 0