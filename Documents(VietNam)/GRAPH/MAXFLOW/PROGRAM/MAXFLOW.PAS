Const
        fi              =               'maxflow.inp';
        fo              =               'maxflow.out';
        max             =               100;
Type
        arr             =               array [0..max] of integer;
        arr1            =               array [0..max] of boolean;
        lab             =               record
                 pre    :               integer;
                 v      :               integer;
                 end;
        arr2            =               array [0..max] of lab;
Var
        a               :               array [0..max] of arr;
        w               :               array [0..max] of arr;
        stack           :               arr;
        vs              :               arr1;
        nhan            :               arr2;
        top             :               integer;
        n               :               integer;
        m               :               integer;
        s               :               integer;
        t               :               integer;


procedure       input;
var
        f               :               text;
        x               :               integer;
        y               :               integer;
        i               :               integer;
begin
     assign(f,fi);
     reset(f);
     fillchar(a,sizeof(a),0);
     readln(f,n,m,s,t);
     for i:=1 to m do
         readln(f,x,y,a[x,y]);
     close(f);
end;


procedure       push(x:integer);
begin
     inc(top);
     stack[top]:=x;
end;

function        pop:integer;
begin
     pop:=stack[top];
     dec(top);
end;

procedure       init;
begin
     fillchar(vs,sizeof(vs),false);
     top:=1;
     stack[top]:=s;
     nhan[s].v:=maxint;
     nhan[s].pre:=s;
end;

function        min(a,b:integer):integer;
begin
     if a>b then min:=b
        else min:=a;
end;

procedure       repair(j:integer);
var
        i               :               integer;
begin
     for i:=1 to n do
         if not(vs[i]) then
         begin
              if (a[j,i]<>0) and (w[j,i]<a[j,i]) then
              begin
                   vs[i]:=true;
                   nhan[i].pre:=+j;
                   nhan[i].v:=min(nhan[j].v,a[j,i]-w[j,i]);
                   push(i);
              end
              else
              if (a[i,j]<>0) and (w[i,j]>0) then
              begin
                   vs[i]:=true;
                   nhan[i].pre:=-j;
                   nhan[i].v:=min(nhan[j].v,w[i,j]);

                   push(i);
              end;
         end;
end;

procedure       incflow;
var
        z               :               integer;
        x               :               integer;
begin
     z:=t;
     repeat
           x:=z;
           z:=nhan[x].pre;
           if z>0 then inc(w[z,x],nhan[t].v)
           else
               dec(w[x,z],nhan[t].v);
           z:=abs(z);
     until z=s;
end;

procedure       findflow;
var
        u               :               integer;
begin
     repeat
           init;
           while top>0 do
           begin
                u:=pop;
                repair(u);
                if vs[t] then
                   begin
                        incflow;
                        break;
                   end;
           end;
     until not(vs[t]);
end;


procedure       output;
var
        f               :               text;
        i               :               integer;
        j               :               integer;
        gt              :               integer;
begin
     assign(f,fo);
     rewrite(f);
     gt:=0;
     for i:=1 to n do
         if w[s,i]>0 then gt:=gt+w[s,i];
     writeln(f,gt);
     for i:=1 to n do
         for j:=1 to n do
             if w[i,j]>0 then writeln(f,i,' ',j,' ',w[i,j]);
     close(f);
end;


BEGIN
     input;
     findflow;
     output;
END.