  uses crt;
  type mang1=array[1..50,1..50] of integer;
       mang2=array[1..50] of integer;
   var a,c,fb:mang1;
       e,p:mang2;
       m1,n1,n,s,t:integer;
       f:text;
       ok:boolean;

   procedure  readfile;
   var i,j:integer;
       name:string;
   begin
        write('FILENAME INPUT:');READLN(NAME);
        ASSIGN(F,name);
        reset(f);
        readln(f,m1,n1);
        for i:=1 to m1 do
         begin  while not eoln(f) do begin read(f,j);c[i,j]:=1;end; readln(f);end;
    end;

   procedure  tao_mang;
   var i,j:byte;
   begin
       fillchar(a,sizeof(a),0);
       n:=m1+n1+2;
       for i:=1 to n1 do
        a[1,i+1]:=1;
        for i:=n1+2 to n-1 do a[i,n]:=1;
        for i:=1 to n1 do
         for j:=1 to m1 do
          if c[j,i]=1 then a[i+1,j+n1+1]:=1;
          s:=1;t:=n;
     end;

     function  min(i,j:integer):integer;
     begin min:=i;if j<i then min:=j;end;

     procedure  tim_luong;
     var  i,j:integer;t1,t2:set of byte;
     begin
         t1:=[s];
         t2:=[];
         p[s]:=s;
         e[s]:=3000;
         for i:=1 to n do
         if not (i in t1) then t2:=t2+[i];
         ok:=false;
         while (t1<>[]) and  (ok=false) do
          begin i:=1;
            while not (i in t1) do inc(i);
            t1:=t1-[i];
            j:=0;
            while (j<=n )and (ok=false ) do
             begin inc(j);
               if j in t2 then
                begin
                   if (a[i,j]>0)  and (fb[i,j]<a[i,j]) then
                    begin t1:=t1+[j];
                          t2:=t2-[j];
                          p[j]:=i;
                          e[j]:=min(e[i],a[i,j]-fb[i,j]);
                          if j=t then ok:=true;
                    end;
                    if (a[j,i]>0) and (fb[j,i]>0) then
                     begin p[j]:=-i;
                           t1:=t1+[j];
                           t2:=t2-[j];
                           e[j]:=min(e[i],fb[j,i]);
                           if j=t then ok:=true;
                      end;
                  end;
               end;
           end;
      end;

     procedure  tang_luong;
     var u,v,tang:integer;
     begin u:=t;
           v:=p[t];tang:=e[t];
           while u<>s do
           begin
              if v>0 then inc(fb[v,u],tang)
              else
               begin  v:=-v;
                      inc(fb[u,v],-tang);
               end;
             u:=v;v:=p[u];
            end;
      end;

      procedure ford_fullkerson;
      var stop:boolean;i,j:integer;
      begin
          stop:=false;
          while not stop do
           begin tim_luong;
             if ok then tang_luong
             else stop:=true;
            end;
           writeln('OUTPUT');
           for i:=2 to n1 +1 do
             for j:=n1+2 to n-1 do
              if fb[i,j]=1 then writeln('x[',i-1,']=',j-n1-1);
                  end;

      BEGIN clrscr;
      readfile;
      tao_mang;
      ford_fullkerson;
      readln
      END.
    6 7
    2 3
    2 6
    3 5
    7
    3 4
    5 6





