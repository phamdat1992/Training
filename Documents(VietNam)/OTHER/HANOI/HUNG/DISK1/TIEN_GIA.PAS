program tien_gia_cach2;
var gtri:array[1..200] of integer;
    m1,m2:array[1..100] of integer;
    n,k,p:integer;
    dau:char;

procedure init;
begin
   fillchar(gtri,sizeof(gtri),0);
end;

procedure readfile;
var f:text;
    i,j:integer;
begin
   assign(f,'can.inp');
   reset(f);
      readln(f,n,k);
      for i:=1 to k do
            begin
                read(f,p);
                for j:=1 to p do
                    read(f,m1[j]);
                for j:=1 to p do
                    read(f,m2[j]);
                readln(f);
                readln(f,dau);
                case dau of
                    '<':begin
                          for j:=1 to p do
                             begin
                                gtri[m1[j]]:=gtri[m1[j]]-1;
                                gtri[m2[j]]:=gtri[m2[j]]+1;
                             end;
                        end;
                    '>':begin
                           for j:=1 to p do
                              begin
                                 gtri[m1[j]]:=gtri[m1[j]]+1;
                                 gtri[m2[j]]:=gtri[m2[j]]-1;
                              end;
                        end;
                     '=':begin
                            for j:=1 to p do
                               begin
                                  gtri[m1[j]]:=0;
                                  gtri[m2[j]]:=0;
                               end;
                         end;
                end;
            end;
   close(f);
end;

procedure process;
var i,max,d,l:integer;
begin
  max:=0; d:=0;
  for i:=1 to n do
     if abs(gtri[i])>max then
          max:=abs(gtri[i]);
  for i:=1 to n do
     if abs(gtri[i])=max then begin d:=d+1;l:=i;end;
  if d<>1 then writeln('Chua xac dinh duoc.')
  else writeln(l);
end;

Begin
  init;
  readfile;
  process;
Readln;
End.

6 4
3 1 1 3 4 5 6
<
1 1 2
=
2 1 3 4 5
<
2 4 5 2 6
>
6 2
2 3 4 5 6
<
1 5 4
>

6 4
2 2 3 4 5
<
1 1 5
=
1 2 3
=
1 4 6
>










