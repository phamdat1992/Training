{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+}
{$M 16384,0,655360}

Uses crt;
Const fn='exiec.in5';
      gn='exiec.out';
Var   f,g:text;
      S1,S2,S3:string[71];
      sl1,sl2,sl3,sl4:longint;

Procedure  Init;
Begin
      sl1:=0;sl2:=0;sl3:=0;sl4:=0;
End;

Procedure  Xuat;
Begin
      Assign(G,gn);
      Rewrite(G);
         Writeln(G,sl1,'  ',sl2,'   ',sl3,'  ',sl4);
      Close(G);
End;

procedure  lap_cach;
var  i:byte;
begin
     for i:=length(s3)+1 to 71 do s3:=s3+' ';
end;

function  ok1(i:byte):boolean;
begin
      ok1:=false;
      if i>=70 then exit;
      if (s1[i]='*') and (s2[i]='*') and (s3[i]='*') and (s2[i+1]='*') then  ok1:=true;
end;

function  ok2(i:byte):boolean;
begin
      ok2:=false;
      if i<=1 then exit;
      if (s1[i]='*') and (s2[i]='*') and (s3[i]='*') and (s2[i-1]='*') then  ok2:=true;
end;


function  ok3(i:byte):boolean;
begin
      ok3:=false;
      if (i<=1) or (i>=70) then exit;
      if (s3[i]='*') and (s3[i+1]='*') and (s3[i-1]='*') and (s2[i]='*') then  ok3:=true;
end;

function  ok4(i:byte):boolean;
begin
      ok4:=false;
      if (i<=1) or (i>=70) then exit;
      if (s1[i]='*') and (s1[i+1]='*') and (s1[i-1]='*') and (s2[i]='*') then  ok4:=true;
end;

procedure   dem;
var  i:byte;
begin
      for i:=1 to 70 do
        begin
            if ok1(i) then inc(sl1);
            if ok2(i) then inc(sl2);
            if ok3(i) then inc(sl3);
            if ok4(i) then inc(sl4);
        end;
end;

Procedure  ReadFile;
Begin
     Assign(f,Fn);
     Reset(F);
     s1:='                                                                      ';
     s2:='                                                                      ';
         While not eof(f) do
		    begin
                 readln(f,s3);
            {     writeln(s1);writeln(s2);writeln(s3);
                 Writeln(sl1,'  ',sl2,'   ',sl3,'  ',sl4);readln;clrscr;}
                 lap_cach;
                 dem;
                 s1:=s2;
                 s2:=s3;
            end;
     Close(f);
End;

begin  clrscr;
  init;
  readfile;
  xuat;
end.
