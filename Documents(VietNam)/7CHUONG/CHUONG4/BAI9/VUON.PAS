const
     fi='vuon.inp';
     fo='vuon.out';
var
   dx,dy:array[1..4000] of longint;
   n,max,xd,yd,xt,yt:longint;
procedure init;
var
   f:text;
   i:longint;
begin
     dx[1]:=0;              dy[1]:=0;
     dx[2]:=0;              dy[2]:=1000;
     dx[3]:=1000;           dy[3]:=1000;
     dx[4]:=1000;           dy[4]:=0;
     assign(f,fi);
     reset(f);
     readln(f,n);
     n:=n+4;
     for i:=5 to n do readln(f,dx[i],dy[i]);
     close(f);
     max:=0;
     xd:=0;
     yd:=0;
     xt:=0;
     yt:=0;
end;

procedure them;
var i,j:longint;
    procedure dc(x,y:longint);
    begin
         inc(n);
         dx[n]:=x;
         dy[n]:=y;
    end;
begin
     j:=n;
     for i:=5 to j do
     begin
          dc(dx[i],0);
          dc(dx[i],1000);
          dc(0,dy[i]);
          dc(1000,dy[i]);
     end;
end;

procedure sapxep;
var
   i,j,tg:longint;
begin
     for i:=1 to n-1 do
         for j:=i+1 to n do
         if dx[i]>dx[j] then
         begin
              tg:=dx[i] ;   dx[i]:=dx[j] ;   dx[j]:=tg;
              tg:=dy[i] ;   dy[i]:=dy[j] ;   dy[j]:=tg;
         end;
end;

procedure tim;
var
   i,j,tren,duoi,th:longint;
   tam:longint;
begin
     for i:=1 to n do
     begin
          tren:=1000;
          duoi:=0;
          j:=i;
          while j<n do
           begin
                th:=0;
                repeat
                      inc(j);
                      if dx[i]<dx[j] then
                      begin
                           if (dy[i]>=dy[j])and(dy[j]>=duoi) then th:=1;
                           if (dy[i]<=dy[j])and(dy[j]<=tren) then th:=2;
                      end;
                until (th>0) or (j=n);
                tam:=(dx[j]-dx[i])*(tren-duoi);
                if tam>max then
		begin
		     max:=tam;
                     xd:=dx[i];
                     yd:=duoi;
                     xt:=dx[j];
                     yt:=tren;
		end;
                if th=1 then duoi:=dy[j];
                if th=2 then tren:=dy[j];
           end;
     end;
end;

procedure viet;
var f:text;
begin
     assign(f,fo);
     rewrite(f);
     writeln(f,max);
     writeln(f,xd:5,yd:5);
     writeln(f,xt:5,yt:5);
     close(f);
end;
{*********************}

begin
init;them;sapxep;tim;viet;
end.
