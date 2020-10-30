uses crt;
const fi='piton.inp';
      fo='piton.out';
      d:array[1..4] of shortint=(-1,0,1,0);
      c:array[1..4] of shortint=(0,1,0,-1);
type poiu=record
      d,c:byte;
      end;
     poiut=record
      ktu:char;
      sl:integer;
      end;
var a:array[1..50,1..50] of shortint;
    t:array[1..10] of poiu;
    nlt:array[1..10] of shortint;
    luu,luu1:array[1..2500] of poiut;
    ktuc:char;
    n,m,i,slc,sl:byte;
    trd,trc:poiu;
    sldi,du,kn:integer;

procedure init;
begin
     fillchar(a,sizeof(a),0);
     sldi:=0;
     du:=0;
end;

function tim(sl:byte):byte;
var j:byte;
    timthe:char;
begin
     luu1:=luu;
     if i=1 then timthe:=luu1[1].ktu;
     for j:=2 to i do
        begin
             luu1[i].sl:=luu1[i].sl+luu1[i-1].sl;
             if sl in [luu1[i-1].sl..luu1[i].sl] then timthe:=luu[i-1].ktu;
        end;
     case timthe of
        'U':tim:=1;
        'D':tim:=3;
        'L':tim:=4;
        'R':tim:=2;
       end;
end;

procedure tran_di(trd,trc:poiu;ktuc:char;slc:byte);
var hdd,hdc:byte;
begin
     du:=du+slc;
     case ktuc of
            'U':hdd:=1;
            'D':hdd:=3;
	        'L':hdd:=4;
	        'R':hdd:=2;
         end;
	 while sl<slc do
       begin
            inc(sl);
            dec(du);
            trd.d:=trd.d+d[hdd];
            trd.c:=trd.c+c[hdd];
            inc(sldi);
            if ((trd.d=1)and (hdd=1)) or ((trd.d=n)and (hdd=3))
              or((trc.d=1)and (hdd=4)) or ((trc.d=n)and (hdd=2)) then
			   begin
                    kn:=1;
                    exit;
               end;
            if a[trd.d,trd.c]=-2 then
               begin
                    kn:=2;
                    exit;
               end;
            if a[trd.d,trd.c]>=0 then
               begin
                    du:=du+a[trd.d,trd.c];
                    a[trd.d,trd.c]:=-2;
                    a[trc.d,trc.c]:=-1;
                    hdc:=tim(sldi-1);
                    trc.d:=trc.d+d[hdc];
                    trc.c:=trc.c+c[hdc];
                    tran_di(trd,trc,ktuc,slc);
               end;
       end;
end;

procedure readfile;
var f,fr:text;
begin
     assign(fr,fo);
     rewrite(fr);
     assign(f,fi);
     reset(f);
     readln(f,n,m);
     readln(f,trd.d,trc.c);
     for i:=1 to m do
        begin
             readln(f,t[i].d,t[i].c,nlt[i]);
             a[t[i].d,t[i].c]:=nlt[i];
        end;
     i:=0;
     kn:=-1;
     while not eof(f) do
           begin
                readln(f,ktuc,slc);
                inc(i);
                luu[i].ktu:=ktuc;
                luu[i].sl:=slc;
                tran_di(trd,trc,ktuc,slc);
                if kn<>-1 then begin writeln(fr,kn);writeln(fr,sldi);exit;end;
           end;
     writeln(fr,0);
     writeln(fr,sldi);
	 close(f);
     close(fr);
end;

BEGIN
     INIT;
     READFILE;
END.
3 1
2 2 1 2
1 3 1
D 1
