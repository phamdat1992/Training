unit CtrlCreate;

interface
uses Windows, SysUtils, Classes, Graphics, JPEG, Forms, Controls;
const
  MaxRect = 1000;

type
  TPoints = array of TPoint;
  TInts = array of Integer;
  TRectArr = array[0..MaxRect - 1] of TRect;
  PRectArr = ^TRectArr;
  TRectList = packed array of TRect;
  TBGR = packed record
    case Boolean of
      True: (b, g, r: Byte);
      False: (c: array[0..2] of Byte);
  end;
  PBGR = ^TBGR;
  TBGRArray = packed array [0..32767] of TBGR;
  PBGRArray = ^TBGRArray;

  TColorValues = packed array [0..3] of Byte;

  TGraphicMode = (gmNone, gmBitmap, gmIcon, gmMetaFile, gmJPEGImage);
  TGlyphChangeEvent = TNotifyEvent;
  TGlyphPicture = class
  private
    FPicture: TPicture;
    FChange:TGlyphChangeEvent;
    procedure SetPicture(const Value: TPicture);
    procedure PictureChange(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    function Empty: Boolean;
    procedure Draw(Canvas: TCanvas; X, Y: Integer); overload;
    procedure Draw(Canvas: TCanvas; P: TPoint); overload;
    procedure DrawOpaque(Canvas: TCanvas; X, Y: Integer); overload;
    procedure DrawOpaque(Canvas: TCanvas; P: TPoint); overload;
    procedure StretchDraw(Canvas: TCanvas; R: TRect); overload;
    procedure StretchDraw(Canvas: TCanvas; X1, Y1, X2, Y2: Integer); overload;
    procedure StretchDrawOpaque(Canvas: TCanvas; R: TRect); overload;
    procedure StretchDrawOpaque(Canvas: TCanvas; X1, Y1, X2, Y2: Integer); overload;
    function Palette: HPALETTE;
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    property Picture: TPicture read FPicture Write SetPicture;
    property OnChange: TGlyphChangeEvent read FChange write FChange;
  end;

  TMoveControl = class (TObject)
  private
    MDown: Boolean;
    LastCorner, LastP: TPoint;
  public
    constructor Create;
    procedure M_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
    procedure M_Up(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
    procedure M_Move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  end;

procedure Line(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Color: TColor);
procedure Frame(Canvas:TCanvas; x1, y1, x2, y2: Integer; c1, c2: TColor); overload;
procedure Frame(Canvas: TCanvas; Rect: TRect; c1, c2: TColor); overload;
procedure DoubleFrame(Canvas:TCanvas; x1, y1, x2, y2: Integer; c1, c2, c3, c4: TColor);

procedure PaintControlBorderDown(Control: TWinControl);
procedure PaintControlBorderUp(Control: TWinControl);
procedure PaintControlFace(Control: TWinControl);

function LightenColor(c: Cardinal; x: Single): TColor;
function GradientColor(c1, c2: Cardinal; x: Single): TColor;
function GradientFill(Width, Height: Integer; color1, color2: TColor; LR: Boolean): TBitmap;
procedure DrawGradientFill(Canvas: TCanvas; X, Y, Width, Height: Integer; color1, color2: TColor; LR: Boolean);

function RealCap(s: string): string;
procedure DrawStr(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; Disable: Boolean = False);
procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; ShortcutColor: TColor; Disable: Boolean = False); overload;
procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; TextColor, ShortCutColor: TColor; Disable: Boolean = False); overload;
procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; Font: TFont; TextColor, ShortCutColor: TColor; Disable: Boolean = False); overload;


function GetShapeBorder(bmp: TBitmap): TPoints;
function IsConnectedShape(bmp: TBitmap; Color: TColor; Tolerance: Integer): Boolean;
function SysPalEntries: Integer;
function PictureToBitmap(Picture: TPicture): TBitmap;
function CreateComplicatedRgn(RgnData: PRgnData): HRGN;
function BitmapToRectList(Bmp: TBitmap; TransColor: TColor; Tolerance: Byte): TRectList;
function BitmapToRgn(Bmp: TBitmap; TransColor: TColor; Tolerance: Byte): HRgn;
function PictureToRgn(Picture: TPicture): HRgn;
function RgnToBitmap(Rgn: HRgn): TBitmap;
function CopyRgn(Rgn: HRgn): HRgn;
function MoveRgn(Rgn: HRgn; dx, dy: Integer): HRgn;
function InflateRgn(Rgn: HRgn; dx, dy: Integer): HRgn;
procedure SaveRgnToStream(Stream: TStream; Rgn: HRgn);
function LoadRgnFromStream(Stream: TStream): HRgn;
function GetChildrenRgn(Parent: TWinControl): HRGN;
procedure RectFit(R: TRect; Control: TControl);
procedure ShowModalForm(const F: TForm);
procedure FormByCursor(const F: TForm);

implementation
uses FUtils, Math, MyConst;

{TGlyphPicture}
constructor TGlyphPicture.Create;
begin
    FPicture := TPicture.create;
    FPicture.OnChange := PictureChange;
end;

destructor TGlyphPicture.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure TGlyphPicture.Draw(Canvas: TCanvas; P: TPoint);
begin
  Draw(Canvas, P.X, P.Y);
