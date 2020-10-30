{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 65521,0,655360}
const   fi              =               'ghep.in9';
        fo              =               'ghep.out';   {ghep.ou9}
                                                      {0 sai 2;1,8,9 sai 1}
        fo1             =               'ghep1.out';
        dx              :               array[1..4] of integer = (1,0,-1,0);
        dy              :               array[1..4] of integer = (0,-1,0,1);
type    bg              =               record
                                              x,y,z,t,m:integer;
                                        end;
        bg1             =               record
                                              u,v:integer;
                                        end;
        mang            =               array[1..100] of bg;
        mang1           =               array[-30..30,-30..30] of integer;
        mang2           =               array[-30..30,-30..30] of boolean;
        mang3           =               array[1..64] of bg1;
var     d               :               mang;
        tham            :               mang2;
        kq              :               mang3;
        dd              :               mang1;
        n,a,b,dt,dem,p,q:               integer;
        f,g             :               text;
        ok              :               boolean;
procedure nhap;
    var i:integer;
    begin
         readln(f,a,b,n);
         for i:=1 to n do
             readln(f,d[i].x,d[i].y,d[i].z,d[i].t,d[i].m);
         dem:=0;
    end;
procedure gan;
    var i,j,k:integer;
    begin
         fillchar(dd,sizeof(dd),0);
         for i:=1 to n do
             for j:=d[i].x+1 to d[i].z do
                 for k:=d[i].y+1 to d[i].t do
                     dd[j,k]:=d[i].m;
    end;
function trong(x,y:integer):boolean;
    begin
         trong:=(y>=-(b div 2)) and (y<= (b div 2) + (b mod 2))
         and (x>=-(a div 2)) and (x<=(a div 2)+(b mod 2));
    end;
procedure lienthong(x,y:integer);
    var u,v,i:integer;
    begin
         tham[x,y]:=true;
         inc(dt);
         for i:=1 to 4 do
             begin
                  u:=x+dx[i];
                  v:=y+dy[i];
                  if (not tham[u,v]) and (dd[u,v]=dd[x,y]) and trong(u,v) then
                     lienthong(u,v);
             end;
    end;
procedure xuly;
    var i,j:integer;
    begin
         for i:=-(a div 2)+p to (a div 2)+q do
             for j:=-(b div 2)+p to (b div 2)+q do
                 if dd[i,j] = 0 then dd[i,j]:=1;
         for i:=-(a div 2)+p to (a div 2)+q do
             for j:=-(b div 2)+p to (b div 2)+q do
                 begin
                      dt:=0;
                      if not tham[i,j] then
                         begin
                              lienthong(i,j);
                              inc(dem);
                              kq[dem].u:=dd[i,j];
                              kq[dem].v:=dt;
                         end;
                 end;
    end;
procedure QuickSort(var a: mang3;dem : Integer);
    procedure Sort(l, r: Integer);
    var i, j, x: integer;
        y:bg1;
    begin
         i := l;
         j := r;
         x := a[(l+r) DIV 2].u;
         repeat
               while a[i].u < x do i := i + 1;
               while x < a[j].u do j := j - 1;
               if i <= j then
                  begin
                       y := a[i];
                       a[i] := a[j];
                       a[j] := y;
                       i := i + 1;
                       j := j - 1;
                  end;
         until i > j;
         if l < j then Sort(l, j);
         if i < r then Sort(i, r);
    end;
    begin
         Sort(1,dem);
    end;
procedure viet;
    var i,t,vt:integer;
    begin
         quicksort(kq,dem);
         if (odd(a) and (not odd(b))) or (odd(b) and (not odd(a))) then
            begin
         t:=0;
         for i:=1 to dem do
             if (kq[i].u=1) and (kq[i+1].u=1) then t:=t+kq[i].v
             else
                 if kq[i].u=1 then vt:=i
                 else
                     if kq[i].u<>1 then t:=t+kq[i].v;
         kq[vt].v:=a*b-t;
         end;
         for i:=1 to dem do
             writeln(g,kq[i].u:10,kq[i].v:10);
    end;
procedure v;
    var i,j:integer;
    begin
         assign(f,fo1);
         rewrite(f);
         for i:=-10 to 10 do
             begin
                  for j:=-10 to 10 do
                      write(f,dd[i,j],' ');
                  writeln(f);
             end;
         close(f);
    end;
begin
     assign(f,fi);
     reset(f);
     assign(g,fo);
     rewrite(g);
     while not eof(f) do
           begin
                nhap;
                fillchar(tham,sizeof(tham),false);
                ok:=false;
                p:=0;
                q:=0;
                if not odd(a) then
                   begin
                        p:=1;
                        if odd(b) then q:=1;
                   end;
                gan;
                xuly;
                viet;
                writeln(g);
           end;
     close(f);
     close(g);
     v;
end.