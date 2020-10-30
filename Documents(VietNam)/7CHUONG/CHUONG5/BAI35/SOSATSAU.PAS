uses crt;
const
        fi      =       'SOSATSAU.INP';
        fo      =       'SOSATSAU.OUT';
var
        a       :       array[1..1000]of integer;
        n,i,j   :       integer;
        s,r,k   :       integer;
        f       :       text;
        ok      :       boolean;

procedure       readfile;
begin
     assign(f,fi);
     reset(f);
     readln(f,n);
     for i:=1 to n do
      read(f,a[i]);
     close(f);
end;

procedure       swap( i , j   :  integer );
var
   tg   :       integer;
begin
     tg:=a[i]; a[i]:=a[j]; a[j]:=tg;
end;

procedure       xuli;
begin
     ok:=true;
     j:=n-1;
     while (a[j]>a[j+1])and(j>=1) do j:=j-1;
     { tim a[j]<=a[j+1] , voi j=n,...1}
     { neu khong co thi do chinh la hoan vi n,n-1,n-2,...2,1  }
     if j=0 then
     begin
          ok:=false;
          exit;
     end;
     k:=n;
     while a[j]>a[k] do k:=k-1;
     swap(j,k);
     r:=n;
     s:=j+1;
     while r>s do
      begin
           swap(r,s);
           r:=r-1;
           s:=s+1;
      end;
end;

procedure       writefile;
begin
     assign(f,fo);
     rewrite(f);
     if not ok then write(f,0) else
     for i:=1 to n do
      write(f,a[i],' ');
     close(f);
end;

begin
     readfile;
     xuli;
     writefile;
end.

6
3 6 2 5 4 1


