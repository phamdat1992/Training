uses crt;
const fi='vat.inp';
      fo='vat.out';
type int=integer;
     log=longint;
var  d,a,luu:array[1..9] of byte;
     ok:array[0..9] of boolean;
     n,i,j:byte;
     x,y,thue:longint;

procedure df;
var f:text;
begin
     assign(f,fi);reset(f);
     fillchar(ok,sizeof(ok),true);
     readln(f,n);
     for i:=1 to n do read(f,d[i]);
     readln(f);
     readln(f,x);
     close(f);
end;

procedure gf;
var f:text;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,thue);
     close(f);
end;

procedure print(po:longint);
begin
     if(thue>po)or(thue=0)then
     thue:=po;
end;

procedure try(k:byte);
var i:byte;z,t:string;po:longint;code:int;
begin
     z:='';
     for i:=1 to k-1 do
     begin
          str(luu[i],t);
          z:=z+t;
     end;
     val(z,po,code);
     if po>x then begin print(po);exit;end;
     for i:=0 to 9 do
     if ok[i] then
     begin
          luu[k]:=i;
          try(k+1);
          luu[k]:=0;
     end;
end;

procedure xl;
begin
     for i:=1 to n do ok[d[i]]:=false;
     j:=0;y:=x;
     while y<>0 do
     begin
          inc(j);
          a[j]:=y mod 10;
          y:= y div 10;
     end;
     for i:=1 to 9 do
     if ok[i] then
     begin
          luu[1]:=i;
          try(2);
     end;
end;



BEGIN
     df;xl;gf;
END.
3
1 3 8
17