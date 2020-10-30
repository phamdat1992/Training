const
     fi='robot.inp';
     fo='robot.out';
var
   a:array[-16..16,-16..16,0..16]of word;
   m,n,i,j,p,q,t,k:longint;
   f:text;

procedure readfile;
 begin
      assign(f,fi);
      reset(f);
      readln(f,k,m,n,p,q);
      close(f);
 end;

procedure Quy_Hoach_Dong;
begin
     fillchar(a,sizeof(A),0);
     for i:=-16 to 16 do
     begin
          a[i,0,abs(i)]:=1;
          a[0,i,abs(i)]:=1;
     end;
     for t:=1 to 16 do
     for i:=-1 to 16 do
     for j:=-1 to 16 do
     a[i,j,t]:=a[i-1,j,t-1]+a[i,j-1,t-1]+a[i+1,j,t-1]+a[i,j+1,t-1];
     for t:=1 to 16 do
     for i:=1 downto -16 do
     for j:=1 downto -16 do
     a[i,j,t]:=a[i-1,j,t-1]+a[i,j-1,t-1]+a[i+1,j,t-1]+a[i,j+1,t-1];
 end;
procedure writefile;
 begin
      assign(f,fo);
      rewrite(f);
      writeln(f,a[p-m,q-n,k]);
      close(f);

 end;
begin { main program}
        readfile;
        Quy_Hoach_Dong;
        writefile;
end.



3 0 0 0 1
