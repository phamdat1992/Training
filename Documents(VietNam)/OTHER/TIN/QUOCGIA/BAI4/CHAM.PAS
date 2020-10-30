{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program cham_bai_4;
 uses crt;
 const
      fi                =               'shoes.in';
      fo                =               'shoes.ou';
      kqt               =               'r.r';
      nmax              =               100;
      dapan             :               array ['0'..'9'] of integer=(2223,78,174,228,334,551,679,905,1197,1565);
 type
      data              =               array [1..nmax] of integer;
 var
      f, g              :               text;
      h, s              :               data;
      m, n              :               integer;
      kq                :               data;
      st                :               array ['1'..'4'] of string;
      min, cl           :               integer;
      ch                :               char;
      dd                :               data;
 procedure input;
  var
      i                 :               integer;
  begin
       assign(f,fi+ch);
       reset(f);
       readln(f,m,n);
       for i:=1 to m do
           read(f,s[i]);
       readln(f);
       for i:=1 to n do
           read(f,h[i]);
       close(f);
  end;
 procedure cham;
  var
      t, i              :               integer;
  begin
       assign(f,fo+ch);
       reset(f);
       readln(f,cl);
       fillchar(dd, sizeof(dd), 0);
       t:=0;
       for i:=1 to n do
           begin
                read(f,kq[i]);
                if dd[kq[i]]=1 then
                   writeln(g,'        Mot giay nhieu nguoi di')
                else
                   begin
                        dd[kq[i]]:=1;
                        t:=t+abs(h[i]-s[kq[i]]);
                   end;
           end;
       if t<>cl then
          writeln('     Tinh chenh lech sai!')
       else
          if cl<dapan[ch] then
             begin
                  writeln(g,'       Tot hon dap an!');
                  writeln(g,'       Diem: 1');
                  exit;
             end
          else
             if cl=dapan[ch] then
                begin
                     writeln(g,'        Tot!');
                     writeln(g,'        Diem: 1');
                     exit;
                end;
       writeln(g,'Diem: 0');
       close(f);
  end;
 begin
      clrscr;
      write('Cham bai hoc sinh: ');
      readln(st['1']);
      assign(g,kqt);
      append(g);
      writeln(g,'-------------------------------------------------');
      writeln(g,'Cham bai hoc sinh ',st['1'],': ');
      min:=maxint;
      for ch:='0' to '9' do
          begin
               input;
               writeln(g,'Test ',ch,':');
               cham;
          end;
      close(g);
      readln;
 end.
