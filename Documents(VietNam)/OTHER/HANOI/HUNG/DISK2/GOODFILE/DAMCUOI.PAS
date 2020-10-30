  uses crt;
  const fin='damcuoi.inp';
        fou='damcuoi.out';
  type mang1=array[1..120,1..150] of byte;
       mang2=array[1..200] of byte;
  var  fb:mang1;
       a,c:mang1;
       m1,n1,n:byte;
       s,t:byte;
       p,e:mang2;
       time1:longint  absolute 0:$46c;
       time2:longint;
       ok:boolean;
       f:text;

  procedure readfile;
  var i,j :byte;
  begin  time2:=time1;
         fillchar(c,sizeof(c),0);
         assign(f,fin);
         reset(f);
         readln(f,n1,m1);
         while not eoln(f) do begin readln(f,i,j);c[i,j]:=1; end;
         close(f);
   end;

   procedure  taomang;
   var i,j:byte;
   begin
       fillchar(a,sizeof(a),0);
       n:=m1+n1+2;
       for i:=1 to n1 do a[1,i+1]:=1;
       for i:=1 to n1 do
        for j:=1 to m1 do  if c[i,j]=1 then   a[i+1,j+n1+1]:=1;
       for i:=1 to m1 do a[i+n1+1,n]:=1;
       t:=n;s:=1;
   end;

    function min(i,j:byte):byte;
    begin
          min:=i;
          if j<i then min:=j;
     end;

   procedure  tim_luong;
   var i,j:byte;
       t1,t2:set of byte;
   begin t1:=[s];
         t2:=[];
         p[s]:=s;
         e[s]:=250;
         for i:=1 to n do
         if not(i in t1) then t2:=t2+[i];
         ok:=false;
         while (t1<>[]) and( ok=false) do
          begin i:=1;
              while not (i in t1) do inc(i);
              t1:=t1-[i];
              j:=0;
              while (j<=n) and (ok=false) do
              begin  inc(j);
                if j in t2 then
                 begin
                    if (a[i,j]>0) and ( fb[i,j]<a[i,j]) then
                     begin t1:=t1+[j];
                           t2:=t2-[j];
                           p[j]:=i;
                           e[j]:=min(e[i],a[i,j]-fb[i,j]);
                           if j=t then ok:=true;
                     end;
                     if (a[j,i]>0) and (fb[j,i]> 0) then
                      begin
                           t1:=t1+[j];
                           t2:=t2-[j];
                           p[j]:=-i;
                           e[j]:=min(e[i],fb[j,i]);
                           if j=t then ok:=false;
                      end;
                  end;
             end;
      end;
   end;

    procedure tang_luong;
    var u,v,tang:integer;
    begin
        u:=t;
        v:=p[t];
        tang:=e[t];
        while u<>s do
         begin
            if v>0 then  inc(fb[v,u],tang)
            else
              begin  v:=-v;
                     inc(fb[u,v],-tang);
              end;
              u:=v;
              v:=p[u];
          end;
     end;

    procedure  ford_fullkerson;
    var i,j,dem:byte;stop:boolean;
    begin
      fillchar(fb,sizeof(fb),0);
      stop:=false;
      while  not stop do
       begin
             tim_luong;
             if ok then  tang_luong
             else stop:=true;
        end;
        assign(f,fou);
        rewrite(f);
        dem:=0;
          for i:=2 to n1+1 do
           for j:=n1+1 to n-1 do
            if fb[i,j]=1 then
             begin
	           writeln(f,'   Chang trai   ',i-1,' Lay co gai ', j-n1-1);
                   inc(dem);
             end;
             writeln(f,'    Co ',dem ,' nguoi lay duoc vo');
             writeln(f,'TIME RUN:',((TIME1-TIME2)/18.21):13:13);
         close(f);
     end;

   BEGIN clrscr;
    readfile;
    taomang;
    ford_fullkerson;
    END.

 10 10
 1
 5  7
 8 10
 1 2 10
 1 4
 4 10
 6 10
 10 1 3
 2 5
 9 8

 5 5
 2 3
 2
 4
 4
 5
 4 5
 1 4 5
 2
 2 4
 2 3








