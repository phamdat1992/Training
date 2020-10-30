Program Exiec;
Uses crt;
Const
     Fi='exiec.inp';
     Fo='exiec.out';
Var
   s1,s2,s3:string;
   f:text;
   phai,trai,tren,xuong:longint;
   min:byte;

procedure  init;
begin
        phai:=0;trai:=0;tren:=0;xuong:=0;
end;

function lonnhat:byte;
var  minld:byte;
begin
      minld:=length(s1);
      if length(s2)>minld then minld:=length(s2);
      if length(s3)>minld then minld:=length(s3);
      lonnhat:=minld;
end;

procedure count;
var  i:byte;
begin
       for i:=1 to min-1 do
         begin
               if (s1[i]='*') and (s2[i]='*') and (s2[i+1]='*') and (s3[i]='*') then inc(phai);

               if i>1 then
                  if (s1[i]='*') and (s2[i]='*') and (s2[i-1]='*') and (s3[i]='*') then inc(trai);

               if i>1 then
                  if (s1[i]='*') and (s2[i]='*') and (s2[i-1]='*') and (s2[i+1]='*') then inc(tren);

               if i>1 then
                  if (s1[i]='*') and (s2[i]='*') and (s1[i+1]='*') and (s1[i-1]='*') then inc(xuong);
         end;
end;

Procedure main;
Begin
     Assign(f,fi);
     reset(f);
     readln(f,s1);
     readln(f,s2);

     while not eof(f) do
     begin
             readln(f,s3);
             min:=lonnhat;
             count;
             s1:=s2;
             s2:=s3;
     end;

     Close(f);

End;

procedure done;
begin
      assign(f,fo);
      rewrite(f);
      writeln(f,phai,'  ',trai,'  ',tren,'  ',xuong);
      writeln(phai,'  ',trai,'  ',tren,'  ',xuong);
      close(f);
end;

begin  clrscr;
     init;
     main;
     done;
end.

*****
*         ***************
*                       *
*******************     *
*                       *
*           *************
**********              *
               **********


