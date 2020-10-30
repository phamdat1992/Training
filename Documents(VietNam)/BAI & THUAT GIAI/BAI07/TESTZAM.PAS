uses crt;
const nfi = 'zam.in';
      nfo = 'zam.out';
      maxn = 100;

var QH                  : array[1..maxn,1..maxn] of byte;
    Cost                : array[1..maxn] of integer;
    n,m,k,w,s           : integer;
    fo                  : text;

procedure input;
var fi          :     text;
    i,tg1,tg2   :     integer;
    nf          :     string;
    ch          :     char;
begin
     write('test :');readln(ch);
     nf:=nfi+ch;
     assign(fi,nf);
     reset(fi);
     fillchar(QH,sizeof(QH),0);
     fillchar(Cost,sizeof(Cost),0);

     readln(fi,n,m,w,k,s);
     for i := 1 to n do read(fi,cost[i]);
     readln(fi);
     for i := 1 to m do
       begin
            readln(fi,tg1,tg2);
            QH[tg1,tg2] := 1;
            QH[tg2,tg1] := 1;
       end;
     close(fi);

     assign(fo,nfo);
     reset(fo);
end;

function OK(pre,k : word) : boolean;
begin
     if (pre = 0) then begin OK := true; exit; end;
     if (QH[pre,k] = 0) then begin OK := false; exit; end;
     OK := true;
end;

procedure ErrorK(k : integer);
begin
     writeln('Lam gi co dinh ',k,' ?');
     writeln('error');
     close(fo);
     halt;
end;

procedure ErrorWay(pre,k : integer);
begin
     writeln('Lam gi duong di tu dinh ',pre,' sang dinh ',k,'  ?');
     writeln('error');
     close(fo);
     halt;
end;

procedure ErrorTotal;
begin
     writeln('Ban tinh sai so tien phai tra');
     writeln('error');
     close(fo);
     readln;
     halt;
end;

procedure GOOD;
begin
     writeln('ok!!!');
end;

procedure check;
var pre,k :     integer;
    total :     integer;
begin
     total := 0;
     pre := 0;
     while not seekeof(fo) do
       begin
            read(fo,k);
            if (k <= 0) then ErrorK(k);
            total := total + cost[k];
            if not OK(pre,k) then ErrorWay(pre,k);
            pre := k;
       end;
     if (total <> s) then ErrorTotal;
     GOOD;
     close(fo);
end;

begin
     clrscr;
     input;
     check;
     readln;
end.