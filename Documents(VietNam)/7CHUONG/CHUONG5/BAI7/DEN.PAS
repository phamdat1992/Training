uses crt;
const
     fi='party.inp';
     fo='party.out';
var
   s,on,off     :       Set of 1..4;
   f            :       Text;
   i1,i2,i3,i4  :       Integer;
   n,c,k,m,i,j  :       Integer;

procedure rf;
begin
     assign(f,fi);reset(f);readln(F,n);readln(F,c);
     read(f,j);
     on:=[];
     while j<>-1 do
     begin
          if j mod 3<>1 then
           if odd(j) then on:=on+[1]
           else on:=on+[2];
          if j mod 3=1 then
           if odd(j) then on:=on+[3]
           else on:=on+[4];
          read(f,j);
     end;
     if j=-1 then readln(f);
     read(f,j);
     off:=[];
     while j<>-1 do
     begin
          if j mod 3<>1 then
           if odd(j) then off:=off+[1]
           else off:=off+[2];
          if j mod 3=1 then
           if odd(j) then off:=off+[3]
           else off:=off+[4];
          read(f,j);
     end;
     clrscr;
     write('  on  ');
     for i:=1 to 4 do
      if i in on then write(i,' ');writeln;
      write(' off  ');
     for i:=1 to 4 do
      if i in off then write(i,' ');writeln;
     close(f);
end;

procedure xuli;
begin
     for i1:=0 to 1 do
      for i2:=0 to 1 do
       for i3:=0 to 1 do
        for i4:=0 to 1 do
         if i1+i2+i3+i4<=c then
         begin
              s:=[1..4];
              for m:=1 to 4 do
               case m of
                1: if odd(i1+i2) then s:=s-[1];
                2: if odd(i1+i3) then s:=s-[2];
                3: if odd(i1+i2+i4) then s:=s-[3];
                4: if odd(i1+i3+i4) then s:=s-[4];
               end;
              if (on<=s)and(off<=[1..4]-s) then
              begin
                   for j:=1 to n do
                    begin
                         if j mod 3 <>1 then
                          if odd(j) then
                          begin
                               if 1 in s then write(f,1) else write(f,0);
                          end
                          else if 2 in s then write(f,1) else write(f,0);
                          if j mod 3=1 then
                           if odd(j) then
                           begin
                                if 3 in s then write(f,1) else write(f,0);
                           end
                           else if 4 in s then write(f,1) else write(f,0);
                    end;
                    writeln(f);
              end;
         end;
end;

procedure wf;
begin
     assign(f,fo);rewrite(f);
     xuli;
     close(f);
end;

begin
     rf;wf;
end.
10
1
-1
7 -1
