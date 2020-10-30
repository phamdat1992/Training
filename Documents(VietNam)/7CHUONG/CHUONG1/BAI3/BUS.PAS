(* Solution to problem Bus *)

(* Algorithm: heavily based on the 'Knap-sack' problem *)
(* If we know the optimal route to cover any distance  *)
(* 0<x<n, there are only n possibilities for the best  *)
(* way to travel n+1, so use (known) result for n=1    *)
(* to find n=2, then n=3, and so forth until we know   *)
(* the best way to cover the distance asked.           *)
(* This algorithm is O(n^2), and so much faster than   *)
(* brute force. It is also easier to program.          *)

uses crt;
const
    fin: string = 'BUS.IN2';
    fou: string = 'BUS.OUT';
var
    dist: longint;
    price: array[0..1000] of longint;
    n, i, j: integer;
    f: text;

function  min(a,b: longint): longint;
begin
   (* Function find minimums *)
   min:=a;
   if  a>b then min:=b;
end;

BEGIN
    fillchar(price, sizeof(price),0);
    assign(f,fin); reset(f);
    readln(f, n, dist);
    for i:=1 to n do read(f,price[i]);
    (* Convenient upper bound saves a  *)
    for i:=n+1 to dist do  price[i]:=65535;
    close(f);
    (* check in the main loop for i< dist *)
    for i:=2 to dist do
       for j:=1 to i div 2 do
            price[i]:= min(price[i],price[j]+price[i-j]);
    assign(f,fou); rewrite(f);
    writeln(f,price[dist]);
    close(f);
END.

