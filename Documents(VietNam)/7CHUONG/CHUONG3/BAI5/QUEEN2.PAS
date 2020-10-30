{lam lai bai :cac con hau khong chung song hoa binh  }
program queen2;
const   fi='queen.in2';
        fo='queen.out';
type
        point=record
              x:integer;
              y:integer;
              end;
var     n,i,count:integer;
        x:array[1..100]of point;
        { cac bang danh dau }
        a:array[1..100]of boolean;{ danh dau cot }
        b:array[-99..99]of boolean;{danh dau duong cheo thu nhat}
        c:array[2..200]of boolean;{danh dau duong chao thu hai }
(*************************************************************)
procedure nhap;
var   f:text;
begin
      assign(f,fi);
      reset(f);
      readln(f,n);
      for i:=1 to n do
      readln(f,x[i].x,x[i].y);
      close(f);
end;
(*************************************************************)
procedure   khoitao;
begin
       fillchar(a,sizeof(a),true);
       fillchar(b,sizeof(b),true);
       fillchar(c,sizeof(c),true);
       for i:=1 to n do
       begin
            a[x[i].x]:=false;
            b[x[i].x-x[i].y]:=false;
            c[x[i].x+x[i].y]:=false;
       end;
end;
(*************************************************************)
procedure doi(Q:point);
begin
            a[q.x]:=not(a[q.x]);
            b[x[q].x-x[q].y]:=not(b[x[q].x-x[q].y]);
            c[x[q].x+x[q].y]:=not(c[x[q].x+x[q].y]);
end;
(*************************************************************)
procedure kiemtra(i,j,k:integer);
begin
          doi(x[i]);
          doi(x[j]);
          doi(x[k]);

end;
(*************************************************************)
procedure try;
var      i,j,k:integer;
begin
         for i:=1 to n-2 do
            for j:=i+1 to n-1 do
               for k:=1 to n do
               kiemtra(i,j,k);
end;
(*************************************************************)
procedure xuat;
var
        f:text;
begin
        assign(f,fo);
        rewrite(f);
        writeln(f,count);
end;
(*************************************************************)
begin
     nhap;
     khoitao;
     try;
     xuat;
end.