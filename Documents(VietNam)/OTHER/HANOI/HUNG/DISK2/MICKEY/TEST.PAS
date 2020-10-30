program TestChuotMicKey;
{Bai 1 toan quoc bang B}

const
  INP = 'mickey.in';
  OUT = 'mickey.ou';

var
  X, stuSol, sol: longint;
  c: char;
  ok: boolean;

procedure Quit(message: string);
  begin
    writeln(message);
    ok:=false;
{    halt;}
  end;

procedure loadInOut( testNo:string);
  var f: text;
  begin
    {$I-}
    assign(f,INP + testNo);
    reset(f);
    if ioresult <>0 then
      begin
      Quit('Khong tim thay file '+INP+testNo);
      exit;
      end;
    if seekeof(f) then
    begin
    Quit('File input khong co du lieu');
          exit;
      end;
    read(f,X);
    if ioresult <>0 then
      begin Quit('File input co loi');
          exit;
      end;
    close(f);
    assign(f,OUT + testNo);
    reset(f);
    if ioresult <>0 then
      begin
       Quit('Khong tim thay file '+OUT+testNo);
          exit;
      end;
    if seekeof(f) then
      begin
        Quit('File output khong co du lieu');
          exit;
      end;
    read(f,stuSol);
    if ioresult <>0 then
    begin
     Quit('File output co loi');
          exit;
      end;
    {$I+}
  end;

function digitCount(x: longint): integer;
  var
    count: integer;
  begin
    count:=0;
    repeat
      x:=x div 10;
      inc(count);
    until x=0;
    digitCount:=count;
  end;

function lessThanReverse(x: longint): boolean;
  var
    d: array [0..10] of integer;
    l,u,v: integer;
  begin
    l:=0;
    while (x>0) do
    begin
      d[l]:=x mod 10;
      x:=x div 10;
      inc(l);
    end;
    u:=0; v:=l-1;
    while (u<v) and (d[u]=d[v]) do
      begin
        inc(u);
        dec(v);
      end;

    if u>=v then lessThanReverse:= false
    else lessThanReverse := d[u]>d[v];
  end;

function result(x: longint): longint;
  var
    curState, prevState, nextState: integer;

  begin
    curState := 0; prevState:=-1;   {start at node 0}

    while (x > 0) and (curState <> 1) do
      begin
        {write('(',x,',',curState,') ');}
        {write(curState,' ');}
        case curState of
          2: case (x mod 3) of
               0: nextState:=7;
               1: nextState:=1;
               2: nextState:=4;
             end;
          4: if lessThanReverse(x) then nextState:= 6
             else nextState:= 2;
          6: if odd(digitCount(x)) then nextState:= 7
             else nextState:= 4;
          7: case ((x mod 7)*(x mod 7) mod 7) of
               0: nextState:=2;
               1: nextState:=6;
               2: nextState:=8;
               4: nextState:=0;
               else writeln('Bizzard!!!');
             end;
          8: if (x mod 5 = 2) or (x mod 5 = 3) then nextState:=7
             else nextState:=9;
          9: if prevState=0 then nextState:=8
             else nextState:=0;
          0: if ((x mod 1000) div 100) <= 7 then nextState:= 7
             else nextState:= 9;

          else
            begin
              write('Error: unknown state...');
              readln;
            end;
        end;

        prevState := curState;
        curState := nextState;
        dec(x);
      end;
    {write('(',x,',',curState,') ');}
    {write(curState);}
    if x=0 then result:=-1 else result:=x;
  end;

begin
  {if paramcount<1 then Quit('Cach chay chuong trinh:   mickey <so_hieu_test>');
  loadInOut(paramstr(1));
  }
  for c:='0' to '9' do
    begin
    ok:=true;
    write('    ',c);
    loadInOut(c);
    if not ok then continue;
    sol := result(X);
    writeln('Dap so dung: ',sol,#9,'Dap so cua sinh vien: ',stuSol);
    if sol<>stuSol then writeln('SAI')
    else writeln('DUNG');
    end;
  {repeat
    readln(x);
    writeln(result(x));
  until false;}
end.