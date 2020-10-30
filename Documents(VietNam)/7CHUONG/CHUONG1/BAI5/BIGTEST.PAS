PROGRAM Big_test ;
const   Fi        = 'activity.in7' ;

Var     F          : Text ;
        i ,N ,u ,v : Longint ;

Begin
  N := 500000 ;
  Assign(F ,Fi) ;
  Rewrite(F) ;
  Writeln(F ,N) ;
  Randomize;
  For i := 1 to N do
    Begin
      u := 1+random(20000) ;
      v := random(9000) ;
      Writeln(F ,u,' ',u+v) ;
    End ;
  Close(F) ;
end .