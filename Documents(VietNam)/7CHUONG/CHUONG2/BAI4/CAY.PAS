{R+}
program Trong_cay_de_tong_so_cay_phuong_va_diep_chenh_lech_it_nhat;
const inp='cay.inp';
      out='cay.out';
var A,mau:array[1..170,1..170] of -1..2;
    B:array[1..100] of byte;
    n,m,k,kt,t,sl,s,z:integer;
    st:string;
    f,g:text;
procedure input;
var i,j:integer;
begin
   	 fillchar(A,sizeof(A),0);
   	 fillchar(B,sizeof(B),0);
   	 assign(f,inp); reset(f);
     assign(g,out); rewrite(g);
   	 readln(f,m,n);
   	 for i:=1 to m do
   	 begin
          readln(f,st);
      	  for j:=1 to length(st) do
      	  begin
               val(st[j],s,z);
         	   if s=1 then
         	   begin
            		inc(B[i]); inc(B[m+j]);
            		A[i,m+j]:=1; A[m+j,i]:=1;
         	   end;
      	   end;
   	 end; close(f);
end;
procedure NgauNhien;
var i,j,C:integer;
    ok:boolean;
begin C:=1;
      repeat
           ok:=true;
           for i:=1 to m+n do
              if A[k,i]=1 then
              begin
                  j:=i; ok:=false;
                  break;
              end;
           if not ok then
           begin
                dec(B[k]); dec(B[j]);
                if B[k]=0 then dec(kt);
                if B[j]=0 then dec(kt);
                A[k,j]:=0; A[j,k]:=0;
                mau[k,j]:=C; mau[j,k]:=C;
         	    C:=-C; k:=j;
      	   end;
      until ok;
end;
procedure clean_tree;
var j,d1,d2:integer;
    ok:boolean;
begin
   	 fillchar(mau,sizeof(mau),0);
     ok:=false; kt:=0;
   	 for j:=1 to m+n do if B[j]>0 then inc(kt);
   	 repeat
       	 d1:=1; d2:=1;
      	 while B[d1]=0 do inc(d1);
      	 d2:=d1;
         if B[d1] mod 2=0 then
             while (B[d1] mod 2=0)and(d1<=m+n) do inc(d1);
      	 if d1<=n+m then k:=d1
      				else k:=d2;
      	 NgauNhien;
   	 until kt=0;
end;
procedure output;
var i,j:integer;
begin
     for i:=1 to m do
     begin
         for j:=m+1 to m+n do
            if mau[i,j]=1 then write(g,1)
            else
               if mau[i,j]=-1 then write(g,2)
               else write(g,0);
         writeln(g);
     end; close(g);
end;
begin
     input; clean_tree; output;
end.