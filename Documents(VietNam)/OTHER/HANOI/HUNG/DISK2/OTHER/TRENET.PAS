uses crt;
const  fi='trenet.inp';
       fo='trenet.out';
       ft='trenet.dat';
var    f1,f2:text;
       s,t,sb,d1,c1,d2,c2:longint;

procedure  mofile;
begin
      assign(f1,fi);
      reset(f1);
      assign(f2,ft);
      rewrite(f2);
end;

procedure  dongfile;
begin
      close(f1);
      close(f2);
end;

procedure  docfile;
begin
      readln(f1,s,t);
end;

procedure  docvaghi;
var  i:longint;
begin
      writeln(f2,sb);
      while not eof(f1) do
        begin
             readln(f1,i);
             writeln(f2,i);
        end;
end;

procedure  ghifile;
begin
       assign(f2,fo);
       rewrite(f2);
       assign(f1,ft);
       reset(f1);
         docvaghi;
       close(f1);
       close(f2);
end;

function  dong(i:longint):longint;
begin
       dong:=trunc(sqrt(i-1))+1;
end;

function  cot(i:longint):longint;
begin
       cot:=i-sqr(dong(i)-1);
end;

procedure  khoitao;
begin
      sb:=0;
      d1:=dong(s);
      c1:=cot(s);
      d2:=dong(t);
      c2:=cot(t);
end;

function  ketthuc:boolean;
begin
      ketthuc:=false;
      if s=t then ketthuc:=true;
end;

procedure  didong;
begin
      if d1>d2 then
         begin
               if  not odd(c1) then
                  begin
                         writeln(f2,s);
                         dec(d1);
                         dec(c1);
                         s:=s-2*d1;
                         inc(sb);
                  end;
         end
      else
      if d1<d2 then
         begin
               if  odd(c1) then
                  begin
                         writeln(f2,s);
                         s:=s+2*d1;
                         inc(d1);
                         inc(c1);
                         inc(sb);
                  end;
         end;
end;

procedure dicot;
begin
      if c1>=c2+(d1-d2)+1 then
         begin
                         writeln(f2,s);
                         dec(c1);
                         s:=s-1;
                         inc(sb);
         end
      else
         begin
               if c1<c2+(d1-d2)+1 then
                 begin
                         writeln(f2,s);
                         s:=s+1;
                         inc(c1);
                         inc(sb);
                 end
               else
                   begin
                           if s=sqr(trunc(sqrt(s))) then
                             begin
                                    writeln(f2);
                                    s:=s-1;
                                    dec(c1);
                                    inc(sb);
                             end
                           else
                                begin
                                                    writeln(f2);
                                                    s:=s+1;
                                                    inc(c1);
                                                    inc(sb);
                               end;
                   end;
         end;
end;



procedure  xuli;
begin
       while not ketthuc do
          begin
                 didong;
                 if not ketthuc then dicot;
          end;
          writeln(f2,t);
end;

procedure chuongtrinh;
begin
       mofile;
       docfile;
       khoitao ;
       xuli;
       dongfile;
       ghifile;
end;

begin  clrscr;
     chuongtrinh;
end.



                1
             2  3  4
          5  6  7  8  9
       10 11 12 13 14 15 16
    17 18 19 20 21 22 23 24 25
 26 27 28 29 30 31 32 33 34 35 36