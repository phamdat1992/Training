uses crt;
const  fi='tick.inp';
       fo='tick.out';
type   mang=array[0..2000] of longint;
var    d,t,mind,fr:mang;
       n:longint;
       f:text;

procedure  readfile;
var  i:integer;
begin
      fillchar(d,sizeof(d),0);
      fillchar(t,sizeof(t),0);
      assign(f,fi);
      reset(f);
          readln(f,n);
          for i:=1 to n do
            read(f,d[i]);
            readln(f);
          for i:=1 to n-1 do
            read(f,t[i]);
            readln(f);
      close(f);
end;

procedure  init;
begin
      fillchar(mind,sizeof(mind),0);
      fr:=mind;
      mind[1]:=d[1];
end;

procedure   xuli;
var  i:integer;
begin
     for i:=2 to n do
       begin
            mind[i]:=mind[i-1]+d[i];
            if mind[i]>mind[i-2]+t[i-1] then
			  begin
			        mind[i]:=mind[i-2]+t[i-1];
                    fr[i]:=i-1;
              end;
       end;
end;

procedure  try(i:byte);
begin
      if i>1 then
        begin
              if fr[i]>0 then begin write(f,i,'  ');try(i-2);end
              else  try(i-1);
        end;
end;

procedure  xuat;
begin
      assign(f,fo);
      rewrite(f);
          writeln(f,mind[n]);
          try(n);
      close(f);
end;

begin  clrscr;
    readfile;
    init;
    xuli;
    xuat;
end.
