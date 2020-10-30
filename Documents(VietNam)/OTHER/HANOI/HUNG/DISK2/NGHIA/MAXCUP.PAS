uses crt;
const   fi='maxcub.in5';
        fo='maxcub.out';
        b:array[1..6] of shortint=(1,-1,0,0,0,0);
        c:array[1..6] of shortint=(0,0 ,1,-1,0,0);
        d:array[1..6] of shortint=(0,0,0,0,-1,1);
var     a:array[1..20,1..20,1..20] of integer;
        ok:array[1..20,1..20,1..20] of boolean;
        n,l1,l2,l3,l4:byte;
        max:longint;
        time:longint absolute 00:$46c;
        timesave:longint;
        f:text;

procedure  init;
begin
     fillchar(a,sizeof(a),0);
     fillchar(ok,sizeof(ok),0);
end;

procedure   readfile;
var  i,j,k,l:byte;
begin
     assign(f,fi);
     reset(f);
       readln(f,n);
       for i:=1 to n do
         for j:=1 to n do
           for k:=1 to n do
           begin
		        read(f,a[i,j,k]);
                if (n-i)*(n-j)*(n-k)=0 then ok[i,j,k]:=true
                else
                if a[i,j,k]<=0 then
                for l:=1 to 6 do
                begin
                      if (i+b[l] in [1..n]) and  (j+c[l] in [1..n]) and  (k+d[l] in [1..n]) then
                      ok[i,j,k]:=true;
                end;
         end;
     close(f);
end;

function  tong(i,j,k,l:byte):longint;
var u,v,w:byte;
   slmax:longint;
begin
       slmax:=0;
       for u:=j to j+i-1 do
        for v:=k to k+i-1 do
         for w:=l to l+i-1 do
           inc(slmax,a[u,v,w]);
       tong:=slmax;
end;

procedure  duyet;
var i,j,k,l:byte;
    sl:longint;
begin
      max:=0;
      for i:=1 to n do
        for j:=1 to n-i+1 do
          for k:=1 to n-i+1 do
            for l:=1 to n-i+1 do
         {   if ok[i,j,k] then
              if a[j,k,l]>=0 then}
               begin
                 sl:=tong(i,j,k,l);
				 if sl>max then
                   begin
                        max:=sl;
                        l1:=j;l2:=j;l3:=k;l4:=i;
                   end;
               end;
end;

procedure  main;
var i,j,k:byte;
begin
     init;
     readfile;
     assign(f,fo);
     rewrite(f);
       duyet;
       writeln(f,max);
     close(f);
end;

procedure  test;
var  i,j,k,l,p:byte;
begin
    assign(f,fi);
    rewrite(f);
    n:=20;
    writeln(f,n);
    randomize;
    for i:=1 to n do
     begin
          for j:=1 to n do
           begin
                 l:=random(10000);
                 p:=random(5000);
                 for k:=1 to n do write(f,l-p,' ');
                 writeln(f);
           end;
     end;
    close(f);
end;

begin  clrscr;
{
test
end.}
     timesaved:=time;
    main;
    Writeln('Time run: ',(time-timesaved)/18.21:10:5));
end.
