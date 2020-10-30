{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program dem;
 const
      fi                =               'count.in1';
      fo                =                'count.11';
      nmax              =               16001;
 type
      data              =               array [1..nmax] of byte;
 var
      f, g              :               text;
      d                 :               data;
      n, i, t, k        :               integer;
      time              :               longint absolute $0000:$0046c;
      ts                :               longint;
 procedure open_file;
  begin
       assign(f,fi);
       reset(f);
       assign(g,fo);
       rewrite(g);
       readln(f,n);
  end;
 procedure init;
  var
      i                 :               integer;
  begin
       fillchar(d, sizeof(d), 0);
       d[n+1]:=1;
  end;
 procedure xuly;
  var
      ii, j, max        :               integer;
      dem, l            :               integer;
      ok                :               boolean;
  begin
       ok:=false;
       while not seekeof(f) do
             begin
                  read(f,k);
                  i:=0;
                  t:=0;
                  while not seekeoln(f) do
                        read(f,i,t);
                  if (i=0) and (t=0) then
                     begin
                          ii:=0;
                          if ok=false then
                             begin
                                  max:=0;
                                  ok:=true;
                                  repeat
                                        inc(ii);
                                        if d[ii]=0 then
                                           begin
                                                for j:=ii to n+1 do
                                                    if d[j]=1 then
                                                       begin
                                                            if (j-ii+1)>max then
                                                               max:=j-ii;
                                                            ii:=j;
                                                            break;
                                                       end;
                                           end;
                                 until ii>=n;
                             end;
                          writeln(g,max);
                     end
                  else
                     begin
                          ok:=false;
                          l:=k mod 2;
                          for j:=i to i+t-1 do
                              d[j]:=l;
                     end;
             end;
  end;
 procedure close_file;
  begin
       close(f);
       close(g);
  end;
 begin
      ts:=time;
      open_file;
      init;
      xuly;
      close_file;
      writeln((time-ts)/18.2:0:4);
      readln;
 end.