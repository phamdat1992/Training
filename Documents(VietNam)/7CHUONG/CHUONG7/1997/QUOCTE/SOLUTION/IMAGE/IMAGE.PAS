{Solution IOI '97 Image recognition
 20-11-97
 JJ Combrink

 Input files from current directory:
 IMAGE.DAT
 FONT.DAT
 Output files to current directory:
 IMAGE.OUT
}


{$r-}
USES Crt,Dos;

CONST ImageFilename='IMAGE.DAT';
      FontFilename='FONT.DAT';
      OutputFilename='IMAGE.OUT';

VAR Txt,Txt2:Text;
    Alphabet:ARRAY[1..27,1..20] OF STRING[20];
    Scr:ARRAY[1..21] OF STRING[20];
    {circular buffer containing a part of the screen}
    Scrpos:Byte;
    {the current position in the circular buffer}

    J,K,Y:Integer;
    Outputmatches,Outputchar:Integer;
    lines:INTEGER;

PROCEDURE Read_Line_Into_Scr; {read the next verticle line into the buffer}
BEGIN
  IF NOT(EOF(Txt)) THEN
  BEGIN
   Readln(Txt,Scr[Scrpos]);
   INC(Scrpos);
   IF Scrpos>21 THEN Scrpos:=1; {let the buffer wrap if it exceeds 21}
  END;
 Dec(lines);
END;

{Procedure decription:
 This procedure compares the 27 given correct characters with a position
 on the screen and record the number of pixels which are similar on the
 screen. For each one of the 27 correct characters it compares another 40
 times for the 20 different kind of ways a verticle line can be ommitted
 or 20 kinds of duplications. Thus in total 27x41 characters are compared
 to a position on the screen. Whichever one fits the best, are selected as
 the character (since it's the greatest possibility to be correct.}

PROCEDURE Scan_Character;
VAR Check_Char,Inloop,Outloop,Looplength,Actionline,Scan_Position:Integer;
    Alphscanpos,J:Integer;
    Task:Integer;{0-leave 1-double 2-ommit}
    O_M,O_C:Integer;
BEGIN
 Outputmatches:=0;
 Outputchar:=1;
 FOR Check_Char:=1 TO 27 DO {loop through all the correct characters}
 BEGIN
  {loop and change to all possible ommitions and duplications of lines 2*20+1}
  FOR Outloop:=0 TO 40 DO
  BEGIN
   CASE Outloop OF {set the changes on the character to be compared}
    0:BEGIN Task:=0;Actionline:=0;Looplength:=20;END;
    1..20:BEGIN Task:=1;Actionline:=Outloop;Looplength:=21;END;
    ELSE BEGIN Task:=2;Actionline:=Outloop-20;Looplength:=19;END;
   END;

   Scan_Position:=Scrpos+1;
   IF Scan_Position>21 THEN Dec(Scan_Position,21); {wrap the buffer}

   Alphscanpos:=1;O_M:=0;O_C:=0;
   FOR Inloop:=1 TO Looplength DO
   BEGIN
    IF Inloop=Actionline THEN
    BEGIN
     IF Task=1 THEN
     BEGIN
      FOR J:=1 TO 20 DO
       IF Alphabet[Check_Char,Alphscanpos][J]=Scr[Scan_Position][J] THEN INC(O_M);
     END ELSE INC(Alphscanpos);
    END ELSE
    BEGIN
     FOR J:=1 TO 20 DO
      IF Alphabet[Check_Char,Alphscanpos][J]=Scr[Scan_Position][J] THEN INC(O_M);
     INC(Alphscanpos);
    END;
    INC(Scan_Position);
    IF Scan_Position>21 THEN Scan_Position:=1;
   END;

   IF Outputmatches<O_M THEN {if the current character has less differences
    then record it as the "closest match character"}
   BEGIN
    Outputchar:=Check_Char;
    Outputmatches:=O_M;
   END;

  END;
 END;
END;

PROCEDURE Output(No:Integer);
BEGIN
 Assign(Txt2,OutputFilename);
 Append(Txt2);
 IF No=1 THEN
 BEGIN
  Write(' ');
  Write(Txt2,' ')
 END ELSE
 BEGIN
  Write(Chr(No+63));
  Write(Txt2,Chr(No+63))
 END;
 Close(Txt2);
END;

PROCEDURE Init;
BEGIN
 Randomize;

 Assign(Txt2,OutputFilename);
 Rewrite(Txt2);
 Close(Txt2);

 Assign(Txt,FontFilename);
 Reset(Txt);
 Readln(txt,j);
 FOR J:=1 TO 27 DO
 BEGIN
  FOR Y:=1 TO 20 DO
  BEGIN
   Readln(Txt,Alphabet[J,Y]);
  END;
 END;
 Close(Txt);

 Assign(Txt,ImageFilename);
 Reset(Txt);
 READLN(txt,lines);

 Scrpos:=1;
 FOR J:=1 TO 21 DO
 BEGIN
  Read_Line_Into_Scr;
 END;
 Scan_Character;

 Output(Outputchar);
 IF NOT(EOF(Txt)) THEN
 FOR J:=1 TO 19 DO {fill the buffer}
   Read_Line_Into_Scr;
END;

VAR O_M,O_C,Gotnum:Integer;
BEGIN
 Clrscr;
 Init;

 {Description: Verticle lines can either be ommitted duplicated or just left
  as they are. The first character wil definitely start on the first verticle
  line of the screen, since there is no character before it which can affect
  the starting verticle line of the character on the screen. If a character
  is then recognised (the character with the highest probability) then
  there is still no certain way to say whether a line was ommitted or
  duplicated. This leaves an uncertainty of where the next character should
  start. This uncertainty will grow with each new character scanned.

  To overcome this problem the program scans all three possible starting
  points of a character. The character with the higest probabality out of
  the possible 3x27x41 character combined positions is then selected.
  The accuracy with this method is surprisingly high.
  }
 IF NOT(EOF(txt)) THEN
 REPEAT
  O_M:=0;O_C:=1;Gotnum:=1;
  FOR J:=1 TO 3 DO {loop all three possible places where the character might
                    start}
  BEGIN
   Scan_Character;
   IF O_M<Outputmatches THEN {check if the character found by scan_character
                              is a better match}
   BEGIN
    O_M:=Outputmatches; {if it is then record the character}
    O_C:=Outputchar;
    Gotnum:=J;
   END;
   Read_Line_Into_Scr; {read another line into the buffer}
  END;
  Output(O_C); {output the end result}
  {depending on where the character was found, scan a number of lines on
   to the next 3 possible character positions}
  FOR J:=1 TO 15+Gotnum DO
  BEGIN
   Read_Line_Into_Scr;
  END
 UNTIL Lines<=0;

 Close(Txt);

END.
