uses crt;
const
   finp: string='SINGLE.IN';
   fout='SINGLE.OUT';
   dapso: array['1'..'5'] of byte=(1,0,1,0,0);
   dapso1: array[1..7] of integer =(2, 1, 2, 3, 3, 1, 2);
var
   Ke: array[1..200, 1..200] of byte;
   Path, Nke, DFNum: array[1..300] of integer;
   Mark: array[1..300] of boolean;
   diem, n, Count: integer;
   Simple: boolean;
   f: text;
   chon: char;

procedure Nhapdl;
var  i,j,t,Nv: integer;
begin
   assign(f,finp);
   reset(f);
   readln(f,n);
   fillchar(Ke, sizeof(Ke),0);
   for i:=1 to n do
   begin
       read(f,t);
       Nv:=0;
       if t<>0 then
       begin
           Ke[i,t]:=1;
           Nv:=Nv+1;
           while not seekeoln(f) do
           begin
               read(f,t);
               Ke[i,t]:=1;
           end;
       end;
       Nke[i]:=Nv;
   end;
   close(f);
   writeln('***  Du lieu nhap vao:');
   for i:=1 to n do
   begin
       write('Dinh ',i:4,' co ',Nke[i]:4,' dinh ke: ');
       for j:=1 to n do if Ke[i,j]<>0 then write(j:4);
       writeln;
   end;
end;

procedure DFS(v: integer);
var i: integer;
begin
    Mark[v]:=false;
    for i:=1 to n do
       if Mark[i] and (Ke[v,i]=1) then
       begin
          Path[i]:=v;
          DFS(i);
       end;
end;


procedure Eval;
var i, ans1, t, u, s, dai: integer;
    fo: string;
    ans: string;
begin
    diem:=0;
    write('Cho ten file test: SIGLE.IN');chon:=readkey;
    writeln(chon);
    finp:='SINGLE.IN'+chon;
    Nhapdl;
    assign(f,fout); reset(f);
    readln(f,ans);
    for i:=1 to length(ans) do ans[i]:=upcase(ans[i]);
    writeln('Cau tra loi: ',ANS);readln;
    if (ans<>'YES') and (ans<>'NO') then
    begin
        writeln('Tra loi khong dung theo khuon dang file ket qua!!!');
        readln; exit;
    end;
    if ans='YES' then ans1:=1 else ans1:=0;
    if ans1<>dapso[chon] then
    begin
        writeln('ERROR:  Tra loi sai!!!');
        readln;close(f);
        exit;
    end;
    case chon of
        '1': begin
                 for i:=1 to 7 do
                 begin
                    read(f,t);
                    if t<> dapso1[i] then
                    begin
                        writeln('Sai do dai tu dinh 1 den dinh ',i);
                        readln;close(f); exit;
                    end;
                 end;
             end;
        '3':  begin
                 for i:=1 to n-1 do
                 begin
                    read(f,t);
                    if t<> 0 then
                    begin
                        writeln('Sai do dai tu dinh 1 den dinh ',i);
                        readln; close(f);exit;
                    end;
                 end;
             end;
         '2','4','5':
              begin
                  (*   Kiem tra 2 duong di don  *)
                  read(f,s,t); close(f);
                  for i:=1 to n do Mark[i]:=true;
                  DFS(s);
                  if Mark[t] then
                  begin
                      writeln('ERROR:  Khong co duong di tu ',s,' den ',t);
                      readln; exit;
                  end;
                  for i:=1 to n do Mark[i]:=true;
                  u:=Path[t];dai:=1;
                  while u<> s do
                  begin
                      dai:=dai+1;
                      Mark[u]:=false;
                      u:=Path[u];
                  end;
                  if dai=1 then Ke[s,t]:=0;
                  DFS(s);
                  if Mark[t] then
                  begin
                      writeln('ERROR:  Khong co duong di thu hai tu ',s,' den ',t);
                      readln; exit;
                  end;
              end;
    end;
    writeln;
    writeln('*****************************');
    writeln('***    C O R R E C T !    ***');
    writeln('*****************************');
    diem:=2;
end;


BEGIN
    clrscr;
    writeln('+++++++++++++++++++++++++++++++++++++++++++++++');
    writeln('   CHUONG TRINH CHAM BAI MANG LIEN THONG DON   ');
    writeln('+++++++++++++++++++++++++++++++++++++++++++++++');
    writeln;
    EVAL;
    writeln;
    writeln('******************************');
    writeln('***   Diem cua bai: ',diem:3,'    *** ')     ;
    writeln('******************************');
    readln;

END.