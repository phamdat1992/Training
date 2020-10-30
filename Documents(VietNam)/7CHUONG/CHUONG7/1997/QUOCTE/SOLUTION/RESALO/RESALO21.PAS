{$A+,B-,D+,E+,F-,G+,I-,L+,N+,O-,P-,Q-,R+,S+,T-,V-,X-}
{$M 16384,0,655360}

Uses Crt;
const
     maxn = 10;
     maxd = 20;
type
    arr1 = array[1..maxn,1..maxn] of Byte;
    arr2 = array[1..maxn,1..maxn] of longint;
    nhomlaptrinh = record
         n: byte;
         x: array[1..maxn] of byte;
         k: byte;
         b: array[1..maxn] of Longint;
         c: arr2;
         a: arr1;
    end;
var
   Nhom         : array[1..maxd] of nhomlaptrinh;
   DauTu,BDauTu : array[1..maxn,1..2] of Byte;
   Ns,BNs       : Longint;
   TienCl,TSD   : Longint;
   NgCl,TSN     : Byte;
   d,p          : byte;
   b            : longint;
   inp,out      : text;
   Count        : Longint;
   Time         : Longint;

procedure Loai(K: Byte);
 var temp: arr2;
     T: Longint;
     i,j,i1,j1: byte;
begin
     with nhom[k] do begin
          temp:=C;
          Fillchar(A,Sizeof(A),0);
          for i:=1 to n do begin
              T:=Temp[i,1];
              i1:=i;j1:=1;
              for j:=1 to k do
              if (Temp[i,j]<=T)and
                 ((i<>i1)or(j<>j1)) then
              begin
                   A[i,j]:=1;
                   Temp[i,j]:=T+1;
              end
              else begin
                   T:=Temp[i,j];
                   j1:=j;
              end;
          end;
          for j:=1 to k do begin
              T:=Temp[1,j];
              i1:=1;j1:=j;
              for i:=1 to n do
              if (Temp[i,j]<=T)and
                 ((i<>i1)or(j<>j1)) then A[i,j]:=1
              else begin
                   T:=Temp[i,j];
                   i1:=i;
              end;
          end;
     end;
end;

procedure input;
 var i,j,l: byte;
begin
     clrscr;
     assign(inp,'resalo.inp');
     reset(inp);
      readln(inp,d);
      readln(inp,p);
      readln(inp,b);
      for i:=1 to d do
      with nhom[i] do begin
           readln(inp,n);
           for j:=1 to n do read(inp,x[j]);readln(inp);
           readln(inp,k);
           for j:=1 to k do read(inp,b[j]);readln(inp);
           for l:=1 to n do begin
               for j:=1 to k do read(inp,c[l,j]);
               readln(inp);
           end;
           Loai(i);
      end;
     close(inp);
end;

procedure Xuat;
begin
     if Ns>Bns then begin
{        inc(Count);
        Write(Count,#13);}
        BNs:=Ns;
        BDauTu:=DauTu;
        TSD:=B-TienCl;
        TSN:=P-NgCl;
     end;
end;

procedure Try(k1: byte);
 var i,j: byte;
begin
 if k1>d then begin Xuat;Exit;end;
 with Nhom[K1] do begin
     for i:=1 to n do
     if NgCl>=X[i] then begin
        NgCl:=NgCl-X[i];
        DauTu[k1][1]:=i;

        for j:=1 to k do
        if (TienCl>=B[j])and(A[i,j]=0) then
        begin
              TienCl:=TienCl-B[j];
              Ns:=Ns+C[i,j];
              DauTu[k1][2]:=j;

              Try(K1+1);

              Ns:=Ns-C[i,j];
              TienCl:=TienCl+B[j];
           end;

        NgCl:=NgCl+X[i];
     end;
 end;
end;

procedure OutPut;
 var i: byte;
begin
 assign(out,'resalo.out');
 rewrite(out);
     writeln(out,TSD);
     writeln(out,TSN);
     writeln(out,Bns);
     writeln(out);
     for i:=1 to d do
     with Nhom[i] do
     begin
         writeln(out,B[BDauTu[i][2]]);
         writeln(out,X[BDauTu[i][1]]);
         writeln(out,C[BDauTu[i][1],BDauTu[i][2]]);
         writeln(out);
     end;
 close(out);
end;

begin
 Input;
 TienCl:=B;
 NgCl:=P;
 Ns:=0;BNs:=0;
 Count:=0;
 Time:=Meml[$00:$46c];
 Try(1);
 OutPut;
 writeln;
 Writeln(Meml[$00:$46c]-Time);
 readln;
end.