{$R+}
Program nguyento;
uses crt;
Const
     fi='gnt.inp';
     fo='gnt.out';
     maxn=100;
     epsilon=0.0001;
Type
    mang=array[1..maxn] of extended;
Var
   c,d: ^mang;
   e:array[1..500] of extended;
   i,j,m,n:integer;
   f1,f2:text;

Function nt(a:extended):boolean;
Var
   i:longint;
Begin
     nt:=false;
     if a=1 then exit;

     if (a=2) or (a=3) or (a=5) or (a=7) then
     begin
          nt:=true;
          exit;
     end;

     if frac(a/2)=0 then exit;
     if frac(a/3)=0 then exit;

     for i:=1 to (trunc(sqrt(a)) div 6)+1 do
     begin
          if frac(a/(6*i+1))=0 then exit;
          if frac(a/(6*i-1))=0 then exit;
     end;
     nt:=true;
end;

Function ghep(x,y:extended):extended;
Var
	z:extended;
begin
	while int(y/10)<>0 do z:=x*10;
    z:=z+y;
end;

Procedure taomang;
Var
   i:integer;
   k:longint;
begin
     k:=1;
     i:=0;
     New(c);
     New(d);
     Fillchar(c^,sizeof(c^),0);
     Fillchar(d^,sizeof(d^),0);

     repeat
           inc(k);
           if nt(k) then
           begin
                inc(i);
                c^[i]:=k;
           end;
     until i=maxn;

	 i:=1;
     j:=0;
     repeat
            inc(j);
            d^[j]:=ghep(c^[i],c^[i+1]);
            i:=i+2;
     until i>=maxn;

     m:=j;

     i:=0;
     j:=0;
     repeat
           inc(i);
           if nt(d^[i]) then
           begin
                inc(j);
                e[j]:=d^[i];
                writeln(j);
           end;
     until d^[i]=0;
end;

Procedure main;
begin
     taomang;
     assign(f1,fi);
     assign(f2,fo);
     reset(f1);
     rewrite(f2);
     while not eof(f1) do
     begin
          readln(f1,n);
          writeln(f2,e[n]);
     end;
     close(F1);
     close(f2);
end;

Procedure done;
begin
end;

BEGIN
     Clrscr;
     main;
     done;
END.
1