{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 65520,0,655360}
{
 - Phan bo tai nghuyen -
 -     Version 1.0     -
 -   Copyright by DQL  -
}
uses crt;
const
  inp='resalo.inp';
  out='resalo.out';
type
  ma=array[1..20] of longint;
  gt=array[1..20] of ma;
  pa=record
     n:integer;
     worker:array[1..20] of integer;
     k:integer;
     lost:array[1..20] of longint;
     c:gt;
     maxpower,mneed,wneed:longint;
  end;
var
  maxmoney,maxworker,bestp,bestw,bestm:longint;
  num:integer;
  a:array[1..20] of pa;
  savecon,numm,numw,con:array[1..20] of longint;
  ten,pp,bestten,bestpp,start:array[1..20] of integer;
  time:longint;
  f:text;
{}
 procedure nhap;
  var i,j,k:integer;
  begin
    assign(f,inp);
    reset(f);
      readln(f,num,maxworker,maxmoney);
      for k:=1 to num do with a[k] do begin
         readln(f,n);
           for i:=1 to n do read(f,worker[i]);
         readln(f);
         readln(f,k);
           for i:=1 to k do read(f,lost[i]);
         readln(f);
           for i:=1 to n do begin
             for j:=1 to k do read(f,c[i,j]);
             readln(f);
           end;
      end;
    close(f);
  end;
{}
 procedure cbi;
  begin
    bestp:=0;
  end;
{}
 function kth(n:integer;var t:ma):boolean;
  var i:integer;
  begin
    kth:=false;
    for i:=1 to n do
      if t[i]>0 then exit;
    kth:=true;
    end;
{}
 procedure xuly1(k:integer);
  var i,j,u:integer;
      max:longint;
      t:gt;
      ok:boolean;
  begin
   with a[k] do begin
       t:=c;
       for i:=1 to n do begin
         max:=t[i,1];
         for j:=2 to k do
           if t[i,j]<max then begin
              t[i,j]:=max+1;
              c[i,j]:=-1;
           end else max:=t[i,j];
       end;
       for j:=1 to k do begin
         max:=t[1,j];
         for i:=2 to n do
           if t[i,j]<max then c[i,j]:=-1 else max:=t[i,j];
       end;
       for i:=n downto 1 do begin
         ok:=true;
           for j:=1 to k do
             if c[i,j]>=0 then begin
               ok:=false;break;
             end;
         if ok then begin
           move(c[i+1],c[i],(n-i)*sizeof(c[i]));
           move(worker[i+1],worker[i],(n-i)*2);
           dec(n);
         end;
       end;
       for j:=k downto 2 do begin
        ok:=true;
          for i:=1 to n do
            if c[i,j]>=0 then begin
              ok:=false;break;
            end;
        if ok then begin
          for u:=1 to n do move(c[u,j+1],c[u,j],(k-j)*4);
          move(worker[j+1],worker[j],(k-j)*2);
          move(lost[j+1],lost[j],(k-j)*4);
          dec(k);
        end;
       end;
   end;
  end;
{}
 procedure xuly2(k:integer);
  var i,j,maxi,maxj:integer;
      max:longint;
  begin
    with a[k] do begin
      max:=0;maxi:=1;maxj:=1;
      for i:=1 to n do
        for j:=1 to k do
          if c[i,j]>max then begin
              max:=c[i,j];
              maxi:=i;maxj:=j;
          end;
      maxpower:=max;
      mneed:=lost[maxj];wneed:=worker[maxi];
    end;
  end;
{}
 procedure xuly3(k:integer);
  var power:array[1..20] of longint;
      t:ma;
      i,j:integer;
      max,maxi,temp:longint;
  begin
    with a[k] do begin
      for i:=1 to n do begin
        power[i]:=0;
        for j:=1 to k do
          if c[i,j]>=0 then inc(power[i],c[i,j]*5-lost[j]);
      end;
      for i:=1 to n do begin
        max:=power[i];maxi:=i;
        for j:=i+1 to n do
          if power[j]>max then begin
            max:=power[j];maxi:=j;
          end;
        t:=c[i];c[i]:=c[maxi];c[maxi]:=t;
        power[maxi]:=power[i];power[i]:=max;
        temp:=worker[i];worker[i]:=worker[maxi];worker[maxi]:=temp;
      end;
    end;
  end;
{}
 procedure xuly4(pa:integer);
  var i:integer;
  begin
    with a[pa] do begin
      for i:=1 to n do
        if worker[i]=0 then begin
          start[pa]:=i;exit;
        end;
    end;
  end;
{}
 procedure xuly(k:integer);
  begin
    xuly1(k);
    xuly2(k);
    xuly3(k);
    xuly4(k);
  end;
{}
 procedure rgon;
  var mini,i,j,k:integer;
      min:longint;
      ok:array[1..20] of boolean;
  begin
    for k:=1 to num do xuly(k);
    for i:=1 to num do begin
        con[i]:=a[i].maxpower;
        numm[i]:=a[i].mneed;
        numw[i]:=a[i].wneed;
        for j:=i+1 to num do begin
          inc(con[i],a[j].maxpower);
          inc(numm[i],a[j].mneed);
          inc(numw[i],a[j].wneed);
        end;
        savecon[i]:=con[i];
        if numm[i]>maxmoney then begin
          fillchar(ok,sizeof(ok),true);
          while numm[i]>maxmoney do begin
            min:=0;
            for j:=i to num do
              if ok[j] and (a[j].mneed>min) then begin
                min:=a[j].mneed;mini:=j;
              end;
            dec(numm[i],a[mini].mneed);
            dec(numw[i],a[mini].wneed);
            dec(con[i],a[mini].maxpower);
            ok[mini]:=false;
          end;
          inc(con[i],a[mini].maxpower);
          inc(numw[i],a[mini].wneed);
        end;
        if numw[i]>maxworker then begin
          fillchar(ok,sizeof(ok),true);
          while numw[i]>maxworker do begin
            min:=0;
            for j:=i to num do
              if ok[j] and (a[j].wneed>min) then begin
                min:=a[j].wneed;mini:=j;
              end;
            dec(numw[i],a[mini].wneed);
            dec(con[i],a[mini].maxpower);
            ok[mini]:=false;
          end;
          inc(con[i],a[mini].maxpower);
        end;
    end;
  end;
{}
 procedure inkq;
  var i,j:integer;
  begin
    assign(f,out);
    rewrite(f);
      writeln(' Money  = ',maxmoney-bestm);
      writeln(' Worker = ',maxworker-bestw);
      writeln(' Power  = ',bestp);
      writeln(f,maxmoney-bestm);
      writeln(f,maxworker-bestw);
      writeln(f,bestp);
       for i:=1 to num do with a[i] do begin
         writeln(f,lost[bestpp[i]]);
         writeln(f,worker[bestten[i]]);
         writeln(f,c[bestten[i],bestpp[i]]);
       end;
    close(f);
    writeln;
    writeln(' Time = ',meml[0:$46c]-time,'  Second = ',(meml[0:$46c]-time)/18.2:5:5);
  end;
{}
 procedure ktkq(p,m:longint;w:integer);
  begin
    if p>bestp then begin
      bestp:=p;
      bestm:=m;
      bestw:=w;
      bestten:=ten;
      bestpp:=pp;
    end;
  end;
{}
 procedure try(who:integer;p,m:longint;w:integer);
  var i,j,neww:integer;
  begin
    if who>num then begin
      ktkq(p,m,w);
      exit;
    end;
    if p+con[who]<bestp then exit;
    with a[who] do begin
      for i:=1 to n do if w>=worker[i] then begin
        ten[who]:=i;neww:=w-worker[i];
          for j:=1 to k do if (c[i,j]>0)and(m>=lost[j]) then begin
             pp[who]:=j;
             try(who+1,p+c[i,j],m-lost[j],neww);
          end;
      end;
      if m>=lost[1] then begin
        ten[who]:=start[who];pp[who]:=1;
        try(who+1,p+c[start[who],1],m-lost[1],neww);
      end;
    end;
  end;
{}
 procedure super;
  begin
    try(1,0,maxmoney,maxworker);
    con:=savecon;
    if bestp=con[1] then exit;
    try(1,0,maxmoney,maxworker);
  end;
{}
begin
  clrscr;
  time:=meml[0:$46c];
  nhap;
  cbi;
  rgon;
  super;
  inkq;
end.

