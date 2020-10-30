uses crt;
const  fi='vat.inp';
       fo='vat.out';
var    d:array[0..11] of byte;
       a,b:array[0..20000] of 0..9;
       f:text;
       dem,dem1:longint;
       n:byte;
       t:set of byte;

procedure  init;
begin
      fillchar(a,sizeof(a),0);
      fillchar(d,sizeof(d),0);
end;

procedure  readfile;
var  i,j,ch:byte;
     cha:char;
begin
      assign(f,fi);
      reset(f);
         readln(f,n);
         for i:=1 to n do begin read(f,ch);t:=t+[ch];end;
         i:=0;
         dem1:=0;
         while (i<=9)  do
           begin
                if  not (i in t) then
                  begin
                       inc(dem1);
                       d[dem1]:=i;
                  end;
                  inc(i);
           end;
         readln(f);
         dem:=0;
         while not eoln(f) do
           begin
                read(f,cha);
                if cha<>' ' then
                  begin
                         inc(dem);
                         a[dem]:=ord(cha)-ord('0');
                  end;
           end;
      close(f);
end;

function  ok:boolean;
var i:longint;
begin
      ok:=false;
         for i:=1 to dem do if (a[i] in t) then exit;
      ok:=true;
end;

procedure  xuli1;
var  i,j:longint;
begin
      i:=dem;
      while (a[i]=9) and (i>0) do dec(i);
      inc(a[i]);
      for j:=dem downto i+1 do a[j]:=0;
      if i=0 then
       begin
	         for j:=dem+1 downto 1 do a[j]:=a[j-1];
             inc(dem);
       end;
       if ok then
         begin
              for i:=1 to dem do write(f,a[i]);
              close(f);
              halt;
         end;
end;

procedure  xuli;
var  i,j,k,k1:longint;
begin
      fillchar(b,sizeof(b),0);
      i:=1;
      repeat
             j:=1;
             while ( d[j] < a[i] )  and (j<=dem1) do inc (j);
             if j<=dem1  then
               begin
                     b[i]:=j;
                     if d[j]>a[i] then
                       begin
                             for k:=1 to i do write(f,d[b[k]]);
                             for k:=i+1 to dem do write(f,d[1]);
                             close(f);
                             halt;
                       end;
               end
            else
               begin
                     k:=i-1;
                     while (d[b[k]] = d[dem1]) and (k>0)  do dec(k);
                     if k>0 then
                     begin
                     inc(b[k]);
                     for k1:=1 to k do write(f,d[b[k]]);
                     for k1:=k+1 to dem do write(f,d[1]);
                     close(f);
                     halt;
                     end
                     else
                        begin
                              if d[1]=0 then write(f,d[2])
                              else  write(f,d[1]);
                              for k:=1 to dem do write(f,d[1]);
                              close(f);
                              halt;
                        end;
               end;
            inc(i);
      until i>dem;
      for k:=1 to dem do write(f,d[b[k]]);
      close(f);
end;

begin  clrscr;
    init;
    readfile;
    assign(f,fo);
    rewrite(f);
    xuli1;
    xuli;
end.
