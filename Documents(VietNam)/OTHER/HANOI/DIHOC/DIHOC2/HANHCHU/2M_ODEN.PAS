 uses crt;
 type mang1=array[1..50,1..50] of integer;
      mang2=array[1..50] of integer;
 var a,fb,c:mang1;
     p,e:mang2;
     t1,t2:set of byte;
     s,t,n,i,j,n1,m1,luu:byte;
     ok:boolean;
     time1:longint  absolute 0:$46c;
     time2 :longint;
     ff:text;

     procedure  readfile;
     var i,j:byte;name:string;
     begin
       WRITE('NAMEFILE INPUT:');readln(name);
       TIME2:=TIME1;
       assign(ff,NAME);
       reset(ff);
       readln(ff,n1,m1);
       for i:=1 to n1 do
       for j:=1 to m1 do  read(ff,c[i,j]);
       close(ff);
       writeln('INPUT');
       writeln(n1,'  ',m1);
       for i:=1 to n1 do
        begin for j:=1 to m1 do  write(c[i,j],'  ');writeln;
        end;
      end;

      function  min(i,j:integer):integer;
      begin min:=i;
      if j<i then min:=j;
      end;

      procedure tim_luong;
      var i,j:byte;
      begin t1:=[];t2:=[];p[s]:=s;
            e[s]:=3000;ok:=false;
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
    var stop:boolean;i,j:byte;
    begin fillchar(fb,sizeof(fb),0);
        stop:=false;
       while not stop do
        begin
        tim_luong;
        if ok then  tang_luong
         else stop:=true;
         end;

    end;
    procedure  chon_oden;
    var i,j,kt:byte;
    begin  if n1 mod m1=0 then kt:=n1 div m1
           else kt:=(n1 div m1)+1;
         n:=m1+n1+2;
         s:=1;t:=n;
        repeat
            fillchar (a,sizeof(a),0);
            for i:=1 to n1 do a[1,i+1]:=2;
            for i:=1 to n1 do
            for j:=1 to m1 do
            if c[i,j]=1 then a[i+1,j+n1+1]:=1;
            for i:=1 to m1 do a[i+n1+1,n]:=kt;
            ford_fullkerson;
            inc(kt);
            j:=0;
            for i:=1 to n-1 do j:=j+fb[i,n];
      until j>=2*n1;
  {    for i:=1 to n do
      begin for j:=1 to n do write(fb[i,j],' ');writeln;end;}
              writeln('OUTPUT');
        for i:=2 to n1+1 do
        begin for j:=n1+2 to n-1 do write(fb[i,j],'  ');writeln;end;

     end;

    BEGIN   clrscr;
    readfile;
    chon_oden;
    writeln('TIME RUN=',((TIME1-TIME2)/18.21) :13:13);
    readln
    END.
 4 3
 0 1 1
 1 1 0
 0 1 1
 1 1 1

 6 8
 1 1 0 1 0 1 0 1
 0 1 1 0 0 1 1 0
 1 1 0 0 1 0 1 0
 1 1 0 0 1 0 1 1
 1 1 0 1 1 1 0 0
 0 0 1 1 0 1 1 0


 10 12
 1 0 0 1 0 0 1 1 0 0 0 1
 1 1 0 0 0 1 1 0 0 1 1 1
 0 1 1 0 1 1 0 1 1 0 1 0
 0 0 0 0 1 1 1 0 0 0 0 1
 1 1 0 0 0 1 1 1 0 1 1 0
 1 1 0 1 0 0 0 1 0 0 0 0
 1 0 0 0 0 1 0 0 1 0 1 0
 1 1 0 1 0 1 0 1 0 1 0 1
 0 0 0 1 0 1 0 1 1 1 0 0
 1 0 1 0 1 0 0 0 0 0 0 0