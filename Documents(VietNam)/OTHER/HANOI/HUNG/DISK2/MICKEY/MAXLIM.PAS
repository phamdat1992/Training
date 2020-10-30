{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;
const  fi='day.in5';
       fo1='day1.out';
       fo='day.out';
type   filetext=text;
var    n,dem:longint;
       f,f1:text;
       dau,cuoi,luud,luuc,luumaxam,demdt:longint;
       maxt,maxc:real;
       ddk,ddl:boolean;
       maxam:real;
       time1:longint  ;
       time2:longint absolute 0:$46c;


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
       ddk:=false;
       maxam:=0;
       luumaxam:=0;
       demdt:=0;ddl:=true;
       time1:=time2;
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
                  if demdt<n div 2 then inc(demdt);
                  readln(f,i);
                  if (i>maxam) or ( ddl=true) then begin maxam:=i;luumaxam:=demdt;ddl:=false;end;
                  if i>0 then ddk:=true;
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
      if maxam<=0 then
         begin
              writeln(f1,1);
              writeln(f1,luumaxam);
         end
      else
      begin
      writeln(f1,luuc-luud);
      for i:=luud+1 to luuc do
        begin
             if i>n div 2 then writeln(f1, i-n div 2 )
             else writeln(f1,i);
        end;
      end;
      close(f1);
      writeln(' Thoi Gian Chay Chuong Trinh : ',(time2-time1)/18.21:5:2);
      readln;
end;

Procedure sinhtest;
Var
	f:text;
    i,j:longint;
begin
    n:=100000;
    Assign(f,fi);
    rewrite(f);
    randomize;
    	Writeln(f,n);
        For i:=1 to n do begin j:=random(100)-50;writeln(f,j); end;
    Close(f);
end;

begin  clrscr;

 {

sinhtest;end.
}
  init;
  readfile1;
  xuat;
end.
