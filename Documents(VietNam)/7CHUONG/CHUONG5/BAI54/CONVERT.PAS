PROGRAM BIEN_DOI_XAU;
uses crt;
const fi='C:\data\hung\hanoi2\convert\convert.in1';
      fo='convert.out';
var   f:text;
      st1,s1,s2,st2:string[100];
      a1,a2:array[1..100] of byte;
      n,i,j:byte;
      traloi:string;
      ok:boolean;

procedure nhap;
begin
     assign(f,fi);reset(f);
     readln(f,s1);
     readln(f,s2);
     close(f);
end;

function dempt(stri:string;i,j:byte):byte;
var k,u:byte;
begin
     u:=0;
     for k:=i to j do
     if stri[k]='1' then inc(u);
     dempt:=u;
end;

procedure xuli;
var  dem,dem2,u,v:byte;
     str:string[100];
begin
     st1:=s1;st2:=s2;
     assign(f,fo);rewrite(f);
     n:=length(st1);
     if dempt(st1,1,n)<>dempt(st2,1,n) then
     begin
          writeln(f,'NO');
          close(f);
          exit;
     end;
     writeln(f,'YES');
     for i:=1 to n-1 do
          if st1[i]<>st2[i] then
          begin
               dem:=0;
               for j:=i to n do
               begin
                    if st1[j]='1' then inc(dem);
                    if (st1[j]=st2[i])and(dem mod 2=0)then
                    begin
                         str:='';
                         for u:=j downto i do
                          str[u]:=st1[i+(j-u)];
                         for u:=i to j do st1[u]:=str[u];
                          writeln(f,i,' ',j);
                         break;
                    end;
               end;
          end;
     close(f);
     if st1<>st2 then
     begin
          assign(f,fo);rewrite(f);
          writeln(f,'NO');
          close(f);
     end;
end;

BEGIN
     clrscr;
     nhap;
     xuli;
END.
100011100
001011001
