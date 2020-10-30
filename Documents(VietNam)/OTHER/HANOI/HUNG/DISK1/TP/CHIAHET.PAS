uses crt;
const  fi='div1.inp';
       fo='div.out';
       maxso=15000;
type   mangd=array[0..15000] of word;
var    a:array[1..10000] of byte;
       find:array[0..20000] of boolean;
       fro:^mangd;
       n,k,du:integer;
       tong:longint;
       f,f1:text;


procedure  init;
begin
    new(fro);
    fillchar(fro^,sizeof(fro^),0);
    fillchar(find,sizeof(find),false);
    find[0]:=true;
    tong:=0;du:=0;
end;


procedure  readfile;
var  i,j:integer;
begin
     assign(f,fi);
     reset(f);
     readln(f,n,k);
     for i:=1 to n do begin read(f,j);a[i]:=abs(j) mod k;inc(tong,a[i]);du:=du+a[i] mod k;find[a[i]]:=true;end;
     close(f);
     du:=du mod k;
     for i:=1 to n do
      if find[a[i]] and ((a[i]=du div 2) or ( a[i]=(k+du) div 2)) then
       begin
            writeln(f1,'1');
            close(f1);
            halt;
       end;
end;

function ok(i,j:longint):boolean;
var k:longint;
begin
     ok:=false;
     k:=j;
     while fro^[k]>0 do
       begin
          if fro^[k]=i then exit;
          k:=k-a[fro^[k]];
       end;
       ok:=true;
end;

procedure  xuli;
var   i,j:word;
begin
     for i:=1 to tong do
      if i>maxso then begin writeln(f1,'0');dispose(fro);close(f1);halt;end
      else
      if not find[i] then
       for j:=1 to n do
        if (a[j]>0) and (a[j]<i) then
         if find[i-a[j]] and ok(j,i-a[j]) then
          begin
               find[i]:=true;
               fro^[i]:=j;
               if not odd(du) and (i mod k=du div 2) then begin writeln(f1,'1'); dispose(fro);close(f1);halt;end;
               if odd(du) and ( i mod k=(k+du) div 2) then begin writeln(f1,'1'); dispose(fro);close(f1);halt;end;
               break;
          end;
end;

begin  clrscr;
   assign(f1,fo);
   rewrite(f1);
   init;
   readfile;
   xuli;
   writeln(f1,'0');
   dispose(fro);
   close(f1);
end.
