  uses crt;
  var  s:array[0..256] of integer;
       s1:array[0..256] of real;
       tg,st:string;
       p:integer;
       f:text;

   procedure  readfile;
   begin
     assign(f,'balan.inp');
     reset(f);
     readln(f,st);
     close(f);
     writeln('----------------------------------------------------------');
     writeln('INPUT:');
     writeln(st);
     writeln('__________________________________________________________');
    end;

    procedure  push(i:integer);
    begin
        inc(p);
        s[p]:=i;
    end;

    procedure  push1(i:real);
    begin
        inc(p);
        s1[p]:=i;
    end;

    function pop:integer;
    begin
      pop:=s[p];
      dec(p);
    end;

    function pop1:real;
    begin
      pop1:=s1[p];
      dec(p);
    end;

    procedure  chuyen;
    var i,x:integer;
        ch:char;
    begin
      p:=0;
      i:=1;
      repeat
       if st[i]='(' then  push(ord(st[i]));
       if (st[i]>='0') and(st[i]<='9') then
        begin
           while (st[i]>='0') and(st[i]<='9') do
            begin
               tg:=tg+st[i];
               inc(i);
             end;
           i:=i-1;
           tg:=tg+' ';
         end;
        if (st[i]='+') or(st[i]='-') then
          begin
            if (p>0) and (s[p]<>ord('(')) then  tg:=tg+chr(pop)+' ';
            push(ord(st[i]));
          end;
    if (st[i]='*') or(st[i]=':') then
       begin
         if (p>0) and(chr(s[p])='*') or (chr(s[p])=':') then  tg:=tg+chr(pop)+' ';
         push(ord(st[i]));
       end;
    if st[i]=')'then
      begin
        while (s[p]<>ord('('))  do tg:=tg+chr(pop)+' ';
        x:=pop;
      end;
   inc(i);
 until  i>length(st);
 while p>0 do tg:=tg+chr(pop);
 writeln('OUTPUT1:');
 writeln(tg);
 end;

 procedure  tinh;
 var i:integer;x:real;
 begin
    i:=1; p:=0;
   repeat
     x:=0;
     if tg[i]='+' then begin x:=pop1+pop1;push1(x);end;
     if tg[i]='*' then begin x:=pop1*pop1;push1(x);end;
     if tg[i]='-' then begin x:=pop1-pop1;push1(x);end;
     if tg[i]=':' then begin x:=pop1/pop1;push1(x);end;
     if (tg[i]>='0') and(tg[i]<='9') then
       begin
         while (tg[i]>='0') and (tg[i]<='9') do
           begin x:=x*10+ord(tg[i])-ord('0');
             inc(i);
           end;
           push1(x);
       end;
        inc(i);
    until i>length(tg);
    writeln('OUTPUT2:');
    writeln(pop1:0:3);
   end;

 begin  clrscr;
   readfile;
   chuyen;
   tinh;
   readln
 end.
 (32:8+4*(5-2))*5



