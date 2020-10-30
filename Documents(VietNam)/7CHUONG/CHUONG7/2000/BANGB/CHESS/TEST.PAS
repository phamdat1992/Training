Program eval_b2;
uses crt;
const
  a:array[0..9] of integer =(-1,2,2,1,2,-1,2,1,1,-1);
  b:array[0..9] of integer = (0 ,5,15,14,98,0,45,10164,20000,0);
 Var i,j,d: integer;
     k1,k2: longint;
     ok: boolean;
     c: char;
     f: text;
BEGIN
   Clrscr;  textcolor(white);
   k1 := -10; k2 := -10;
   write( '                       **** TEST ');
   repeat
    c := readkey
   until pos(c,'0123456789') > 0;
   writeln(c);
   i := ord(c) -48;
   write(' **** Can co:       ');
   case i of
      0,5,9: writeln( a[i]:3)
      else
       begin
         textcolor(10);
         writeln(a[i]: 3,b[i]:7);
         textcolor(white)
       end
     end;
   {$I-}
   assign(f,'CHESS.OUT');
   reset(f);
   {I+}
   ok := IOResult = 0;
   if not ok then
      begin
            textcolor(red);
            writeln(' Khong co file ket qua! ');
            textcolor(white);
            write( '  ####  Diem: ');
            textcolor(lightblue);
            writeln(d);
            textcolor(white);
      end
   else
    begin
      readln(f,k1,k2);
      close(f);
      write( ' #### Ket qua nhan duoc: ');
      case i of
       5,9:begin
            textcolor(yellow);
            writeln(k1);
            textcolor(white);
            if k1 = a[i] then d := 1
           end
       else
         begin
           textcolor(yellow);
          if k2 = 0 then write(k1) else  write( k1,'  ',k2);
           textcolor(white);
          if ( a[i] = k1) and (b[i] = k2) then d := 1
        end
       end;
       writeln;
        write( ' ####  Diem: ');
        textcolor(blink+11);
        writeln(d:5);
        textcolor(white);
       writeln(#13#10, ' %%%% File output da bi xoa! ');
       erase(f)
    end;
  repeat
  until keypressed
END.
