{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses
    crt;
const
     fi         =       'bv.in7';
     fo         =       'bv.out';
     maxn       =       5000;
     inf        =       65530;
type
    link                =       ^node;
    node                =       record
      d                 :       integer;
      w                 :       word;
      lu                :       word;
      next              :       link;
    end;
    tmin                =       array[1..maxn] of longint;
var
   f,g          :       text;
   n            :       longint;
   a            :       array[1..maxn] of link;
   found        :       boolean;
   qu           :       array[1..maxn] of integer;
   dau,cuoi     :       longint;
   truoc        :       array[1..maxn,1..2] of word;
   min          :       ^tmin;
   sum          :       longint;

procedure init;
var
   i            :       longint;
   begin
        for i := 1 to maxn do a[i] := nil;
        new(min);
   end;

procedure add( u,v : integer; w,lu : word );
var
   l            :       link;
   begin
        new(l);
        l^.d := v;
        l^.w := w;
        l^.lu := lu;
        l^.next := a[u];
        a[u] := l;
   end;

procedure nhap;
var
   u,v          :       integer;
   w            :       word;
   begin
        assign(f,fi); reset(f);
        readln(f,n);
        while not seekeof(f) do
        begin
             readln(f,u,v,w);
             add(u,v,w,0);
             add(v,u,inf,inf);
        end;
        close(f);
   end;

procedure chuanbi;
   begin
        sum := 0;
   end;

function nn( s1,s2 : longint ) : longint;
   begin
        if s1 < s2 then nn := s1 else nn := s2;
   end;

procedure findpath;
var
   i,j          :       longint;
   l            :       link;
   p            :       link;
   begin
        for i := 1 to n do min^[i] := maxlongint;
        found := false;
        fillchar(truoc,sizeof(truoc),0);
        truoc[n][1] := 1;
        truoc[n][2] := 1;
        dau := 1;
        cuoi := 1;
        qu[cuoi] := n;
        while dau <= cuoi do
        begin
             i := qu[dau];      inc(dau);

             l := a[i];
             while l <> nil do
             begin
                  j := l^.d;
                  if (truoc[j][1] = 0) then
                  begin
                       {Canh thuan}
                       if (l^.lu < l^.w) then
                       begin
                            truoc[j][1] := i;
                            truoc[j][2] := l^.w - l^.lu;
                            min^[j] := nn(min^[i],l^.w - l^.lu);
                            inc(cuoi);
                            qu[cuoi] := j;
                            if j = 1 then
                            begin
                                 found := true;
                                 exit;
                            end;
                       end else {Canh nguoc}
                       if (l^.w = inf) then
                       begin
                            p := a[j];
                            while p <> nil do
                            begin
                                 if (p^.d = i) and (p^.w <> inf) then break;
                                 p := p^.next;
                            end;
                            if (p^.lu > 0) then
                            begin
                                 truoc[j][1] := i;
                                 truoc[j][2] := p^.lu;
                                 min^[j] := nn(min^[i],p^.lu);
                                 inc(cuoi);
                                 qu[cuoi] := j;
                                 if j = 1 then
                                 begin
                                      found := true;
                                      exit;
                                 end;
                            end;
                       end;
                  end;
                  l := l^.next;
             end;
        end;
   end;

procedure incflow;
var
   i,j          :       longint;
   l            :       link;
   co           :       boolean;
   begin
        i := 1;
        while i <> n do
        begin
             j := truoc[i][1];
             {Canh thuan}
             co := false;
             l := a[j];
             while l <> nil do
             begin
                  if (l^.d = i) and (l^.w - l^.lu = truoc[i][2]) then
                  begin
                       co := true;
                       l^.lu := l^.lu + min^[1];
                       break;
                  end;
                  l := l^.next;
             end;
             {Canh nguoc}
             if not co then
             begin
                  l := a[i];
                  while l <> nil do
                  begin
                       if (l^.d = j) and (l^.lu = truoc[i][2]) then
                       begin
                            l^.lu := l^.lu - min^[1];
                            break;
                       end;
                       l := l^.next;
                  end;
             end;
             i := j;
        end;
   end;

procedure xuly;
   begin
        repeat
              findpath;
              if found then
              begin
                   incflow;
                   sum := sum + min^[1];
              end;
        until not found;
   end;

procedure ghi;
var
   i,j          :       longint;
   l            :       link;
   begin
        assign(g,fo); rewrite(g);
        writeln(g,sum);
        for i := 1 to cuoi do
        begin
             l := a[qu[i]];
             while l <> nil do
             begin
                  if (l^.w <> inf) and (truoc[l^.d][1] = 0) then
                  begin
                       writeln(g,qu[i],' ',l^.d,' ',l^.w);
                  end;
                  l := l^.next;
             end;
        end;
        close(g);
   end;

procedure done;
   begin
        dispose(min);
   end;

BEGIN
     clrscr;
     init;
     nhap;
     chuanbi;
     xuly;
     ghi;
     done;
END.