end;

procedure TGlyphPicture.Draw(Canvas: TCanvas; X, Y: Integer);
var
  FPal, OldPal: HPalette;
  DC: HDC;
begin
  if not Empty then
    begin
      if FPicture.Graphic is TBitmap then
        with FPicture.Graphic as TBitmap do
          begin
            Transparent := True;
            TransparentMode := tmAuto;
          end;
      DC := Canvas.Handle;
      FPal := CopyPalette(Fpicture.Graphic.Palette);
      OldPal := SelectPalette(DC, FPal, False);
      RealizePalette(DC);
      Canvas.Draw(X, Y, FPicture.Graphic);
      SelectPalette(DC, OldPal, False);
      DeleteObject(FPal);
    end;
end;

procedure TGlyphPicture.DrawOpaque(Canvas: TCanvas; P: TPoint);
begin
  DrawOpaque(Canvas, P.X, P.Y);
end;

procedure TGlyphPicture.DrawOpaque(Canvas: TCanvas; X, Y: Integer);
var
  FPal, OldPal: HPalette;
  DC: HDC;
begin
  if not Empty then
    begin
      if FPicture.Graphic is TBitmap then
        (FPicture.Graphic as TBitmap).Transparent := False;
      if FPicture.Graphic.Palette <> 0 then
        begin
          DC := Canvas.Handle;
          FPal := CopyPalette(Fpicture.Graphic.Palette);
          OldPal := SelectPalette(DC, FPal, False);
          RealizePalette(DC);
          SelectPalette(DC, OldPal, False);
          DeleteObject(FPal);
        end;
      Canvas.Draw(X, Y, FPicture.Graphic);
    end;
end;

function TGlyphPicture.Empty: Boolean;
begin
  Result := not Assigned(FPicture.Graphic) or FPicture.Graphic.Empty;
end;

procedure TGlyphPicture.LoadFromStream(Stream: TStream);
type
  TGr = class of TGraphic;
var
  MStream: TMemoryStream;
  GraphicMode: TGraphicMode;
  Gr: TGr;
  G: TGraphic;
begin
  if not Empty then
    FPicture.Graphic := Nil;
  Stream.Read(GraphicMode, SizeOf(GraphicMode));
  if GraphicMode = gmNone then Exit;
  case GraphicMode of
    gmBitmap: Gr := TBitmap;
    gmIcon: Gr := TIcon;
    gmMetaFile: Gr := TMetaFile;
    else Gr := TJPEGImage;
  end;
  MStream := TMemoryStream.Create;
  SplitStream(MStream, Stream);
  MStream.Seek(0, 0);
  MStream.Seek(0, soFromBeginning);
  G := GR.Create;
  G.LoadFromStream(MStream);
  MStream.Free;
  FPicture.Assign(G);
  G.Free;
end;

function TGlyphPicture.Palette: HPALETTE;
begin
  if Empty then Result := 0
  else Result := FPicture.Graphic.Palette;
end;

procedure TGlyphPicture.PictureChange(sender:TObject);
begin
  if assigned(FChange) then FChange(self);
end;

procedure TGlyphPicture.SaveToStream(Stream: TStream);
var
  GraphicMode: TGraphicMode;
  MStream: TMemoryStream;
  TempPic: TPicture;
  TempBmp: TBitmap;
begin
  if Empty then GraphicMode := gmNone
  else
    with FPicture do
      if Graphic is TBitmap then GraphicMode := gmBitmap
      else
        if Graphic is TIcon then GraphicMode := gmIcon
        else
          if Graphic is TMetafile then GraphicMode := gmMetafile
          else
            if Graphic is TJPEGImage then
              GraphicMode := gmJPEGImage
            else
              GraphicMode := gmNone;
  TempPic := TPicture.Create;
  if not Empty and (GraphicMode = gmNone) then //Convert to Bitmap
    begin
      TempBmp := PictureToBitmap(FPicture);
      TempPic.Assign(TempBmp);
      GraphicMode := gmBitmap;
      TempBmp.Free;
    end
  else
    TempPic.Assign(FPicture); //Assign Directly
  Stream.Write(GraphicMode, SizeOf(GraphicMode));
  if GraphicMode <> gmNone then
    begin
      MStream := TMemoryStream.Create;
      TempPic.Graphic.SaveToStream(MStream);
      MergeStream(Stream, MStream);
      MStream.Free;
    end;
  TempPic.Free;
end;

procedure TGlyphPicture.SetPicture(const Value:TPicture);
begin
  FPicture.Assign(value);
end;

procedure TGlyphPicture.StretchDraw(Canvas: TCanvas; R: TRect);
var
  FPal, OldPal: HPalette;
  DC: HDC;
begin
  if not Empty then
    begin
      if FPicture.Graphic is TBitmap then
        begin
          (FPicture.Graphic as TBitmap).Transparent := True;
          (FPicture.Graphic as TBitmap).TransparentMode := tmAuto;
        end;
      DC := Canvas.Handle;
      FPal := CopyPalette(Fpicture.Graphic.Palette);
      OldPal := SelectPalette(DC, FPal, False);
      RealizePalette(DC);
      Canvas.StretchDraw(R, FPicture.Graphic);
      SelectPalette(DC, OldPal, False);
      DeleteObject(FPal);
    end;
