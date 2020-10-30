                (*   **********************************   *)
                (*    Le Van Hung K28 A2 Phan Boi Chau    *)
                (*   **********************************   *)
{ $ R + }

program         queen;
uses            crt;
const
     fi         =       'QUEEN.IN4';
     fo         =       'QUEEN.OUT';
type
    point       =       record
     x , y      :       integer;
    end;
var
   a            :       array [ 1..100 ] of point;
   f            :       text;
   cot          :       array [ 1..100 ] of boolean;
   cheo1        :       array [ 2..200 ] of boolean;
   cheo2        :       array [ -99..99 ] of boolean;
   n , count    :       integer;
   i            :       integer;
   aa           :       array [ 1..100 , 1..100 ] of byte;

   procedure            readfile;
   var
      i         :       integer;
      begin
           assign(f,fi);
           reset(f);
           readln(f,n);
           for i:=1 to n do
            readln(f,a [ i ].x , a [ i ].y);
           close(f);
      end;

   procedure            init;
   begin
        count:=0;
        fillchar ( aa , sizeof (aa ) , 0 );
        fillchar ( cheo1 , sizeof( cheo1 ) , true);
        fillchar ( cheo2 , sizeof( cheo2 ) , true);
        fillchar ( cot   , sizeof( cot   ) , true);
        for i:=1 to n do
         begin
              cheo1 [ a [ i ].x + a [ i ].y ]:= false;
              cheo2 [ a [ i ].x - a [ i ].y ]:= false;
              cot   [ a [ i ].y ] := false;
              aa [ a [ i ].x , a [ i ].y ] :=1;
         end;
   end;

   procedure            tao_nguoc  (  p   :    point  ) ;
   begin
        cheo1 [ p.x + p.y ] := true;
        cheo2 [ p.x - p.y ] := true;
        cot   [ p.y ] := true;
   end;

   procedure            bieu_dien  ( x1 , x2 , x3    :     point );
   var
      i , j     :       integer;
      begin
           clrscr;
           aa [ x1.x , x1.y ] := 2;
           aa [ x2.x , x2.y ] := 3;
           aa [ x3.x , x3.y ] := 4;
           for i:=1 to n do
            begin
                 for j:=1 to n do
                  if aa [ i , j ] = 0 then
                  begin
                       textcolor(4);
                       write( 'X ' , ' ');
                  end
                  else
                  if aa [ i , j ]=1 then
                  begin
                       textcolor(7);
                       write( '* ' , ' ');
                  end
                  else
                  begin
                       textcolor( 10 );
                       if aa [ i , j ] = 2 then
                       write( '*1' , ' ')
                       else
                       if aa [ i , j ] = 3 then
                       write( '*2' , ' ')
                       else
                       write( '*3' , ' ')
                  end;
                 writeln;
            end;
           aa [ x1.x , x1.y ] := 1;
           aa [ x2.x , x2.y ] := 1;
           aa [ x3.x , x3.y ] := 1;
      end;

   procedure            tao_thuan  (  p   :    point   ) ;
   begin
        cheo1 [ p.x + p.y ] := false;
        cheo2 [ p.x - p.y ] := false;
        cot   [ p.y ] := false;
   end;

   function             thoa_man  (  p            :    point ) : boolean;
   begin
        if cheo1 [ p.x + p.y ] and cheo2 [ p.x - p.y ] and cot [ p.y ] then
         thoa_man:=true else thoa_man:=false;
   end;

   procedure            xuli  ( i , j , k      :    integer ) ;
   var
      x1 , x2 , x3      :       point;
      begin
           tao_nguoc ( a [ i ] );
           tao_nguoc ( a [ j ] );
           tao_nguoc ( a [ k ] );
           x1.x := a [ i ].x;
           x1.y := a [ j ].y;
           x2.x := a [ j ].x;
           x2.y := a [ k ].y;
           x3.x := a [ k ].x;
           x3.y := a [ i ].y;
           if thoa_man ( x1 ) and thoa_man ( x2 ) and thoa_man ( x3 ) then
           begin
                inc (count);
                readln;
           end;
           x1.y := a [ i ].y;
           x1.x := a [ j ].x;
           x2.y := a [ j ].y;
           x2.x := a [ k ].x;
           x3.y := a [ k ].y;
           x3.x := a [ i ].x;
           if thoa_man ( x1 ) and thoa_man ( x2 ) and thoa_man ( x3 ) then
           begin
                inc (count);
                readln;
           end;
           tao_thuan ( a [ i ] );
           tao_thuan ( a [ j ] );
           tao_thuan ( a [ k ] );
      end;

   procedure            process;
   var
      i , j , k         :       integer;
      begin
           for i:=1 to n-2 do
            for j:=i+1 to n-1 do
             for k:=j+1 to n do
              xuli( i , j , k );
      end;

   procedure            writefile;
   begin
        assign(f,fo);
        rewrite(f);
        writeln(f,count);
        close(f);
   end;

BEGIN
     clrscr;
     readfile;
     init;
     process;
     writefile;
END.
