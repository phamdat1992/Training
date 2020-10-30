 uses crt;
 type ds=^tro;
      tro=record
      cs:integer;
      next:ds;
      end;
  var s:array[1..100]of set of char;
   n,n1,m,i,j,k,cost:integer;f,f1:text;
   b,b1:array[1..100]of boolean;
   p,p1:array[1..100]of integer;
   l,q:array[1..150]of ds;
   y:array[1..100]of byte;
   st:string[100];
  procedure readf;
   var i,j:integer;ch:char;
   begin
   assign(f,'dt.inp');reset(f);
    readln(f,m,n);writeln(m:3,n:3);
    for i:=1 to m do s[i]:=[];
    for i:=1 to M do
     begin
       while not eoln(f) do
        begin
         read(f,ch);write(ch);
         s[i]:=s[i]+[ch];
        end;
        readln(f);writeln;
      end;
      readln(f,st);
      writeln(st);
    close(f);
 end;
procedure int;
 var i,j:integer;pt:ds;ok:boolean;
  begin
    for i:=1 to m do b[i]:=true;
     {for i:=1 to m do b1[i]:=true;}
   cost:=0;
    for i:=1 to n do l[i]:=nil;
    k:=0;
     for i:=1 to n do
      begin  ok:=false;
       for j:=1 to m do
        if st[i] in s[j] then
         begin
          new(pt); ok:=true;
           pt^.cs:=j;
           pt^.next:=l[i];
           l[i]:=pt;
         end;
        if ok then begin  inc(k);q[k]:=pt;y[k]:=i;end;
      end;
     n1:=k;
     for i:=1 to n1 do
      begin
       pt:=q[i]; write('Nguoi ',i,':');
        while pt<>nil do
         begin
          write(pt^.cs:3);
          pt:=pt^.next;
          end;
          writeln;
        end;
  end;
procedure find(k,d:integer);
 var i,j,d1:integer;pt:ds;
  begin
   pt:=q[k];
    while pt<>nil do
     begin d1:=d;
      if b[pt^.cs] then
       begin
         p[k]:=pt^.cs;
         b[pt^.cs]:=false;
         inc(d1);
         if d1>cost then begin p1:=p;cost:=d1;end;
       end
       else p[k]:=0;
        if k<n1 then find(k+1,d1);
        if p[k]>0 then b[pt^.cs]:=true;
      pt:=pt^.next;
    end;
  end;
begin clrscr;
 readf;
  writeln;
  int;
  find(1,0);
{   for i:=1 to n do write(p1[i]:4);writeln;}
assign(f1,'dt.out');rewrite(f1);
 writeln(f1,cost);
 for i:=1 to n1 do
    if p1[i]>0 then
     writeln(y[i]:3,p1[i]:4);
     close(f1);
  readln;
  end.
4 5
CD
AB
BE
ABC
ACAAD
