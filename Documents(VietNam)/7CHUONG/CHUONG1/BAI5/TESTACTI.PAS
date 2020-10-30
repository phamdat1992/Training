{$R+}
{$M 60384,0,655360}

Uses  Crt;
Const
      inp: string = 'ACTIVITY.INP';
      out       = 'ACTIVITY.OUT';
      max       = 32001;
      dapso: array['1'..'5'] of integer = (5,9,25,78,126);
Type  arr       = array[0..max] of integer;
      arrPointer= ^arr;

Var   F         : Text;
      N         : Longint;
      Start, Finish, Ind: arrPointer;
      chapnhan  : array[1..10000] of boolean;
      tong, diem: Longint;
      chon: char;

Procedure Cham;
Var i,j  : Longint;
    u,v,t: Longint;
    Ok   : Longint;
    k: longint;
Begin
   diem:=0;
   Assign(f,inp); Reset(f);
   readln(f,n);
   for i:=1 to n do
       readln(f, Start^[i], (Finish^[i]));
   Close(f);
   Assign(f,out); Reset(f);
   Readln(f,tong);
   if (tong<=0) or (tong>n) then
   begin
       writeln('???????????????????????????????????????????????????');
       writeln('    ERROR: So luong cong viec duoc chon',tong);
       writeln('???????????????????????????????????????????????????');
       exit;
   end;
   fillchar(Chapnhan,sizeof(Chapnhan),false);
   for i:=1 to  tong do
   begin
        readln(f,k);
        if (k<=0) or (k>n) then
        begin
            writeln('???????????????????????????????????????????????????');
            writeln('    ERROR: Khong co cuoc hop voi chi so: ',k);
            writeln('???????????????????????????????????????????????????');
            exit;
        end;
        if Chapnhan[k] then
        begin
            writeln('???????????????????????????????????????????????????');
            writeln('       ERROR: Cuoc hop ',k,' bi lap lai!');
            writeln('???????????????????????????????????????????????????');
            exit;
        end;
        ind^[i]:=k;
        Chapnhan[k]:=true;
   end;
   Close(f);

   for i:=1 to tong-1 do
      for j:=i+1 to tong do
         if Finish^[ind^[j]]<Finish^[ind^[i]] then
         begin
             t:= ind^[i];
             ind^[i]:=ind^[j];
             ind^[j]:=t;
         end;
   if tong<22 then
   begin
       writeln;
       writeln('     Cac cuoc hop duoc phuc vu');
       writeln('   =================================');
       writeln('    Job         Start       Finish ');
       writeln('   =================================');
       for i:=1 to tong do writeln(ind^[i]:7,Start^[ind^[i]]:14,Finish^[ind^[i]]:12);
       writeln('   =================================');
       readln;
   end;
   for i:=2 to tong do
      if Start^[ind^[i]]<Finish^[ind^[i-1]] then
      begin
          writeln('******  ERROR  *****');
          writeln('Thoi gian cua cuoc hop ',ind^[i-1],' va ',ind^[i],' giao nhau');
          exit;
      end;
   if  tong < dapso[chon] then
   begin
       writeln('******  ERROR  *****');
       writeln('   Khong toi uu: Tim duoc: ',tong);
       writeln('                 Toi uu  : ',dapso[chon]);
       exit;
   end;
   diem:=2;
   writeln('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   writeln('       C O R R E C T ! C O R R E C T !');
   writeln('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
End;

Begin
   New(Start);
   New(Finish);
   New(Ind);
   Clrscr;
   writeln('            ===========================================');
   writeln('                  CHUONG TRINH CHAM BAI ACTIVITY');
   writeln('            ===========================================');
   write  ('                  Cho ten file test: ACTIVITY.IN');
   chon:=readkey; writeln(chon);
   inp:= 'ACTIVITY.IN'+chon;
   Cham;
   writeln; writeln;
   writeln('            ====================================');
   writeln('                       Diem: ',diem);
   writeln('            ====================================');
   readln;
End.
{  Test Bo tri phong hop }
{$R+}
{$M 60384,0,655360}

Uses  Crt;
Const
      inp: string = 'ACTIVITY.INP';
      out       = 'ACTIVITY.OUT';
      max       = 32001;
      dapso: array['1'..'5'] of Longint = (5,9,25,78,126);
Type  arr       = arr