end;

procedure TGlyphPicture.StretchDraw(Canvas: TCanvas; X1, Y1, X2, Y2: Integer);
begin
  StretchDraw(Canvas, Rect(X1, Y1, X2 + 1, Y2 + 1));
end;

procedure TGlyphPicture.StretchDrawOpaque(Canvas: TCanvas; R: TRect);
var
  FPal, OldPal: HPalette;
  DC: HDC;
begin
  if not Empty then
    begin
      if FPicture.Graphic is TBitmap then
          (FPicture.Graphic as TBitmap).Transparent := False;
      if FPicture.Graphic.Palette <> 0 then
        begin
          DC := Canvas.Handle;
          FPal := CopyPalette(Fpicture.Graphic.Palette);
          OldPal := SelectPalette(DC, FPal, False);
          RealizePalette(DC);
          SelectPalette(DC, OldPal, False);
          DeleteObject(FPal);
        end;
      Canvas.StretchDraw(R, FPicture.Graphic);
    end;
end;

procedure TGlyphPicture.StretchDrawOpaque(Canvas: TCanvas; X1, Y1, X2, Y2: Integer);
begin
  StretchDrawOpaque(Canvas, Rect(X1, Y1, X2 + 1, Y2 + 1));
end;

{ TMoveControl }

constructor TMoveControl.Create;
begin
  MDown := False;
end;

