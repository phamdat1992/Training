{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

const   fi='firstrow.in0';
        fo='firstrow.out';
const   max1=254;
var     a:array[1..max1,1..max1] of byte;
        f:text;


procedure  readfile;
var  st:string;
     i,j:integer;
begin
       fillchar(a,sizeof(a),0);
       assign(f,fi);
       reset(f);
       readln(f,st);
          while st<>'#' do
            begin
                 for i:=1 to length(st) do
                   begin
                        if a[i,ord(st[i])]=0 then inc(a[i,ord(st[i])])
                        else  dec(a[i,ord(st[i])]);
                   end;
                   readln(f,st);
            end;
     close(f);
     assign(f,fo);
     rewrite(f);
        for i:=1 to max1 do
          for j:=1 to max1 do
            if a[i,j]>0 then write(f,chr(j));
     close(f);
end;

begin
     readfile;
end.


