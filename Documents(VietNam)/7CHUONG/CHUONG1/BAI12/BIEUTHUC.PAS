{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 65000,0,655360}
uses crt;
const
     fi   = 'bt.inp';
     fo   = 'bt.out';
     nmax = 738;
var
   f    :       Text;
   x,k  :       Longint;
   a,d  :       array[1..738]of byte;
   l,pre:       array[1..738]of integer;
   stop :       boolean;
procedure rf;
begin
     assign(f,fi);
     reset(f);
     readln(f,x);
     readln(f,k);
     close(f);
end;

function tinhgiatri(x , y  :   Longint):Integer;
var i,k,dmax,dmin,sx       :   byte;
    st                     :   string;
    c                      :   integer;
begin
     str(y,st);
     dmax:=0;
     dmin:=9;
     for i:=1to length(st) do
      begin
           val(st[i],k,c);
           if k<dmin then dmin:=k;
           if k>dmax then dmax:=k;
      end;
     str(x,st);
     sx:=0;
     for i:=1 to length(st) do
       begin
            val(st[i],k,c);
            sx:=sx+k;
       end;
     tinhgiatri:=sx*dmax+dmin;
end;

procedure timbieuthuc;
var i,t,top         :   integer;
begin
     fillchar(a,sizeof(a),0);
     for i:=1 to 738 do l[i]:=maxint;
     t:=tinhgiatri(x,x);
     a[t]:=1;
     l[t]:=1;
     stop:=false;
     while not stop do
     begin
          stop:=true;
          for i:=1 to nmax do
           if a[i]=1 then
           begin
                t:=tinhgiatri(x,i);
                if l[t]>l[i]+1 then
                begin
                     a[t]:=1;
                     l[t]:=l[i]+1;
                     pre[t]:=t;
                     d[t]:=1;
                     stop:=false;
                end;
                t:=tinhgiatri(i,x);
                if l[t]>l[i]+1then
                begin
                     a[t]:=1;
                     l[t]:=l[i]+1;
                     pre[t]:=i;
                     d[t]:=2;
                     stop:=false;
                end;
                t:=tinhgiatri(i,i);
                if l[t]>2*l[i]+1 then
                begin
                     a[t]:=1;
                     l[t]:=2*l[i]+1;
                     pre[t]:=i;
                     d[t]:=3;
                     stop:=false;
                end;
           end;
     end;
end;

procedure path(t :   integer);
begin
     if pre[t]<>0 then
     begin
          write(f,'(');
          case d[t] of
           1:
             begin
                  write(f,x,'#');
                  path(pre[t]);
             end;
           2:
             begin
                  path(pre[t]);
                  write(f,'#',x);
             end;
           3:
             begin
                  path(pre[t]);
                  write(f,'#');
                  path(pre[t]);
             end;
          end;
          write(f,')');
     end
     else
     write(f,'(',x,'#',x,')');
end;

procedure xuli;
begin
     assign(f,fo);
     rewrite(f);
     if k>738 then writeln(f,'0')else
     begin
          timbieuthuc;
          if a[k]=0 then writeln(f,'0')else
          begin
               writeln(f,l[k]);
               path(k);
          end;
     end;
     close(f);
end;

begin
     clrscr;
     rf;
     xuli;
end.
718
81


