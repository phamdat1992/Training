uses crt;
const  fi='robot.inp';
       fo='robot.out';
       kq:array[0..9] of byte=(79,80,80,);
var    a:array[0..150,0..150] of byte;
       m,n:byte;
       diem:byte;
       tong:longint;
       sl:longint;
       f:text;

procedure  init;
begin
      fillchar(a,sizeof(a),0);
end;

procedure  readfile;
var  i,j:byte;
     ch:char;
begin
     assign(f,fi);
     reset(f);
       readln(f,m,n);
       tong:=0;
       for i:=1 to m do
        begin
         for j:=1 to n do
           begin
                  read(f,ch);
                  a[i,j]:=ord(ch)-ord('0');
                  inc(tong,a[i,j]);
           end;
           readln(f);
        end;
     close(f);
end;

procedure readfile2(i:byte);
var  ch:char;
     d,c:byte;
begin
      assign(f1,fo);
      reset(f1);
          readln(kq1);
          diem:=1;
          if kq1>kq[i] then begin diem:=0;exit;end;
          while not eof(f) do
              begin
                    d:=1;c:=1;
                   while not eoln(f) do
                    begin
                         read(f,ch);
                         if ch='R' then
                           begin
                                 inc(c);
                                 inc(sl,a[d,c]);
                                 a[d,c]:=0;
                           end
                         else
                              begin
                                    inc(d);
                                    inc(sl,a[d,c]);
                                    a[d,c]:=0;
                              end;
                    end;
              end;
              if sl<>tong then diem:=0;
      close(f1);
end;