procedure TMoveControl.M_Down(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    with Sender as TControl do
      begin
        LastCorner := Point(Left, Top);
        GetCursorPos(LastP);
        MDown := True;
      end;
end;

procedure TMoveControl.M_Move(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
var
  P: TPoint;
begin
  if MDown then
    with Sender as TControl do
      begin
        GetCursorPos(P);
        Left := LastCorner.X + P.X - LastP.X;
        Top := LastCorner.Y + P. Y - LastP.Y;
      end;
end;

procedure TMoveControl.M_Up(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
  MDown := False;
end;

procedure Line(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Color: TColor);
begin
  Canvas.Pen.Color := Color;
  Canvas.MoveTo(X1, Y1);
  Canvas.LineTo(X2, Y2);
  Canvas.Pixels[X2, Y2] := Color;
end;

procedure Frame(Canvas:TCanvas; x1, y1, x2, y2: Integer; c1,c2: TColor); register; overload;
begin
  Canvas.Pen.Mode := pmCopy;
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(x1, y2);

  Canvas.Pen.Color := c2;
  Canvas.LineTo(x2, y2);
  Canvas.LineTo(x2, y1);

  Canvas.Pen.Color := c1;
  Canvas.LineTo(x1, y1);
  Canvas.LineTo(x1, y2);
end;

procedure Frame(Canvas: TCanvas; Rect: TRect; c1, c2: TColor); register; overload;
begin
  Frame(Canvas, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, c1, c2);
end;

procedure DoubleFrame(Canvas:TCanvas; x1, y1, x2, y2: Integer; c1, c2, c3, c4: TColor);
begin
  Canvas.Pen.Mode := pmCopy;
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(x1, y2);

  Canvas.Pen.Color := c2;
  Canvas.LineTo(x2, y2);
  Canvas.LineTo(x2, y1);

  Canvas.Pen.Color := c1;
  Canvas.LineTo(x1, y1);
  Canvas.LineTo(x1, y2);

  Inc(x1); Inc(y1); Dec(x2); Dec(y2);

  Canvas.MoveTo(x1, y2);

  Canvas.Pen.Color := c4;
  Canvas.LineTo(x2, y2);
  Canvas.LineTo(x2, y1);

  Canvas.Pen.Color := c3;
  Canvas.LineTo(x1, y1);
  Canvas.LineTo(x1, y2);
end;

procedure PaintControlBorderDown(Control: TWinControl);
var
  Canvas: TCanvas;
  dc: HDC;
begin
  Canvas := TCanvas.Create;
  dc := GetWindowDC(Control.Handle);
  try
    Canvas.Handle := dc;
    Canvas.Lock;
    DoubleFrame(Canvas, 0, 0, Control.Width - 1, Control.Height - 1,
      GradientColor(cShadow, cFace, 0.5), GradientColor(cLight, cFace, 0.5), cShadow, cLight);
  finally
    Canvas.Unlock;
    Canvas.Handle := 0;
    Canvas.Free;
    ReleaseDC(Control.Handle, dc);
  end;
end;

procedure PaintControlBorderUp(Control: TWinControl);
var
  Canvas: TCanvas;
  dc: HDC;
begin
  Canvas := TCanvas.Create;
  dc := GetWindowDC(Control.Handle);
  try
    Canvas.Handle := dc;
    Canvas.Lock;
    Canvas.Brush.Color := clRed;
    DoubleFrame(Canvas, 0, 0, Control.Width - 1, Control.Height - 1, cLight, cShadow,
      GradientColor(cLight, cFace, 0.5), GradientColor(cShadow, cFace, 0.5)) ;
  finally
    Canvas.Unlock;
    Canvas.Handle := 0;
    Canvas.Free;
    ReleaseDC(Control.Handle, dc);
  end;
end;

procedure PaintControlFace(Control: TWinControl);
var
  Canvas: TCanvas;
  dc: HDC;
begin
  Canvas := TCanvas.Create;
  dc := GetWindowDC(Control.Handle);
  try
    Canvas.Handle := dc;
    Canvas.Lock;
    Canvas.Brush.Color := cFace;
    Canvas.FillRect(Rect(0, 0, Control.Width, Control.Height));
    Frame(Canvas, 0, 0, Control.Width - 1, Control.Height - 1, cLight, cShadow);
  finally
    Canvas.Unlock;
    Canvas.Handle := 0;
    Canvas.Free;
    ReleaseDC(Control.Handle, dc);
  end;
end;

function LightenColor(c: Cardinal; x: Single): TColor;
var
  a: ^TColorValues;
  i: Integer;
begin
  a := @c;
  for i := 0 to 2 do
    a^[i] := Min(255, Round(a^[i] * x));
  Result := c;
end;

function GradientBGR(c1, c2: Cardinal; x: Single): TBGR;
var
  a, b: ^TColorValues;
  i: Integer;
begin
  a := @c1; b := @c2;
  for i := 0 to 2 do
    Result.c[i] := Round(a^[2 - i] * (1 - x) + b^[2 - i] * x);
end;

function GradientColor(c1, c2: Cardinal; x: Single): TColor;
var
  a, b, c: ^TColorValues;
  i: Integer;
begin
  a := @c1; b := @c2; c := @Result;
  c^[3] := 0;
  for i := 0 to 2 do
    c^[i] := Round(a[i] * (1 - x) + b[i] * x);
end;

function GradientFill(Width, Height: Integer; color1, color2: TColor; LR: Boolean): TBitmap;
var
  p: PBGRArray;
  i, j: Integer;
  Material: TBGR;
begin
  Result := TBitmap.Create;
  if (Height <= 1) or (Width <= 1) then Exit;
  Result.Width := Width;
  Result.Height := Height;
  Result.HandleType := bmDIB;
  Result.PixelFormat := pf24bit;
  color1 := ColorToRGB(color1);
  color2 := ColorToRgb(color2);
  if LR then
    for j := 0 to Height - 1 do
      begin
        p := Result.ScanLine[j];
        for i := 0 to Width - 1 do
          p^[i] := GradientBGR(color1, color2, i / (Width - 1));
      end
  else
    for j := 0 to Height - 1 do
      begin
        p := Result.ScanLine[j];
        Material := GradientBGR(color1, color2, j / (Height - 1));
        for i := 0 to Width - 1 do
          p^[i] := Material;
      end;
end;

procedure DrawGradientFill(Canvas: TCanvas; X, Y, Width, Height: Integer; color1, color2: TColor; LR: Boolean);
var
  tmp: TBitmap;
begin
  tmp := GradientFill(Width, Height, color1, color2, LR);
  Canvas.Draw(X, Y, tmp);
  tmp.Free;
end;

function RealCap(s: string): string;
var
  p: Integer;
begin
  Result := s;
  p := Pos('&', Result);
  if p <> 0 then
    Delete(Result, p, 1);
end;

procedure DrawStr(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; Disable: Boolean = False);
var
  Size: TSize;
begin
  Size := Canvas.TextExtent(S);
  case Aln and $F of
    1: X := X - Size.cX shr 1;
    2: X := X - Size.cX;
  end;
  case Aln and $F0 of
    $10: Y := Y - Size.cY shr 1;
    $20: Y := Y - Size.cY;
  end;
  SetTextAlign(Canvas.Handle, TA_LEFT or TA_TOP);
  Canvas.TextOut(X, Y, s);
end;

procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; ShortcutColor: TColor; Disable: Boolean = False); overload;
var
  Size: TSize;
  ShortCutP: Integer;
begin
  ShortCutP := Pos('&', S);
  if ShortCutP <> 0 then Delete(S, ShortCutP, 1);
  if ShortCutP > Length(S) then ShortCutP := 0;
  Size := Canvas.TextExtent(S);
  case Aln and $F of
    1: X := X - Size.cX shr 1;
    2: X := X - Size.cX;
  end;
  case Aln and $F0 of
    $10: Y := Y - Size.cY shr 1;
    $20: Y := Y - Size.cY;
  end;
  SetTextAlign(Canvas.Handle, TA_LEFT or TA_TOP);
  if Disable then
    begin
      Canvas.Font.Color := LightenColor(Canvas.Font.Color, 1.5);
      Canvas.TextOut(X + 1, Y + 1, s);
      Canvas.Font.Color := LightenColor(Canvas.Font.Color, 0.5);
      Canvas.TextOut(X, Y, S);
    end;
  Canvas.TextOut(X, Y, s);
  if ShortCutP <> 0 then
    begin
      Canvas.Font.Color := ShortcutColor;
      X := X + Canvas.TextWidth(Copy(S, 1, ShortCutP - 1));
      Canvas.TextOut(X, Y, S[ShortCutP]);
    end;
end;

procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; TextColor, ShortCutColor: TColor; Disable: Boolean = False); overload;
begin
  Canvas.Font.Color := TextColor;
  DrawCap(Canvas, X, Y, S, Aln, ShortcutColor, Disable);
end;

procedure DrawCap(Canvas: TCanvas; X, Y: Integer; S: string; Aln: Byte; Font: TFont; TextColor, ShortCutColor: TColor; Disable: Boolean = False); overload;
begin
  Canvas.Font := Font;
  DrawCap(Canvas, X, Y, S, Aln, TextColor, ShortcutColor, Disable);
end;

function SysPalEntries: Integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetDeviceCaps(DC, SIZEPALETTE);
  ReleaseDC(0, DC);
end;

function PictureToBitmap(Picture: TPicture): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf24bit;
  Result.HandleType := bmDIB;
  if (Picture.Graphic = nil) or (Picture.Graphic.Empty) then Exit;
  Result.Width := Picture.Width; Result.Height := Picture.Height;
  Result.Canvas.Draw(0, 0, Picture.Graphic);
end;

function CreateComplicatedRgn(RgnData: PRgnData): HRGN;
var
  TmpData: PRgnData;
  i: Integer;
  P, PTmp: PRectArr;

  procedure AddNewRgn;
  var
    tmp: HRgn;
  begin
    if Result = 0 then
      Result := ExtCreateRegion(nil, SizeOf(RgnDataHeader) +
                    TmpData^.rdh.nCount * SizeOf(TRect), TmpData^)
    else
      begin
        tmp := ExtCreateRegion(nil, SizeOf(RgnDataHeader) +
                    TmpData^.rdh.nCount * SizeOf(TRect), TmpData^);
        CombineRgn(Result, Result, tmp, RGN_OR);
        DeleteObject(tmp);
      end;
  end;

begin
  P := @RgnData.Buffer;
  GetMem(TmpData, SizeOf(RgnDataHeader) + maxRect * SizeOf(TRect) + 4);
  with TmpData^ do
    begin
      rdh :=RgnData.rdh;
      rdh.nCount := 0;
      PTmp := @TmpData^.Buffer;
    end;
  Result := 0;
  for i := 0 to RgnData.rdh.nCount - 1 do
    begin
      PTmp^[TmpData^.rdh.nCount] := P^[i];
      Inc(TmpData^.rdh.nCount);
      if TmpData^.rdh.nCount = maxRect then
        begin
          AddNewRgn;
          TmpData^.rdh.nCount := 0;
        end;
    end;
  if TmpData^.rdh.nCount <> 0 then AddNewRgn;
  FreeMem(TmpData);
end;

function BitmapToRectList(Bmp: TBitmap; TransColor: TColor; Tolerance: Byte): TRectList;
var
  Tmp: TBitmap;
  p: PByteArray;
  HRed, HBlue, HGreen, LRed, LBlue, LGreen: Byte;
  i, j, size, w, h, nRect, Area: Integer;
  Map: array of array of Boolean;
  RGB: PBGR;

  function IsTransparent(const RGB: TBGR): Boolean;
  begin
    Result := InRange(RGB.b, LBlue, HBlue) and
              InRange(RGB.g, LGreen, HGreen) and
              InRange(RGB.r, LRed, HRed);
  end;

  function Pure(x1, y1, x2, y2: Integer): Boolean;
  var
    i, j: Integer;
  begin
    for i := x1 to x2 do
      for j := y1 to y2 do
        if (i > w - 1) or (j > h - 1) or Map[i, j] then
          begin
            Result := False;
            Exit;
          end;
    Result := True;
  end;

  procedure Fill(x1, y1, x2, y2: Integer);
  var
    i, j: Integer;
  begin
    for i := x1 to x2 do
      for j := y1 to y2 do
        Map[i, j] := True;
    Area := Area - (x2 - x1 + 1) * (y2 - y1 + 1);
  end;

  procedure Add1(x1, y1, x2, y2: Integer);
  begin
    if nRect = Length(Result) then
      SetLength(Result, Length(Result) + 1024);
    SetRect(Result[nRect], x1, y1, x2, y2);
    Inc(nRect);
  end;

begin
  if Bmp.Empty then
    begin
      Result := nil;
      Exit;
    end;
  TransColor := ColorToRGB(TransColor);
  LRed := Max(0, GetRValue(TransColor) - Tolerance);
  LGreen := Max(0, GetGValue(TransColor) - Tolerance);
  LBlue := Max(0, GetBValue(TransColor) - Tolerance);
  HRed := Min($FF, LRed + Tolerance shl 1);
  HGreen := Min($FF, LGreen + Tolerance shl 1);
  HBlue := Min($FF, LBlue + Tolerance shl 1);
  w := Bmp.Width; h := Bmp.Height;
  //Create Map
  Tmp := TBitmap.Create;
  Tmp.HandleType := bmDIB;
  Tmp.Assign(Bmp);
  Tmp.PixelFormat := pf24bit;
  SetLength(Map, w);
  for i := 0 to w - 1 do
    SetLength(Map[i], h);
  Area := w * h;
  for j := 0 to h - 1 do
    begin
      p := Tmp.ScanLine[j];
      for i := 0 to w - 1 do
        begin
          RGB := @p^[i * 3];
          Map[i, j] := IsTransparent(RGB^);
          if Map[i, j] then Dec(Area);
        end;
    end;
  Tmp.Free;
  //Create Rect List
  Result := nil;
  nRect := 0;
  Size := 1;
  while (Size < w) and (Size < h) do Size := Size shl 1;
  repeat
    for i := 0 to w div Size do
      for j := 0 to h div Size do
        if Pure(i * Size, j * Size, i * Size + Size - 1, j * Size + Size - 1) then
          begin
            Add1(i * Size, j * Size, i * Size + Size, j * Size + Size);
            Fill(i * Size, j * Size, i * Size + Size - 1, j * Size + Size - 1);
          end;
    Size := Size shr 1;
  until (Size = 0) or (area = 0);
  Add1(0, 0, w, h);
  SetLength(Result, nRect);
  for i := 0 to High(Map) do Map[i] := nil;
  Map := nil;
end;

function RectListToRgn(RectList: TRectList): HRgn;
var
  RgnData: PRgnData;
begin
  GetMem(RgnData, SizeOf(RgnDataHeader) + 8 + Length(RectList) * SizeOf(TRect));
  with RgnData^ do
    begin
      rdh.dwSize := SizeOf(RgnDataHeader);
      rdh.iType := RDH_RECTANGLES;
      rdh.nRgnSize := 0;
      rdh.nCount := Length(RectList) - 1;
      rdh.rcBound := RectList[High(RectList)];
    end;
  Move(RectList[0], RgnData^.Buffer, (Length(RectList) - 1) * SizeOf(TRect));
  Result := CreateComplicatedRgn(RgnData);
end;

function BitmapToRgn(Bmp: TBitmap; TransColor: TColor; Tolerance: Byte): HRGN;
var
  RectList: TRectList;
begin
  RectList := BitmapToRectList(bmp, TransColor, Tolerance);
  Result := RectListToRgn(RectList);
  RectList := nil;
end;

function PictureToRgn(Picture: TPicture): HRgn;
var
  Tmp: TBitmap;
begin
  Tmp := PictureToBitmap(Picture);
  Result := BitmapToRgn(Tmp, Tmp.Canvas.Pixels[0, Tmp.Height - 1], 4);
  Tmp.Free;
end;

function RgnToBitmap(Rgn: HRgn): TBitmap;
var
  R1, R2: TRect;
  Bmp: TBitmap;
begin
  GetRgnBox(Rgn, R1); R2 := R1;
  OffsetRect(R2, -R1.Left, -R1.Top);
  Bmp := TBitmap.Create;
  Bmp.Width := R1.Right;
  Bmp.Height := R1.Bottom;
  Bmp.HandleType := bmDIB;
  Bmp.PixelFormat := pf24bit;
  Bmp.Canvas.Brush.Color := $00000000;
  Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
  Bmp.Canvas.Brush.Color := $00000000;
  PaintRgn(Bmp.Canvas.Handle, Rgn);
  Result := TBitmap.Create;
  Result.Width := R2.Right;
  Result.Height := R2.Bottom;
  Result.Canvas.CopyRect(R2, Bmp.Canvas, R1);
  Bmp.Free;
end;

function CopyRgn(Rgn: HRgn): HRgn;
var
  RgnData: PRgnData;
  Size: LongInt;
begin
  RgnData := nil;
  Size := GetRegionData(Rgn, 0, RgnData);
  GetMem(RgnData, Size);
  GetRegionData(Rgn, Size, RgnData);
  Result := CreateComplicatedRgn(RgnData);
  FreeMem(RgnData);
end;

function InflateRgn(Rgn: HRgn; dx, dy: Integer): HRgn;
var
  RgnData: PRgnData;
  Size: LongInt;
  i: Integer;
  P: PRectArr;
begin
  RgnData := Nil;
  Size := GetRegionData(Rgn, 0, RgnData);
  GetMem(RgnData, Size);
  GetRegionData(Rgn, Size, RgnData);
  with RgnData^.rdh do InflateRect(rcBound, dx, dy);
  P := @RgnData^.Buffer;
  for i := 0 to RgnData.rdh.nCount - 1 do
    InflateRect(P^[i], dx, dy);
  Result := CreateComplicatedRgn(RgnData);
  FreeMem(RgnData);
end;

function MoveRgn(Rgn: HRgn; dx, dy: Integer): HRgn;
var
  RgnData: PRgnData;
  Size: LongInt;
  i: Integer;
  P: PRectArr;
begin
  RgnData := Nil;
  Size := GetRegionData(Rgn, 0, RgnData);
  GetMem(RgnData, Size);
  GetRegionData(Rgn, Size, RgnData);
  with RgnData^.rdh do InflateRect(rcBound, dx, dy);
  P := @RgnData^.Buffer;
  for i := 0 to RgnData.rdh.nCount - 1 do
    OffsetRect(P^[i], dx, dy);
  Result := CreateComplicatedRgn(RgnData);
  FreeMem(RgnData);
end;

procedure SaveRgnToStream(Stream: TStream; Rgn: HRgn);
var
  RgnData: PRgnData;
  Size: LongInt;
begin
  if Rgn = 0 then Exit;
  RgnData := nil;
  Size := GetRegionData(Rgn, 0, RgnData);
  GetMem(RgnData, Size);
  GetRegionData(Rgn, Size, RgnData);
  Stream.Write(Size, SizeOf(Size));
  Stream.Write(RgnData^, Size);
  FreeMem(RgnData);
end;

function LoadRgnFromStream(Stream: TStream): HRgn;
var
  RgnData: PRgnData;
  Size: LongInt;
begin
  if Stream.Position >= Stream.Size then
    begin
      Result := 0;
      Exit;
    end;
  Stream.Read(Size, SizeOf(Size));
  GetMem(RgnData, Size);
  Stream.Read(RgnData^, Size);
  Result := CreateComplicatedRgn(RgnData);
  FreeMem(RgnData);
end;

function GetChildrenRgn(Parent: TWinControl): HRGN;
var
  tmp: HRgn;
  res, i: Integer;
begin
  Result := CreateRectRgn(0, 0, 0, 0);
  with Parent do
    for i := 0 to ControlCount - 1 do
      if Controls[i].Visible then
        if Controls[i] is TWinControl then
          with Controls[i] as TWinControl do
            begin
              tmp := CreateRectRgn(0, 0, 0, 0);
              res := GetWindowRgn(Handle, tmp);
              if res = Error then
                with BoundsRect do
                  begin
                    DeleteObject(tmp);
                    tmp := CreateRectRgn(Left, Top, Right, Bottom);
                  end
              else
                OffsetRgn(tmp, Left, Top);
              CombineRgn(Result, Result, tmp, RGN_OR);
              DeleteObject(tmp);
            end
        else
          with Controls[i] do
            begin
              with BoundsRect do tmp := CreateRectRgn(Left, Top, Right, Bottom);
              CombineRgn(Result, Result, tmp, RGN_OR);
              DeleteObject(tmp);
            end;
end;

function IsConnectedShape(bmp: TBitmap; Color: TColor; Tolerance: Integer): Boolean;
label Done;
const
  dx: array[0..7] of Integer = (-1, 1, 0, 0, 1, -1, 1, -1);
  dy: array[0..7] of Integer = (0, 0, -1, 1, 1, 1, -1, -1);
var
  tmp: TBitmap;
  d, i, j, w, h, HR, HG, HB, LR, LG, LB, R, G, B: Integer;
  map: array of array of Integer;
  p: PBGRArray;
  Stack: TPoints;
  nStack: Integer;
  pp, qq: TPoint;
  CountWhite, CountBlack, nPop: Integer;

  procedure Push(const p: TPoint);
  begin
    if nStack = Length(Stack) then
      SetLength(Stack, Length(Stack) + 1024);
    Stack[nStack] := p;
    Inc(nStack);
  end;

  function Pop: TPoint;
  begin
    Dec(nStack);
    Result := Stack[nStack];
  end;

  function IsInvalid(const p: TPoint): Boolean;
  begin
    Result := InRange(p.X, 0, h - 1) and Inrange(p.Y, 0, w - 1);
  end;

begin
  Color := ColorToRGB(Color);
  R := GetRValue(Color); HR := Min(R + Tolerance, 255); LR := Max(R - Tolerance, 0);
  G := GetGValue(Color); HG := Min(G + Tolerance, 255); LG := Max(G - Tolerance, 0);
  B := GetBValue(Color); HB := Min(B + Tolerance, 255); LB := Max(B - Tolerance, 0);
  w := bmp.Width; h := bmp.Height;
  tmp := TBitmap.Create;
  tmp.Assign(bmp);
  tmp.HandleType := bmDIB;
  tmp.PixelFormat := pf24bit;
  SetLength(Map, h);
  for i:= 0 to High(Map) do SetLength(Map[i], w);
  CountWhite := 0;
  for i := 0 to h - 1 do
    begin
      p := tmp.Scanline[i];
      for j := 0 to w - 1 do
        if InRange(p[j].b, LB, HB) and
           InRange(p[j].g, LG, HG) and
           InRange(p[j].r, LR, HR) then
             begin
               Map[i, j] := 1;
               Inc(CountWhite);
               pp := Point(i, j);
             end
         else Map[i, j] := 0;
    end;
  CountBlack := w * h - CountWhite;
  tmp.Free;
  if countWhite = 0 then
    begin
      Result := True;
      goto Done;
    end;
  Stack := nil;
  nStack := 0;
  Push(pp);
  Map[pp.X, pp.Y] := 2;
  nPop := 0;
  while nStack > 0 do
    begin
      pp := Pop;
      Inc(nPop);
      for d := 0 to 7 do
        begin
          qq.x := pp.X + dx[d];
          qq.Y := pp.Y + dy[d];
          if IsInvalid(qq) and (Map[qq.x, qq.y] = 1) then
            begin
              Push(qq);
              Map[qq.x, qq.y] := 2;
            end;
        end;
    end;
  if nPop <> CountWhite then
    begin
      Result := False;
      goto Done;
    end;
  Stack := nil;
  nStack := 0;
  nPop := 0;
  for i := 0 to h - 1 do
    begin
      if Map[i, 0] = 0 then
        begin
          Push(Point(i, 0));
          Map[i, 0] := 3;
        end;
      if Map[i, w - 1] = 0 then
        begin
          Push(Point(i, w - 1));
          Map[i, w - 1] := 3;
        end;
    end;
  for j := 0 to w - 1 do
    begin
      if Map[0, j] = 0 then
        begin
          Push(Point(0, j));
          Map[0, j] := 3;
        end;
      if Map[h - 1, j] = 0 then
        begin
          Push(Point(h - 1, j));
          Map[h - 1, j] := 3;
        end;
    end;
  while nStack > 0 do
    begin
      pp := Pop;
      Inc(nPop);
      for d := 0 to 3 do
        begin
          qq.x := pp.X + dx[d];
          qq.Y := pp.Y + dy[d];
          if IsInvalid(qq) and (Map[qq.X, qq.Y] = 0) then
            begin
              Push(qq);
              Map[qq.x, qq.y] := 3;
            end;
        end;
    end;
  Result := nPop = CountBlack;
Done:
  Stack := nil;
  for i := 0 to High(Map) do Map[i] := nil;
  Map := nil;

end;

function GetShapeBorder(bmp: TBitmap): TPoints;
label done;
const
  dx: array[0..7] of Integer = (-1, -1, 0, 1, 1, 1, 0, -1);
  dy: array[0..7] of Integer = (0, -1, -1, -1, 0, 1, 1, 1);
  dir: array[-1..1, -1..1] of Integer = (
  (1, 2, 3),
  (0, 9, 4),
  (7, 6, 5)
  );
var
  temp: TBitmap;
  map: array of array of Boolean;
  n, d, i, j, w, h, x, y, x1, y1, x2, y2, sx, sy, count: Integer;
  p: PByteArray;
  found: Boolean;
  res: TPoints;
  dirlist: TInts;

  procedure Add1(pt: TPoint);
  begin
    Inc(count);
    if count > Length(Res) then
      SetLength(Res, count + 128);
    Res[count - 1] := pt;
  end;

  function Online(p1, p2, p3: TPoint): Boolean;
  begin
    Result := (p3.x - p1.x) * (p2.y - p1.y) = (p3.y - p1.y) * (p2.x - p1.x);
  end;

begin
  temp := TBitmap.Create;
  temp.Assign(bmp);
  temp.HandleType := bmDIB;
  temp.PixelFormat := pf24bit;
  w := bmp.Width; h := bmp.Height;
  SetLength(map, w);
  for i := 0 to w - 1 do SetLength(map[i], h);
  for j := 0 to h - 1 do
    begin
      p := temp.ScanLine[j];
      for i := 0 to w - 1 do
        map[i, j] := p[i * 3] * 0.1646 + p[i * 3 + 1] * 0.5244 + p[i * 3 + 2] * 0.3110 >= 128;
    end;
  temp.Free;
  count := 0;
  Res := nil;
  found := False;
  sx := 0; sy := 0;
  for y := 0 to h - 1 do
    for x := 0 to w - 1 do
      if map[x, y] then
        begin
          sx := x; sy := y;
          found := True;
          goto done;
        end;
done:
  if found then
    begin
      x1 := sx; y1 := sy;
      d := 0;
      repeat
        Add1(Point(x1, y1));
        x2 := sx; y2 := sy;
        for i := d to d + 7 do
          begin
            x := x1 + dx[i mod 8]; y := y1 + dy[i mod 8];
            if (x >= 0) and (x < w) and (y >= 0) and (y < h) and map[x, y] then
              begin
                x2 := x; y2 := y;
                d := (i + 5) mod 8;
                Break;
              end;
          end;
       x1 := x2; y1 := y2;
      until (x2 = sx) and (y2 = sy);
      SetLength(Res, count);
    end;
  for i := 0 to w - 1 do map[i] := nil;
  map := nil;
  //Reduce
  if Length(res) < 3 then
    begin
      Result := Copy(res, 0, Length(res));
      res := nil;
      Exit;
    end;
  SetLength(dirlist, Length(res));
  for i := 0 to High(res) do
    begin
      j := (i - 1 + Length(res)) mod Length(res);
      dirlist[i] := Dir[res[i].X - res[j].X, res[i].Y - res[j].Y];
    end;
  n := 0;
  for i := 0 to High(res) do
    begin
      j := (i + 1) mod Length(res);
      if dirlist[i] <> dirlist[j] then Inc(n);
    end;
  SetLength(Result, n);
  n := 0;
  for i := 0 to High(res) do
    begin
      j := (i + 1) mod Length(res);
      if dirlist[i] <> dirlist[j] then
        begin
           Result[n] := res[i];
           Inc(n);
         end;
    end;
  Res := nil;
end;

procedure RectFit(R: TRect; Control: TControl);
var
  vx, vy: Integer;
  CR: TRect;
begin
  vx := 0; vy := 0;
  CR := Control.BoundsRect;
  if CR.Left < R.Left then vx := R.Left - CR.Left;
  if CR.Top < R.Top then vy := R.Top - CR.Top;
  if CR.Right > R.Right then vx := R.Right - CR.Right;
  if CR.Bottom > R.Bottom then vy := R.Bottom - CR.Bottom;
  Control.Left := Control.Left + vx;
  Control.Top := Control.Top + vy;
end;

procedure FormByCursor(const F: TForm);
var
  P: TPoint;
begin
  GetCursorPos(P);
  F.Left := P.X - F.Width div 2;
  F.Top := P.Y - F.Height div 2;
  RectFit(Rect(0, 0, Screen.Width - 1, Screen.Height - 1), F);
end;

procedure ShowModalForm(const F: TForm);
begin
  FormByCursor(F);
  F.ShowModal;
end;

end.

