const  fi='TUDIEN.IN1';
       fo='TUDIEN.OUT';
       max=1000;
var    dl         :  array[1..26,1..26] of 0..26;
       xet     	  :  array['a'..'z'] of boolean;
       result	  :  array[1..26] of char;
       n,sl,sc    :  shortint;
       f    	  :  text;
       time		  :  longint  absolute $00:$46C;
       t1,t2	  :  longint;

procedure input;
var i,j       : 1..max;
    s1,s2,qua : string;
    ok	      : boolean;
    i1        : char;
begin
    fillchar(dl,sizeof(dl),0);
    fillchar(xet,sizeof(xet),true);
    assign(f,fi);  reset(f);

    while not(eof(f)) do
      begin
        readln(f,n);
        readln(f,s1);

        for i:=2 to n do
           begin
              readln(f,s2);
              j:=1;  ok:=true;
              while (j<=length(s1)) and (j<=length(s2)) and ok do
                 if s1[j]=s2[j] then   inc(j)
                 else   ok:=false;

                 if Dl[ord(s1[j])-96,ord(s2[j])-96] = 0 then
                    begin
        			   Dl[ord(s1[j])-96,ord(s2[j])-96]:=1;
                       xet[s1[j]]:=false;  xet[s2[j]]:=false;
                    end
                 else
                    begin
                         Dl[ord(s2[j])-96,ord(s1[j])-96]:=0;
						 for j:=i+1 to n do   readln(f,qua);
                    end;
                 s1:=s2;
           end;
      end;
    close(f);
    for i:=1 to 16 do
       begin
          for j:=1 to 16 do
             write(dl[i,j],' ');
             writeln;
       end;
end;

procedure find;
var  j   : byte;
     i   : 'a'..'z';
     dem : byte;
begin
   sc:=0;
   for i:='a' to 'z' do
      if not xet[i] then
        begin
           dem:=0;
           for j:=1 to 26 do
              if dl[j,ord(i)-96] <> 0 then  inc(dem);

           if dem=0 then  begin  inc(sc);  result[sc]:=i;  end;
           for j:=1 to 26 do
              if dl[ord(i)-96,j] <>0 then   dl[ord(i)-96,j]:=0;
        end;
end;

procedure output;
var  i : byte;
	 f : text;
begin
	assign(f,fo); rewrite(f);
	writeln(f,1);
    for i:=1 to sc do   write(f,result[i]);
    close(f);
end;

BEGIN
   t1:=time;
   input;
   find;
   output;
   t2:=time;
   writeln('  ',(t2-t1)/18.21:5:2);
END.

