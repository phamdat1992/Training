uses crt;
const fi='vat.inp';
      fo='vat.out';
type int=integer;
var  x:char;
     d:array[1..10] of char;
     ok:array[0..9] of boolean;
     luu,luu1:array[1..10000] of char;
     n,m,i,j:word;
     th:set of char;

procedure df;
var f:text;code:int;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do read(f,d[i]);readln(f);
     m:=0;
     while not eoln(f) do
     begin
          read(f,x);
          inc(m);
          luu[m]:=x;
     end;
     close(f);
end;

procedure xl;
var u,v:char;
    f:text;
    tim:boolean;
    hon:byte;
begin
     assign(f,fo);rewrite(f);
     for i:=1 to n do th:=th+[d[i]];
     for i:=1 to m+1 do luu1[i]:=' ';
     hon:=0;
     i:=0;
     repeat
           inc(i);
           if hon=1 then
           begin
                for u:='0' to '9' do
                if not(u in th) then
                begin
                     for j:=1 to i-1 do write(f,luu1[i]);
                     for j:=i to m do write(f,u);
                     close(f);
                     exit;
                end;
           end;
           if i=1 then
           begin
                if luu[i]<>'9' then
                begin
                     tim:=false;

                     for u:='1' to '9' do
                     if not(u in th)and(ord(u)>=ord(luu[i])) then
                     begin
                          tim:=true;
                          luu1[i]:=u;
                          if ord(luu1[i])>ord(luu[i])then hon:=1;
                          if ord(luu1[i])=ord(luu[i])then hon:=0;
                          break;
                     end;
                     if not tim then exit;
                end
                else
                begin
                     for u:='1' to '9' do
                     if not(u in th) then
                     begin
                          write(f,u);
                          break;
                     end;
                     for u:='0' to '9' do
                     if not(u in th) then
                     begin
                          for j:=2 to m+1 do write(f,u);
                          close(f);
                          exit;
                     end;
                end;
           end  {if i=1}
           else {if i=1}
           begin
                if luu[i]<>'9' then
                begin
                     tim:=false;
                     if luu[i+1]='9' then
                     begin
                          for u:='0' to '9' do
                          if not(u in th) then
                          begin
                               tim:=true;
                               luu1[i]:=u;
                               if ord(luu1[i])>ord(luu[i]) then hon:=1;
                               if ord(luu1[i])=ord(luu[i]) then hon:=0;
                               if ord(luu1[i])<ord(luu[i]) then hon:=2;
                               break;
                          end;
                          if hon=2 then
                          begin
                               write(f,luu1[i]);
                               for u:='0' to '9' do
                               if not(u in th) then
                               begin
                                    for j:=i+1 to m+1 do write(f,u);
                                    close(f);
                                    exit;
                               end;
                          end;
                     end;
                end
                else
                begin
                     for u:='1' to '9' do
                     if not(u in th) then
                     begin
                          write(f,u);
                          break;
                     end;
                     for u:='0' to '9' do
                     begin
                          for j:=2 to m+1 do write(f,u);
                          close(f);
                          exit;
                     end;
                end;
           end;
     until i=m;
     close(f);
end;

BEGIN
     df;xl;
END.