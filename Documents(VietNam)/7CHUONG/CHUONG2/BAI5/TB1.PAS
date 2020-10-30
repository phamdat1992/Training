
Uses crt;
Const
     fi='tb.inp';
     fo='tb.out';
Var
   A:array[1..1000] of word;
   B:array[1..1000,1..2] of word;
   C,Luu:array[1..1000] of boolean;
   sv,n,st:word;
   f:text;

Procedure ReadFile;
var
   i:word;
begin
     fillchar(A,sizeof(A),0);
     fillchar(C,sizeof(C),true);
     assign(f,fi);
     reset(f);
     readln(f,n);
     st:=n;
     For i:=1 to N do
         begin
              read(f,A[i]);
              If C[A[i]] then
              begin
                   C[A[i]]:=false;
                   dec(st);
              end;
         end;
     close(f);
end;

Procedure Xuli;
var
   Dau,i,j,k,dem:word;
   Ok:boolean;
   Danh_Sach:array[1..1000] of word;
begin
     fillchar(B,sizeof(B),0);
     fillchar(Luu,sizeof(Luu),false);
     dem:=0;
     sv:=0;
     while st>0 do
     begin
          For i:=1 to n do
          If C[i] then
          begin
               C[i]:=false;
               break;
          end;
          If i<=n then
          begin
               dec(st);
               Dau:=1;
               Danh_Sach[Dau]:=i;
               Luu[i]:=true;
               repeat
                     Ok:=true;
                     k:=A[Danh_Sach[Dau]];
                     If not(Luu[k]) then
                     begin
                          inc(Dau);
                          Danh_Sach[Dau]:=k;
                          Ok:=false;
                          Luu[k]:=true;
                     end;
               until Ok;
               inc(dem,Dau);
               inc(sv);
               B[sv,1]:=Danh_Sach[1];
               B[sv,2]:=Danh_Sach[Dau];
          end;
     end;
     while dem<n do
     begin
          For i:=1 to n do
          If not(Luu[i]) then break;
          Dau:=1;
          Danh_Sach[Dau]:=i;
          Luu[i]:=true;
          repeat
                Ok:=true;
                k:=A[Danh_Sach[Dau]];
                If not(Luu[k]) then
                begin
                     inc(Dau);
                     Danh_Sach[Dau]:=k;
                     Ok:=false;
                     Luu[k]:=true;
                end;
          until Ok;
          inc(dem,Dau);
          inc(sv);
          B[sv,1]:=Danh_Sach[1];
          B[sv,2]:=Danh_Sach[Dau];
     end;
end;
{**************************}

Procedure WriteFile;
var
   i,j:word;
begin
     assign(f,fo);
     rewrite(f);
     If (sv=1) and (B[1,1]=A[B[sv,B[1,2]]]) then
     writeln(f,0)
     else
     begin
          writeln(f,sv);
          If sv=1 then writeln(f,B[1,2]:5,B[1,1]:5);
          If (sv>1) then
          begin
               For i:=1 to sv-1 do
               writeln(f,B[i,2]:5,B[i+1,1]:5);
               writeln(f,B[sv,2]:5,B[1,1]:5);
          end;
    end;
    close(f);
end;

BEGIN
     clrscr;
     ReadFile;
     Xuli;
     WriteFile;
END.