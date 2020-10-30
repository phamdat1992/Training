{$M 65000,0,0}
Program       Hoa_Tra_My ;
const
     fi='cut.inp';
     fo='cut.out';
var
   m,n,m1,n1    :       byte                            ;
   hv           :       array[1..100] of word           ;
   Mind         :       array[1..100,1..100] of word    ;
   f            :       text                            ;

function uc(r,s:byte):byte;
begin
     while r<>s do
      begin
           if r>s then r:=r-s;
           if r<s then s:=s-r;
      end;
     uc:=r;
end;

procedure Readfile;
begin
     assign(f,fi);
     reset(f);
     readln(f,m,n);
     close(f);
     m1:=m div uc(m,n);
     n1:=n div uc(m,n);
end;

procedure QuyHoachDong;
var
   i,j,u,v:byte;
begin
     fillchar(Mind,sizeof(Mind),0);
     for i:=1 to m1 do Mind[i,1]:=i;
     for i:=1 to n1 do Mind[1,i]:=i;
     for i:=1 to m1 do
      for j:=1 to n1 do if i=j then Mind[i,i]:=1;
     for i:=2 to m1 do
      for j:=2 to n1 do
       if i<>j then
       begin
            Mind[i,j]:=10000;
            for u:=1 to i div 2 do
             if Mind[i,j]>Mind[u,j]+Mind[i-u,j] then
             Mind[i,j]:=Mind[u,j]+Mind[i-u,j];
            for u:=1 to j div 2 do
             if Mind[i,j]>Mind[i,u]+Mind[i,j-u] then
             Mind[i,j]:=Mind[i,u]+Mind[i,j-u];
       end;
end;

procedure Try(x,y:byte);
var
   i:byte;
   begin
        if x=y then
        begin
             inc(hv[x]);
             exit;
        end;
        if x=1 then
        begin
             inc(hv[1],y);
             exit;
        end;
        if y=1 then
        begin
             inc(hv[1],x);
             exit;
        end;
        for i:=1 to x div 2 do
         if Mind[x,y]=Mind[i,y]+Mind[x-i,y] then
         begin
              Try(i,y);
              Try(x-i,y);
              exit;
         end;
        for i:=1 to y div 2 do
         if Mind[x,y]=Mind[x,i]+Mind[x,y-i] then
         begin
              Try(x,i);
              Try(x,y-i);
              exit;
         end;
   end;

procedure Writefile;
var
   r    :       word;
   t    :       byte;
   begin
        assign(f,fo);
        rewrite(f);
        writeln(f,Mind[m1,n1]);
        Try(m1,n1);
        for t:=100 downto 1 do if hv[t]>0 then
         for r:=1 to hv[t] do write(f,t*uc(m,n):6);
        writeln(f);
        close(f);
   end;

BEGIN
     Readfile;
     QuyHoachDong;
     fillchar(hv,sizeof(hv),0);
     Writefile;
END.