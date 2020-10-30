Program sinhtest_activity;
Const
     dl         =       'activity.in9p';
     n          =       800000;
     g_han      =       32000;
Var
   i, u, v      :       longint;
   f            :       text;
Begin
Assign(f, dl);
Rewrite(f);
Writeln(f, n);
Randomize;
For i := 1 to n do
    Begin
    Repeat
          u := random(g_han) + 1;
          v := random(g_han) + 1;
          Until u < v;
    writeln(f, u, ' ', v);
    End;
Close(f);
End.