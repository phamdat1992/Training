{Completed}
{$R+}
{$M 65000 0 655360}
{
 lap2 day1
 Date   :7-7-1997
 Note   :Program has five main procedure. They are:
         + [init];
           - create outfile to append.
           - init first and last array.
         + readdata;
           - read data from input file;
         + initprimes;
           - find every prime number which sum is ts
         + find;
           - try to fill chart s follow this index
            [ Row1 >> Col1 >> Lower >> Digonal >> Row2 >> Col2 >> Row3 >> Col3
              >> Row4 >> Col4 >> Row5 >> Check Col5 >> Check Uper Digonal>>
               WRITEOUT
            ]
         + final;
 Technichal Notes:
         - Using FOWARD to call procedures from procedures;
         - Using FIRST and LAST array to reduce checking;
}
PROGRAM PrimesMatrix;
  USES
    Time, Crt;
  TYPE
    digit  = 0 .. 9;
    index  = 1 .. 5;
    number = record
               numbers:array[index] of digit;
               value:longint;
             end;
  CONST
    inpname = 'PRIME.INP';
    outname = 'PRIME.OUT';
  VAR
    ts, x       : byte;
    primes      : array[ 1 .. 800 ] of number;
    first, last : array[ digit ] of integer;
    s           : array[index, index] of digit;
    total       : word;
    count       : word;

  procedure init;
    var
      t : digit;
      f : text;
    begin
      writeln(' . Program is initlizing now');
      assign(f,outname); rewrite(f);{ Khoi tao outname de APPEND }
      close(f);
      total:=0;
      for t:=1 to 9 do
        begin
          first[t]:=-1;
          last[t]:=-2;
        end;
      writeln(' . First and Last array is initilizing');
    end;

  procedure readdata;
    var
      f : text;
    begin
      assign(f,inpname);     reset(f);
      readln( f, ts );
      readln( f, x  );
      writeln(' . Input data is read..');
      close(f);
    end;

            function oddisprime(x:longint):boolean;
              var
                run, y : word;
              begin
                {$R-}
                run:=1;
                while primes[run].value<x do inc(run);
                oddisprime:=primes[run].value=x;
                {$R+}
             end;

  procedure initprimes_;
    Var
      i, j, k : longint;
      a       : array [1..317] of boolean;
      b       : array [1..100] of integer;
      Ok      : boolean;
      g, p, t : longint;

  function  sum(x:longint):byte;
    var
      tg : byte;
    begin
      tg:=0;
      while x<>0 do
            begin
            tg:=tg+x mod 10 ;
            x:=x div 10;
            end;
      sum:=tg;
    end;
  begin
    write(' . Initilizing Primes..');
    Count:=0;
    For i:=2 to 317 do a[i]:= true;
    For i:=2 to 18 do
        For j:= 2 to 317 div i do a[i*j]:= false;
    j:=0;
    For i:=1 to 317 do If a[i] then begin j:=j+1;b[j]:=i end;
    t:=j;
    For i:= 10001 to 99997 do
        begin
             Ok:= true;
             if sum(i)<>ts then continue;
             for j:= 2 to t do if i mod b[j] = 0 then begin Ok:= false;break;end;
             If Ok then
                begin
                     inc(count);
                     with primes[count] do
                          begin
                               value:=i;
                               g:=i;
                               p:=5;
                               while g<>0 do
                                     begin
                                     numbers[p]:=g mod 10;
                                     g:=g div 10;
                                     p:=p-1;
                                     end;
                               if first[numbers[1]]=-1 then first[numbers[1]]:=count;
                               last[numbers[1]]:=count;
                          end;
                end;
        end;
