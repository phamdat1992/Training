uses  crt;
var   tf1,tf2,ltf1,s : string;
      f1,f2          : text;
      p,i            : integer;
begin
      clrscr;
      write('ten file dang can sua (nhap ca phan mo rong) : ');readln(tf1);
      p := pos('.',tf1);
      ltf1 := tf1;
      if p>0 then
          delete(tf1,p,length(tf1)-p+1);
      tf2 := tf1+'.pas';
      tf1 := ltf1;
      assign(f1,tf1);
      reset(f1);
      assign(f2,tf2);
      rewrite(f2);
      while not eof(f1) do
      begin
          readln(f1,s);
          for i:=1 to length(s) do
              if s[i] in ['A'..'Z'] then s[i] := char(ord(s[i])+32);
          writeln(f2,s);
      end;

      close(f2);
      erase(f1);
end.