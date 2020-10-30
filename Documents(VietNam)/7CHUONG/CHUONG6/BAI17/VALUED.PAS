{$M 65000,0,655360}{$R+}
const
     fi='value.in1';
     fo='value.out';
     nhan:array['a'..'c','a'..'c'] of char
     =(('b','b','a'),
       ('c','b','a'),
       ('a','c','c'));
     tach:array['a'..'c',1..3,1..2] of char=
          ((('a','c'),('b','c'),('c','a')),
           (('a','a'),('a','b'),('b','b')),
           (('b','a'),('c','b'),('c','c')));
var
   s,s1:string;f,g:text;n:byte;
   kq:array[1..100,1..100,'a'..'c'] of byte;
   duoc:boolean;
procedure xet(i,j,k:byte);
var
   l,m:byte;c1:char;x:boolean;
begin
     for c1:='a' to 'c' do
      for l:=0 to k-1 do
       begin
            x:=false;
            for m:=1 to 3 do
             if kq[i,i+l,tach[c1,m,1]]*kq[i+l+1,j,tach[c1,m,2]]=1 then
             begin
                  kq[i,j,c1]:=1;
                  x:=true;
                  break;
             end;
             if x then break;
       end;
end;

procedure tinh;
var
   i,j,k:byte;
begin
     n:=length(s);
     fillchar(kq,sizeof(kq),0);
     for i:=1 to n do kq[i,i,s[i]]:=1;
     k:=1;
     while k<=n-1 do
      begin
           for i:=1 to n-k do
            begin
                 j:=i+k;
                 xet(i,j,k)
            end;
            inc(k);
     end;
     duoc:=kq[1,n,'a']=1;
end;

procedure ghinhan(i,j:byte;c:char);
var
   k,l,m:byte;
begin
     if i=j then
     begin
          write(g,s[i]);
          exit;
     end;
     if j=i+1 then
     begin
          write(g,copy(s,i,2));
          exit;
     end;
     for m:=1 to 3 do
     if kq[i,i,tach[c,m,1]]*kq[i+1,j,tach[c,m,2]]=1 then
     begin
          ghinhan(i,i,tach[c,m,1]);
          write(g,'(');
          ghinhan(i+1,j,tach[c,m,2]);
          write(g,')');
          exit;
     end;
     for m:=1 to 3 do
     if kq[i,j-1,tach[c,m,1]]*kq[j,j,tach[c,m,2]]=1 then
     begin
          write(g,'(');
          ghinhan(i,j-1,tach[c,m,1]);
          write(g,')');
          ghinhan(j,j,tach[c,m,2]);
          exit;
     end;
     for k:=i+1 to j-2 do
      for m:=1 to 3 do
      if kq[i,k,tach[c,m,1]]*kq[k+1,j,tach[c,m,2]]=1 then
      begin
           write(g,'(');
           ghinhan(i,k,tach[c,m,1]);
           write(g,')(');
           ghinhan(k+1,j,tach[c,m,2]);
           write(g,')');
           exit;
      end;
end;

procedure viet;
begin
     if duoc then
     begin
          ghinhan(1,n,'a');
          writeln(g);
     end
     else writeln(g,0);
end;

procedure nhap;
begin
     assign(f,fi);
     reset(f);
     assign(g,fo);
     rewrite(g);
     while not(seekeof(f)) do
      begin
           readln(f,s);
           tinh;
           viet;
      end;
      close(f);
      close(g);
end;

BEGIN
     nhap;
END.
