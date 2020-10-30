const  fi='lightnet.in2';
       fo='lnet.out';
       ch:array[0..1] of string=('RED ','BLUE ');
var    sl1,sl2:array[0..100] of byte;
       a,b:array[0..100,0..100] of 0..1;
       ss1,ss2:array[0..100] of string[100];
       ok:array[0..100] of boolean;
       m,n,st:byte;
       dem:longint;
       f,f1:text;

procedure  init;
var  i:byte;
begin
      fillchar(a,sizeof(a),0);
      fillchar(B,sizeof(B),0);
      fillchar(sl1,sizeof(sl1),0);
      fillchar(ok,sizeof(ok),true);
      fillchar(sl2,sizeof(sl2),0);
      for i:=0 to 100 do
        begin
             ss1[i]:='';
             ss2[i]:='';
        end;
end;


procedure  dem_dong;
var  i,j:byte;
begin
      for i:=1 to m do
        for j:=1 to n do
          begin
                inc(sl1[i],a[i,j]);
                inc(sl2[i],b[i,j]);
          end;
end;

function   xuli_dong:boolean;
var i,j:byte;
begin
      xuli_dong:=false;{
     for i:=1 to m do
      begin
            for j:=1 to n do write(a[i,j]);
            writeln;
      end;
	  writeln;
     for i:=1 to m do
      begin
            for j:=1 to n do write(ch[a[i,j]]);
            writeln;
      end;
      readln;           }
      for i:=1 to m do
        begin
              if (sl1[i]=sl2[i]) or (sl1[i]+sl2[i]=n) then
                begin
                      if sl1[i]+sl2[i]=N then
                        for j:=1 to n do a[i,j]:=1-a[i,j];
                end
              else  exit;
        end;             {
     for i:=1 to m do
      begin
            for j:=1 to n do write(a[i,j]);
            writeln;
      end;
      writeln;
     for i:=1 to m do
      begin
            for j:=1 to n do write(b[i,j]);
            writeln;
      end;
     readln;              }
     xuli_dong:=true;
end;

procedure  dem_cot;
var   i,j:byte;
begin
      for i:=1 to n do
        for j:=1 to m do
        begin
              ss1[i]:=ss1[i]+chr(ord('0')+a[j,i]);
              ss2[i]:=ss2[i]+chr(ord('0')+b[j,i]);
        end;              {
        for i:=1 to n do writeln(ss1[i],'  ',ss2[i]);readln;}
end;

function  chon(i:byte):byte;
var  j:byte;
begin
      chon:=0;
      for j:=1 to n do
        if ok[j] and (ss1[j]=ss2[i]) then begin chon:=j;exit;end;
end;

function  xuli_cot:boolean;
var  i,k:byte;
begin
         xuli_cot:=false;
         for i:=1 to n do
           begin
                 k:=chon(i);
                 if k=0 then begin {writeln(i)};exit;end;
                 ok[k]:=false;
           end;
         xuli_cot:=true;
end;

function  main:string;
begin
       main:='NO';
       dem_dong;
       if not xuli_dong then exit;
       dem_cot;
       if not xuli_cot then  exit;
       main:='YES';
end;

procedure  readfile;
var  i,j,k:longint;
     ch:char;
begin
      assign(f1,fo);
      rewrite(f1);
      assign(f,fi);
      reset(f);
          readln(f,st);
          for k:=1 to st do
          begin
          init;
          readln(f,m,n);
          for i:=1 to m do
           begin
                j:=0;
                while not eoln(f) do
                  begin
                       read(f,ch);
                       if (upcase(ch)='B')  or (upcase(ch)='R') then
                       begin
                            inc(j);
					        if upcase(ch)='B' then a[i,j]:=1;
                       end;
                  end;
                  readln(f);
           end;
          for i:=1 to m do
           begin
                j:=0;
                while not eoln(f) do
                  begin
                       read(f,ch);
                       if (upcase(ch)='B')  or (upcase(ch)='R') then
                       begin
                             inc(j);
					         if upcase(ch)='B' then b[i,j]:=1;
                       end;
                  end;
                  readln(f);
          end;
          writeln(f1,main);
      end;
      close(f);
   close(f1);
end;

begin       readfile;
end.


