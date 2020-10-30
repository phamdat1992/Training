uses crt;
const  fi='day.in1';
       fo1='day1.out';
       fo='day.out';
type   filetext=text;
var    n,dem:longint;
       f,f1:text;
       dau,cuoi,luud,luuc:longint;
       maxt,maxc:real;


procedure  init;
var  j:longint;
begin
       assign(f,fo1);
       rewrite(f);
         assign(f1,fi);
         reset(f1);
         readln(f1,n);
         writeln(f,2*n);
             while not eof(f1) do begin  readln(f1,j);writeln(f,j);end;
       close(f1);
         assign(f1,fi);
         reset(f1);
         readln(f1,n);
             while not eof(f1) do begin  readln(f1,j);writeln(f,j);end;
       close(f1);
       close(f);
end;

procedure  readfile1;
var  i:longint;
begin
       assign(f,fo1);
       reset(f);
         maxc:=0;
         maxt:=0;
         readln(f,n);
         dau:=0;cuoi:=0;luud:=0;luuc:=0;
         i:=0;
           while not eof(f) and (dau<=n div 2) do
             begin
                  readln(f,i);
                  if maxc>maxt then
                     begin
                           luuc:=cuoi;
                           luud:=dau;
                           maxt:=maxc;
                     end;
                  if i+maxc>0 then
                     begin
                          maxc:=maxc+i;
                     end
                  else
				    begin
                          if maxc>maxt then
                               begin
                                     luuc:=cuoi;
                                     luud:=dau;
                                     maxt:=maxc;
                               end;
                           maxc:=0;
                           inc(cuoi);
                           dau:=cuoi;
                    end;
                    if maxc<>0 then inc(cuoi);
             end;
       close(f);
end;

procedure  xuat;
var  i:longint;
begin
      assign(f1,fo);
      rewrite(f1);
      writeln(f1,luuc-luud);
      for i:=luud+1 to luuc do
        begin
             if i>n div 2 then writeln(f1, i-n div 2 )
             else writeln(f1,i);
        end;
      close(f1);
end;

Procedure sinhtest;
Var
	f:text;
    i,j:integer;
begin
	n:=10000;
    Assign(f,fi);
    rewrite(f);
    randomize;
    	Writeln(f,n);
        For i:=1 to n do begin j:=random(100)-50;writeln(f,j); end;
    Close(f);
end;

begin  clrscr;
{sinhtest;end.                                   }
  init;
  readfile1;
  xuat;
end.
