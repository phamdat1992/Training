{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

uses crt;
const csi:array [1..6] of integer = (0,-1,0,1,0,0);
      csj:array [1..6] of integer = (-1,0,1,0,0,0);
      cst:array [1..6] of integer = (0,0,0,0,-1,1);
Var d:array [1..32,1..32,1..32] of byte;
    l,w,h,i,j,t,dd:byte;
    kt:boolean;
    fi,fo:text;

  Procedure init;
    Begin
      assign(fi,'TOXIC.INP');
      reset(fi);
      assign(fo,'TOXIC.OUT');
      rewrite(fo);
    End;

  Procedure fini;
    Begin
      close(fi);
      close(fo);
    End;

  Procedure ReadData;
    Begin
      readln(fi,l);
      readln(fi,w);
      readln(fi,h);
    End;

  Procedure chbi;
    Begin
      fillchar(d,sizeof(d),0);
      i:=1; j:=1; t:=1;
      dd:=1;
    End;

  Function dk(i,j,t:byte):boolean;
    Begin
      dk:=(i>=1) and (j>=1) and (t>=1)
        and (i<=l) and (j<=w) and (t<=h);
    End;

  Function khoi(i,j,t:byte):byte;
   Var k,i1,j1,t1,s:integer;
    Begin
      s:=0;
      For k:=1 to 6 do
        begin
          i1:=i+csi[k];
          j1:=j+csj[k];
          t1:=t+cst[k];
          If dk(i1,j1,t1) and (d[i1,j1,t1]=0) then s:=s+1;
        end;
      khoi:=s;
    End;

  Procedure tim(var i,j,t:byte);
   Var max,i1,j1,t1,k,cs:byte;
    Begin
      max:=0;
      For k:=1 to 6 do
        begin
          i1:=i+csi[k];
          j1:=j+csj[k];
          t1:=t+cst[k];
          If dk(i1,j1,t1) and (d[i1,j1,t1]=1) and (khoi(i1,j1,t1)>max) then
            begin
              max:=khoi(i1,j1,t1);
              cs:=k;
            end;
        end;
      If max<>0 then
        begin
          i:=i+csi[cs];
          j:=j+csj[cs];
          t:=t+cst[cs];
        end
      else begin i:=0; j:=0; t:=0 end;
    End;

  Procedure ghinhan;
    Begin
      If d[i,j,t]=0 then writeln(fo,'E ',i,' ',j,' ',t);
      writeln(fo,'M ',i,' ',j,' ',t);
    End;

  Procedure danhdau;
   Var k,i1,j1,t1:integer;
    Begin
      For k:=1 to 6 do
        begin
          i1:=i+csi[k];
          j1:=j+csj[k];
          t1:=t+cst[k];
          If dk(i1,j1,t1) and (d[i1,j1,t1]=0) then
            begin
              d[i1,j1,t1]:=1;
              writeln(fo,'E ',i1,' ',j1,' ',t1);
            end;
        end;
    End;

  Procedure xuly;
    Begin
      repeat
        dd:=dd+khoi(i,j,t);
        ghinhan;
        danhdau;
        d[i,j,t]:=2;
        tim(i,j,t);
        kt:=(i=0) and (j=0) and (t=0);
      until kt;
    End;

  BEGIN
    clrscr;
    Init;
    ReadData;
    chbi;
    xuly;
    fini;
  END.
1
5
5


2
3
2
