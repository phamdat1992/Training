uses crt;
 type mang1=array[0..50,0..50] of integer;
      mang2=array[0..50] of integer;

 var a,fb,tin,the:mang1;
     p,e:mang2;
     t1,t2:set of byte;
     s,t,n,n1,m,j:byte;
     ok:boolean;
     pb:array[1..50] of boolean;
     TIME  :LONGINT ABSOLUTE   0:$46C ;
     TIM     : LONGINT;
     ff:text;

     procedure  readfile;
     var i,j:byte;
         name:string;
     begin
       fillchar(tin,sizeof(tin),0);
       the:=tin;
       write('NAME FILE INPUT: ');readln(name);
       TIM:=TIME;
       assign(ff,name);
       reset(ff);
       readln(ff,m,n1);
       for i:=1 to n1 do
       begin while not eoln(ff) do
        begin read(ff,j);tin[i,j]:=1;end;readln(ff);end;
     for i:=1 to n1 do
     begin   while not eoln(ff) do begin read(ff,j);the[i,j]:=1;end;readln(ff);end;
       writeln('INPUT');
       writeln(m,'  ',n1);
       writeln('nhom tin hoc');
       for i:=1 to n1 do
       begin  write('nhom  ',i, '  gom:');
       for j:=1 to m do if  tin[i,j]=1 then write(j:3);writeln;end;   writeln;
       writeln('nhom the thao:');
             for i:=1 to n1 do  begin write('nhom ',i,'  gom:');
             for j:=1 to m do if (the[i,j]=1) then write(j:3);writeln;end;

      end;


      procedure taomang;
      var   i,j:byte;f:text;
      begin
       n:=(n1+m)*2+2;
       fillchar(a,sizeof(a),0);
        for i:=1 to n1 do
          a[1,i+1]:=1;
          for i:=n-n1  to  n-1 do a[i,n]:=1;
        for i:=1 to n1 do  0
         for j:=1 to m do
           begin
                 if tin[i,j]=1 then a[i+1,j+n1+1]:=1;
                 if the[i,j]=1  then  a[j+m+n1+1,i+n1+2*m+1]:=1;
           end;
        for j:=n1+2 to n1+m+2 do a[j,j+m]:=1;
         assign(f,'inp.for');
         rewrite(f);
         write(f,n,' ',1,' ' ,n);writeln(f);
         for i:=1 to n do
          begin for j:=1 to n do write(f,a[i,j],'  ');writeln(f);end;
          close(f);
      end;


      function  min(i,j:integer):integer;
      begin min:=i;
      if j<i then min:=j;
      end;

      procedure tim_luong;
      var i,j:integer;
      begin t1:=[];t2:=[];p[s]:=s;
            e[s]:=30000;ok:=false;
            t1:=[s];
            for i:=1 to n do
             if not (i in t1) then t2:=t2+[i];
            while (t1<>[]) and (ok=false) do
             begin i:=1;
                 while not (i in t1)  do inc(i);
                j:=0;  t1:=t1-[i];
                  while (ok=false) and(j<=n) do
                    begin inc(j);
                          if (j in t2)  then
                            begin
                            if (fb[i,j]<a[i,j]) and (a[i,j]>0) then
                              begin p[j]:=i;
                                    e[j]:=min(e[i],a[i,j]-fb[i,j]);
                                    t2:=t2-[j];
                                    t1:=t1+[j];
                                    if j=t then ok:=true;
                               end;
                                if (fb[j,i]>0) and (a[j,i]>0) then
                                begin p[j]:=-i;
                                      e[j]:=min(e[i],fb[j,i]);
                                      t2:=t2-[j];
                                      t1:=t1+[j];
                                      if j=t then ok:=true;
                                end;
                            end;
                   end;
            end;
      end;

    procedure tang_luong ;
    var u,v,tg:integer;
    begin
        v:=p[t];u:=t;tg:=e[t];
        while u<>s do
         begin if v>0 then inc(fb[v,u],tg)
               else
                begin v:=-v;
                      inc(fb[u,v],-tg);
                end;
              u:=v;v:=p[u];
         end;
    end;

    procedure ford_fullkerson;
    var stop:boolean;i,j,dem:byte;
    begin fillchar(fb,sizeof(fb),0);
        stop:=false;
       while not stop do
        begin
        tim_luong;
        if ok then  tang_luong
         else stop:=true;
         end;
        WRITELN('OUTPUT');
         j:=0;
         for i:=1 to n-1 do if fb[i,n]=1 then  inc(j);
         if j>=n1 then
        begin    writeln('cac sinh vien duoc chon la');
          for i:=n-1 downto n-n1 do
          for dem:=n-n1-m to n-n1-1 do if fb[dem,i]=1 then write(dem-m-n1-1,'  ');end
         else write('khong chon duoc')


    end;

    BEGIN   clrscr;
    readfile;
    taomang;
    s:=1;
    t:=n;
    ford_fullkerson;
    WRITELN;
    WRITELN('TIME RUN=',((TIME-TIM)/18.21):13:13);
    readln
    END.

    8 4
    1 2
    3 4
    7 5
    6 8
    1 6
    2 8
    3 7
    5 4


    8 4
    1 2 6 3
    4 7
    7
    5 8
    1 6 2
    2 8
    3
    7 5 4

    6 3
    2 1
    3 2
    4 3
    4 1
    5 6
    5 6

    8 4
    1 2 5
    3 4
    7
    6 8
    1 6 2
    2 8
    3 7
    5 4
