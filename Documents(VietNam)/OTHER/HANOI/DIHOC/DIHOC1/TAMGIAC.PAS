{$R+}
Program tam_giac;
Uses crt;
Const
     Fi='luoi.inp';
     Fo='luoi.out';
     maxn=51;
     u:array[1..8] of integer=(-1,-1,0,1,1,1,0,-1);
     v:array[1..8] of integer=(0,1,1,1,0,-1,-1,-1);
Type
    ovuong = record
           p,q,r,s:boolean;
    end;

    ovuong2 = record
            p,q,r,s:integer;
    end;

    mang=array[0..maxn,0..maxn] of 0..15;
Var
   A: ^mang;
   B:array[0..maxn,0..maxn] of ovuong;
   C:array[0..maxn,0..maxn] of ovuong2;
   m,n,i,j:integer;
   tp:integer;
Procedure readf;
Var
   f:text;
Begin
     Assign(f,fi);
     Reset(f);
     readln(f,m,n);
     For i:=1 to m do
     begin
          for j:=1 to n do read(f,a^[i,j]);
          readln(f);
     end;
end;

Procedure chuyen(p,q:integer);
Var
   t:integer;
   l:integer;
begin
     t:=a^[q,p];
     repeat
          if t>=1 then l:=1;
          if t>=2 then l:=2;
          if t>=4 then l:=4;
          if t>=8 then l:=8;

          case l of
               1: begin
                       b[i,j].p:=true;
                       t:=t-l;
                  end;

               2: begin
                       b[i,j].q:=true;
                       t:=t-l;
                  end;

               4: begin
                       b[i,j].r:=true;
                       t:=t-l;
                  end;

               8: begin
                       b[i,j].s:=true;
                       t:=t-l;
                  end;
          end;
     until t=0;
end;

Procedure chuyeno;
Var
   i,j:integer;
begin
     For i:=0 to m+1 do
         for j:=0 to n+1 do
         begin
              b[i,j].p:=false;b[i,j].r:=false;
              b[i,j].q:=false;b[i,j].s:=false;
         end;

     for i:=1 to m do
         for j:=1 to m do
         if a^[i,j]<>0 then chuyen(i,j);
end;


Procedure init;
begin
     new(a);
     fillchar(a,sizeof(a),0);
     Readf;
     chuyeno;
     tp:=0;
end;

Procedure duyet(i,j:integer);
Var
   k:shortint;
begin
     if b[i,j].p and (c[i,j].p=0) then c[i,j].p:=tp;
     if b[i,j].q and (c[i,j].q=0) then c[i,j].q:=tp;
     if b[i,j].r and (c[i,j].r=0) then c[i,j].r:=tp;
     if b[i,j].s and (c[i,j].s=0) then c[i,j].s:=tp;

     for k:=1 to 8 do
     begin
          if (b[i+u[k],j+v[k]].p and (c[i,j].p=0))
          or (b[i+u[k],j+v[k]].q and (c[i,j].q=0))
          or (b[i+u[k],j+v[k]].r and (c[i,j].r=0))
          or (b[i+u[k],j+v[k]].s and (c[i,j].s=0)) then duyet(i,j);
     end;
end;

Procedure main;
begin
     For i:=1 to m do
         for j:=1 to n do
         if ((b[i,j].p and (c[i,j].p=0))
         or (b[i,j].q and (c[i,j].q=0))
         or (b[i,j].r and (c[i,j].r=0))
         or (b[i,j].s and (c[i,j].s=0))) then
         begin
              inc(tp);
              duyet(i,j);
         end;
end;

procedure done;
begin
     writeln(tp);
end;

BEGIN
     clrscr;
     init;
     main;
     done;
END.
4 4
1 4 10 0
4 0 12 0
4 0  0 0
1 0  7 0
