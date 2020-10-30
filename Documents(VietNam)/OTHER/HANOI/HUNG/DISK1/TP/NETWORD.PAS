(* mang cac truong hoc*)
program  networkofschool;
uses crt;
const fi='network.inp';
type mang=array[1..200,1..200] of byte;
var  a:mang;
     n:byte;
     f:text;

procedure  readfile;
var i,t:byte;
begin  fillchar(a,sizeof(a),0);
       assign(f,fi);
       reset(f);
       readln(f,n);
       for i:=1 to n do
        begin
            while eoln(f)=false do
             begin read(f,t);
                   if t<>0 then a[i,t]:=1;
             end;
             readln(f);
         end;
         close(f);
  end;

 procedure  baodong;
 var   i,j,k:byte;
 begin
      for i:=1 to n do
        for j:=1 to n do
         if a[i,j]<>0 then
          for k:=1 to n do
           if (i<>k) and ( a[j,k]<>0) then a[i,k]:=1;
   end;

   procedure xem;
   var i,j:byte;
   begin
      for i:=1 to n do
        begin for j:=1 to n do write(a[i,j],'  ');
         writeln;
        end;
    end;

 procedure  cau1;
 var dem,max,i,j,luu,d,max1:byte;
     ok:array[1.. 200] of boolean;
 begin  dem:=0;max1:=0;
 for i:=1 to n do ok[i]:=true;
    repeat max:=0;
          inc(max1);
       for i:=1 to n do
        if ok[i]=true then
       begin
             d:=0;
             for j:=1 to n do
             if (a[i,j]=1) and (ok[j]) then inc(d);
             if d>=max then
              begin luu:=i;
                    max:=d;
              end;
       end;
      ok[luu]:=false;
      inc(dem);
      for j:=1 to n  do
      if a[luu,j]= 1 then begin ok[j]:=false;inc(dem);end;
      until dem>=n;
      writeln(max1);
  end;

  function  kt(i:byte):boolean;
  var j:byte;
  begin  j:=1;
         kt:=true;
       while(j<=n) and (a[i,j]=0) do inc(j);
       if j<=n then kt:=false;
   end;

  procedure qb;
  var i,j,max2,d:byte;t:set of byte;
  begin     max2:=0; t:=[];d:=0 ;
       for i:=1 to n do
        if kt(i) then
         begin
               inc(max2);
               t:=t+[i];
             for j:=1 to n do
                if (a[j,i]=1) and (not (j in t)) then  t:=t+[j];
         end;
        for i:=1 to n do
         if not(i in t) then
           begin
                 inc(max2);
                 t:=t+[i];
               for j:=1 to n do
                if (a[i,j]=1) and (a[j,i]=1) and( not (j in t)) then
                 t:=t+[j];
            end;
            writeln(max2);
    end;
   begin clrscr;
    readfile;
    baodong;
    writeln('OUTPUT');
    cau1;
    qb;
    readln
    end.