writeln(' ',count,' found >> ', timenow, ' clocks.');
  end;

  procedure writeout;
    var
      i, j : index;
      f    : text;
    begin
      inc(total);
      assign(f,outname);append(f);
      for i:=1 to 5 do
        begin
          for j:=1 to 5 do write(f,s[i,j],' ');
          writeln(f);
        end;
      writeln(f);
      close(f);
    end;


  procedure H1;         forward;
  procedure H2;         forward;
  procedure H3;         forward;
  procedure H4;         forward;
  procedure H5;         forward;
  procedure V1;         forward;
  procedure V2;         forward;
  procedure V3;         forward;
  procedure V4;         forward;
  procedure V5;         forward;
  procedure D1;         forward;
  procedure D2;         forward;

  procedure find;
    begin
      s[1,1]:=X;
      H1;
    end;

  var c:index;

  procedure H1;
    var
      i : longint;
    begin
      {$B-}
      for i:=first[x] to last[x] do
        with primes[i] do
          if (numbers[2]<>0) and (numbers[3]<>0) and (numbers[4]<>0) then
            begin
              for c:=2 to 5 do s[1,c]:=numbers[c];
              V1;
            end;
    end;{ Checked }

  procedure V1;
  var   i:word;
  begin
    {$B-}
    for i:=first[x] to last[x] do
      with primes[i] do
        if (numbers[2]<>0) and (numbers[3]<>0) and (numbers[4]<>0) then
          begin
            for c:=2 to 5 do s[c,1]:=numbers[c];
            D2
          end;
  end;

  procedure D2;
    var
      i : word;
    begin
      for i:=first[ S[5,1] ] to Last[ S[5,1] ] do
        with primes[i] do
          if numbers[5]=s[1,5] then
            begin
              s[4,2] := numbers[2];
              s[3,3] := numbers[3];
              s[2,4] := numbers[4];
              H2;
            end;
    end;

  procedure H2;
    var
      i : word;
    begin
      for i:=first[s[2,1]] to last[s[2,1]] do
        with primes[i] do
          if numbers[4]=s[2,4] then
            begin
              s[2,2] := numbers[2];
              s[2,3] := numbers[3];
              s[2,5] := numbers[5];
              V2
            end;
    end;

  procedure V2;
    var
      i : word;
    begin
      {$B-}
      for i:=first[s[1,2]] to last[s[1,2]] do
        with primes[i] do
          if (numbers[2] = s[2,2]) and (numbers[4]=s[4,2]) then
            begin
              s[3,2] := numbers[3];
              s[5,2] := numbers[5];
              H3
            end;
    end;{ Checked }

  procedure H3;
    var
      i : word;
    begin
      {$B-}
      for i:=first[s[3,1]] to last[s[3,1]] do
        with primes[i] do
          if (numbers[2]=s[3,2]) and (numbers[3]=s[3,3]) then
            begin
              s[3,4] := numbers[4];
              s[3,5] := numbers[5];
              V3;
            end;
    end;{ Checked }

  procedure V3;
  var
    i : word;
  begin
    {$B-}
    for i:=first[s[1,3]] to last[s[1,3]] do
      with primes[i] do
        if (numbers[2]=s[2,3]) and (numbers[3]=s[3,3]) then
          begin
            s[4,3]:=numbers[4];
            s[5,3]:=numbers[5];
            H4;
          end;
  end;

  procedure H4;
    var
      i : word;
    begin
      {$B-}
      for i:=first[s[4,1]] to last[s[4,1]] do
        with primes[i] do
          if (numbers[2]=s[4,2]) and (numbers[3]=s[4,3]) then
            begin
              s[4,4]:=numbers[4];
              s[4,5]:=numbers[5];
              V4;
            end;
    end;

  procedure V4;
    var
     i : word;
    begin
       for i:=first[s[1,4]] to last[s[1,4]] do
         with primes[i] do
           if (numbers[2]=s[2,4]) and (numbers[3]=s[3,4]) and (numbers[4]=s[4,4]) then
             begin
               s[5,4]:=numbers[5];
               H5;
             end;
    end;

  procedure H5;
    var
      d, w : longint;
    begin
      d := ts;
      w := 0;
      for c:=1 to 4 do
        begin
          d := d - s[5,c];
          w := w*10 + s[5,c];
        end;
      {$B-}
      if odd(d) and (d>=0) and (d<=9) and oddisprime(w*10+d) then
        begin
          s[5,5]:=d;
          V5;
        end;
    end;

  procedure V5;
    var
      i : longint;
      j : index;
    begin
      i := 0;
      for j := 1 to 5 do i := i*10+s[j,5];
      if oddisprime(i) then D1;
    end;

  procedure D1;
    var
      i   : longint;
      sum : byte;
    begin
      sum := 0;
      i := 0;
      for c:=1 to 5 do begin i:=i*10+s[c,c];sum:=sum+s[c,c] end;
      if sum=ts then if oddisprime(i) then writeout;
    end;

  procedure final;
    var
      f : text;
    begin
      assign(f,outname);append(f);
      writeln(f);
      writeln(f,'Co tat ca ',total,' bang so dien duoc.');
      close(f);
      writeln(' . Elapsed time : ',timenow,' clock.');
    end;

  begin
    Clrscr;
    writeln(' . Starting clock timing..');
    init;
    readdata;
    initprimes_;
    find;
    final;
  end.
11
1