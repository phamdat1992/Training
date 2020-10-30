uses crt;
const fi='nhi_phan.inp';
      fo='nhi_phan.out';
type  mang=array[0..10000] of char;
var   l1,l2,k,n,dem,dd,dem1:longint;
      a,b,c:mang;
      luud:array[1..26] of longint;
      f,f1:text;


procedure  init;
begin
     fillchar(luud,sizeof(luud),0);
end;


function  mu(i:byte):longint;
var  j,l:longint;
begin
     l:=1;
     for j:=1 to i  do  l:=l*2;
     mu:=l;
end;

procedure   xulimang(var a:mang);
var cc1,ml:longint;
begin
       cc1:=0;
       dem:=0;
       while cc1<=l1 do
         begin
              inc(dem);inc(cc1);
              if (ord(a[cc1])>=97) and (ord(a[cc1])<=122) then
			    begin
                     ml:=luud[ord(a[cc1])-ord('a')+1];
                     while ml>0 do
                       begin
                            c[dem]:='.';
                            dec(ml);
							if ml>0 then inc(dem);
                       end;
                end
               else c[dem]:=a[cc1];
         end;
         a:=c;
         for ml:=1 to dem do write(a[ml],'  ');writeln;
end;

procedure  laptrong;
var i:longint;
begin
      for i:=1 to dem do
        begin
              if (a[i]<>'.') and (b[i]='.') then b[i]:=a[i];
              if (b[i]<>'.') and (a[i]='.') then a[i]:=b[i];
	    end;
end;

procedure  demkitu;
var  i:longint;
begin
     dd:=0;
     for i:=1 to dem do
      if a[i]='.' then inc(dd);
end;

procedure  xuat(i:byte);
begin
      if i=1 then writeln(f1,mu(dd))
      else writeln(f1,0);
end;

function kiemtramang:boolean;
var  i:longint;
begin
     kiemtramang:=false;
{     if dem<>dem1 then exit;}
     for i:=1 to dem do
       if a[i]<>b[i] then exit;
     kiemtramang:=true;
end;

procedure  readfile;
var  i,l,j:byte;
     ch:char;
begin
      assign(f1,fo);
      rewrite(f1);
      assign(f,fi);
      reset(f);
        readln(f,n);
        for i:=1 to n do
         begin
               init;
               readln(f,k);
               for j:=1 to k do
               begin
			          readln(f,ch,l);
                      luud[ord(ch)-ord('a')+1]:=l;
               end;
               readln(f,l1);
               for l:=1 to l1 do  read(f,a[l]);
               readln(f);
               readln(f,l2);
               for l:=1 to l2 do  read(f,b[l]);
               readln(f);
               xulimang(a);
               dem1:=dem;
               xulimang(b);
			   laptrong;
               if kiemtramang then
               begin
               demkitu;
               xuat(1);
               end
               else xuat(0);
         end;
      close(f);
      close(f1);
end;

begin  clrscr;
readfile
end.