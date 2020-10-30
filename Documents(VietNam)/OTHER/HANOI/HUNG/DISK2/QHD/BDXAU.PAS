  uses crt;
  var a:array[1..50,1..50] of integer;
      s1,s2:string;  m,n,l:integer;
      f:text;

  function  t(i,j:integer):integer;
    begin
          if s1[ i]=s2[j] then t:=0
           else t:=1;
    end;
   (*-----------------------------------------*)

  function tin(i,j:integer):integer;
   begin
       tin:=10000;
       if (i>1) and (j>1) then
       if (s1[i-1]=s2[j])and (s1[i]=s2[j-1]) then
       tin:=1;
    end;
   (*------------------------------------------*)

   function  min(d,b,c:integer):integer;
     var tg:integer;
     begin  tg:=d;
          if b < tg then tg:=b;
          if c<tg then tg:=c;
          min:=tg;
     end;
   (*-------------------------------------------*)

  procedure  bd1(i,j:integer);
    begin  write(' xoa ki tu s1[',i,'] =', s1[i],'/',i);
           delete (s1,i,1);
           write('==>',s1);
           inc(l);
           writeln;
    end;
   (*-------------------------------------------*)

    procedure  bd2(i,j:integer);
    begin
          write(' them ',s2[j],'/',i+1);
          insert(s2[j],s1,i+1);write('==>',s1);
          inc(l);
          writeln;
    end;
    (*------------------------------------------*)

   procedure  bd3(i,j:integer);
     begin if s1[i]<>s2[j]  then
          begin
                 write(' thay s1[',i,']=', s1[i] ,'/', i ,' boi ', s2[j],'/',j);
                 s1[i]:=s2[j];
                 write('==>',s1);
                 inc(l);
                 writeln;
          end;
     end;
    (*--------------------------------------------*)

   procedure  bd4(i,j:integer);
    var tg:char;
    begin   if (i>1) and (j>1) then
         begin
             write(' doi  ', s1[i],'/',i,' cho ',s1[j-1],'/',j-1 );
             tg:=s1[i];
             s1[i]:=s2[j-1];
             s2[j-1]:=tg;
             tg:=s1[i-1];
             s1[i-1]:=s2[j];
             s2[j]:=tg;
             l:=l+1;
             writeln('==>',s1);
        end;
    end;
    (*-----------------------------------------------*)

   procedure  taomang;
     var i,j:integer;
     begin
      for i:=0 to m do
         for j:=0 to n do
          begin
           if i=0 then a[i,j]:=j
           else
            begin
                if j=0 then a[i,j]:=i
                else
             begin
                if (i>1) and (j>1)and (a[i,j]>a[i-2,j-2]+tin(i,j))
                then a[i,j]:=a[i-2,j-2]+tin(i,j);
               a[i,j]:=min(a[i-1,j]+1,a[i,j-1]+1,a[i-1,j-1]+t(i,j));
         end;
      end;
          end;

     end;
    (*--------------------------------------------------------*)

  procedure  main;
  var i,j:integer;
    begin
    taomang;
    write(' can it nhat  ', a[m,n] ,' phep bien doi');
    writeln;
     i:=m;j:=n;
     repeat
     if i=0 then begin  bd2(i,j);j:=j-1;writeln; end
     else
     begin
       if j=0 then begin bd1(i,j);writeln; end
       else
        begin
           if a[i,j]=a[i-1,j]+1 then begin bd1(i,j);i:=i-1;writeln;end
           else
             begin
               if a[i,j]=a[i,j-1]+1 then
                 begin
                    bd2(i,j);
                    j:=j-1;   writeln;
                 end
               else
                 if a[i,j]=a[i-1,j-1]+1 then
                   begin
                     bd3(i,j);
                     i:=i-1;j:=j-1;
                    end
        else  begin
        {            bd4(i,j);
                    i:=i-2;j:=j-2;}
              end;
         end;
      end;
    end;
  until l>=a[m,n] ;
   end;
    (*---------------------------------------------------------------*)
   BEGIN clrscr;
     assign(f1,'bdxau1.inp');
     reset(f1);
     while not (eof) do
     begin
     s1:='';
     repeat
      read(f1,ch);
      s1:=s1+ch;
     until ch=' ';
     delete(s1,length(s1),1);
     assign(f2,'bdxau2.inp');
     reset(f2);
     readln(f2,m);
     for i:=1 to m do
      begin
       readln(f2,s2);
       fillchar(a,sizeof(a),0);
       m:=length(s1);n:=length(s2);
       taomang;
       write(a[m,n]:4);
      end;
      writeln;
      end;
     readln;
   END.




