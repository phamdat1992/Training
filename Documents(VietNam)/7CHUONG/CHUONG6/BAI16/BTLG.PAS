{$R+,B-}
uses crt;
  type gtbt=array [0..256] of byte;
  Const
      fi='logic.inp';
      fo='logic.out';
  var
      R1,R2,R3:string;
      kl:array[1..7] of byte;
      f:text;qd:boolean;
      gt1,gt2,gt3:gtbt;i:byte;

procedure nhap;
begin
     assign(f,fi);reset(f);
     readln(f,R1);
     readln(f,R2);
     readln(f,R3);
     close(f);
end;

function gtri(s:string):byte;
var
   i,r,l:word;
    function gtrikngoac(e:string): char;
      var p:word;
    begin
      if e[1]='(' then delete(e,1,1);
      if e[length(e)]=')' then delete(e,length(e),1);
      p:=pos('#',e);
      while p>0 do
        begin
          delete(e,p,1);
          case e[p] of
            '0': e[p]:='1';
            '1': e[p]:='0';
            '#': delete(e,p,1);
          end;
          p:=pos('#',e);
        end;
      p:=pos('&',e);
      while p>0 do
        begin
          if(e[p-1]='1') and(e[p+1]='1') then
          e[p-1]:='1' else e[p-1]:='0';
          delete(e,p,2);
          p:=pos('&',e);
        end;
      p:=pos('+',e);
      while p>0 do
        begin
          if(e[p-1]='0') and(e[p+1]='0') then
          e[p-1]:='0' else e[p-1]:='1';
          delete(e,p,2);
          p:=pos('+',e);
        end;
      gtrikngoac:=e[1];
    end;
begin
    while length(s)>1 do
      begin
      r:=pos(')',s);
      if r=0 then
      begin
           r:=length(s);
           l:=1;
      end
      else
          begin
               l:=r;
               while s[l]<>'(' do dec(l);
          end;
          s[l]:=gtrikngoac(copy(s,l,r-l+1));
          delete(s,l+1,r-l);
      end;
    if s[1]='1' then gtri:=1 else gtri:=0;
end;

procedure tinhgt(s:string;var gt:gtbt);
var
a:array['a'..'k'] of char;
dem:word;j,k:char;
   procedure sm1;
   var
      i,i1,dem1,dem2:word;s6:string;
   begin
      s6:=s;
      for i1:=1 to length(s6) do
          if('a'<=s6[i1])and(s6[i1]<='k') then s6[i1]:=a[s6[i1]];
          dem1:=dem div 8;
          dem2:=dem mod 8;
          if gtri(s6)=1 then
          gt[dem1]:=gt[dem1] or(1 shl dem2);
   end;

begin
     dem:=0;
     fillchar(a,sizeof(a),'0');
     sm1;
     j:='k';
     while j>='a' do
      begin
           j:='k';
           while(j>='a')and(a[j]='1') do dec(j);
           if j>='a' then
           begin
                a[j]:='1';
                if j<'k' then
                for k:=succ(j) to 'k' do a[k]:='0';
                inc(dem);
                sm1;
           end;
      end;
end;

function kn(i:byte):byte;
var
   j:byte;
begin
     kn:=i;
     case i of
     1:
       for j:=0 to 31 do if gt3[j]<>gt1[j] and gt2[j] then
       begin
            kn:=0;
            exit;
       end;
     2:
       for j:=0 to 31 do if gt3[j]<>gt1[j] or gt2[j] then
       begin
            kn:=0;
            exit;
       end;
     3:
       for j:=0 to 31 do if gt3[j]<>not(gt1[j]) then
       begin
            kn:=0;
            exit;
       end;
     4:
       for j:=0 to 31 do if gt3[j]<>not(gt2[j]) then
       begin
            kn:=0;
            exit;
       end;
     5:
       for j:=0 to 31 do if gt3[j]<>gt1[j] then
       begin
            kn:=0;
            exit;
       end;
     6:
       for j:=0 to 31 do if gt3[j]<>gt2[j] then
       begin
            kn:=0;
            exit;
       end;
     end;
end;

procedure xet;
var
   dem:byte;
begin
     fillchar(gt1,sizeof(gt1),0);
     fillchar(gt2,sizeof(gt2),0);
     fillchar(gt3,sizeof(gt3),0);
     fillchar(kl,sizeof(kl),0);
     tinhgt(R1,gt1);
     tinhgt(R2,gt2);
     tinhgt(R3,gt3);
     assign(f,fo);
     rewrite(f);
     dem:=0;
     for i:=1 to 6 do if kn(i)>0 then
     begin
          inc(dem);
          write(f,kn(i):3);
     end;
     if dem=0 then write(f,7);
     writeln(f);
     close(f);
end;

BEGIN
nhap;xet;
END.
