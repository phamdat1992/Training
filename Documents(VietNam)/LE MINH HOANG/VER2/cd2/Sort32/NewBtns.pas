unit NewBtns;

interface

uses
  Forms, Windows, SysUtils, Classes, Controls, Graphics, Messages, MyConst, MyCtrls;

type
  TNewBtnBitmapPosition = (nbbpLeft, nbbpRight, nbbpTop, nbbpBottom);
  TNewBtnState = (nbsUp, nbsDown, nbsUpHighLight, nbsDownHighLight);

  TNewBtn = class(TNewCustomButton)
  private
    { Private declarations }
    FDefault, FCancel, FActive, FAllowDown: Boolean;
    FModalResult: TModalResult;
    UpBmp, DownBmp, UpBmp2, DownBmp2, DisableBmp: TBitmap;
    FState: TNewBtnState;
    FBitmap, FDisableBitmap: TBitmap;
    FSpace: Integer;
    FBitmapPos: TNewBtnBitmapPosition;
    FMoveWhenDown: Boolean;
    procedure DrawFocusArea(Canvas: TCanvas; x1, y1, x2, y2: Integer; c1, c2: TColor);
    procedure CreateButtonImage;
    procedure BitmapChange(Sender: TObject);
    procedure SetBitmap(const Value: TBitmap);
    procedure SetSpace(const Value: Integer);
    procedure SetBitmapPos(const Value: TNewBtnBitmapPosition);
    procedure SetDisableBitmap(const Value: TBitmap);
    procedure SetDefault(const Value: Boolean);
    procedure SetCancel(const Value: Boolean);
    procedure SetState(const Value: TNewBtnState);
    function StateInvert(State: TNewBtnState): TNewBtnState;
    function StateHighLight(State: TNewBtnState): TNewBtnState;
    function StateNormal(State: TNewBtnState): TNewBtnState;
    procedure SetMoveWhenDown(const Value: Boolean);
    procedure EmulateMouseClick;
  protected
    { Protected declarations }
    function ButtonGlyph(Width, Height: Integer; c1, c2: TColor; Up: Boolean): TBitmap; virtual;
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure Click; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WMKeyDown(var Message: TWMKeydown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyup); message WM_KEYUP;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMEnableChange(var message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function IsDown: Boolean;
  published
    { Published declarations }
    property MoveWhenDown: Boolean read FMoveWhenDown write SetMoveWhenDown default True;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property DisableBitmap: TBitmap read FDisableBitmap write SetDisableBitmap;
    property Space: Integer read FSpace write SetSpace default 3;
    property BitmapPos: TNewBtnBitmapPosition read FBitmapPos write SetBitmapPos default nbbpLeft;
    property Default: Boolean read FDefault write SetDefault default False;
    property Cancel: Boolean read FCancel write SetCancel default False;
    property AllowDown: Boolean read FAllowDown write FAllowDown default False;
    property State: TNewBtnState read FState write SetState default nbsUp;
    property ModalResult: TModalResult read FModalResult write FModalResult default mrNone;
  end;

  TGraphicNewBtn = class(TNewGraphicButton)
  private
    { Private declarations }
    FAllowDown: Boolean;
    UpBmp, DownBmp, UpBmp2, DownBmp2, DisableBmp: TBitmap;
    FState: TNewBtnState;
    FBitmap, FDisableBitmap: TBitmap;
    FSpace: Integer;
    FBitmapPos: TNewBtnBitmapPosition;
    procedure CreateButtonImage;
    procedure BitmapChange(Sender: TObject);
    procedure SetBitmap(const Value: TBitmap);
    procedure SetSpace(const Value: Integer);
    procedure SetBitmapPos(const Value: TNewBtnBitmapPosition);
    procedure SetDisableBitmap(const Value: TBitmap);
    procedure SetState(const Value: TNewBtnState);
    function StateInvert(State: TNewBtnState): TNewBtnState;
    function StateHighLight(State: TNewBtnState): TNewBtnState;
    function StateNormal(State: TNewBtnState): TNewBtnState;
  protected
    { Protected declarations }
    function ButtonGlyph(Width, Height: Integer; c1, c2: TColor; Up: Boolean): TBitmap; virtual;
    procedure Paint; override;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnableChange(var message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function IsDown: Boolean;
  published
    { Published declarations }
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property DisableBitmap: TBitmap read FDisableBitmap write SetDisableBitmap;
    property Space: Integer read FSpace write SetSpace default 3;
    property BitmapPos: TNewBtnBitmapPosition read FBitmapPos write SetBitmapPos default nbbpLeft;
    property AllowDown: Boolean read FAllowDown write FAllowDown default False;
    property State: TNewBtnState read FState write SetState default nbsUp;
  end;

  TFramedBtn = class(TGraphicNewBtn)
  protected
    function ButtonGlyph(Width, Height: Integer; c1, c2: TColor; Up: Boolean): TBitmap; override;
  end;

  TNewCheckBox = class(TNewCustomButton)
  private
    FCheckedBmp, FUncheckedBmp, FCheckedBmpH, FUnCheckedBmpH, FCheckedBmpD, FUnCheckedBmpD: TBitmap;
    FChecked: Boolean;
    IsMouseIn: Boolean;
    procedure SetChecked(const Value: Boolean);
  protected
    procedure CreateCheckImages; virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnableChange(var message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure WMKeyDown(var Message: TWMKeydown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyup); message WM_KEYUP;
    procedure CheckedChange; virtual;
    procedure Click; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure AutoResize;
  published
    property TabStop default True;
    property TabOrder;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Color default cFace;
  end;

  TNewRadioButton = class(TNewCheckBox)
  private
    FGroupIndex: Integer;
    procedure ResetOthers;
    procedure SetGroupIndex(const Value: Integer);
  protected
    procedure CheckedChange; override;
    procedure CreateCheckImages; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
  end;

procedure Register;

implementation
uses Math, CtrlCreate, HGeneral;

var
  CheckedA, UncheckedA, CheckedAH, UnCheckedAH, CheckedAD, UnCheckedAD: TBitmap;
  CheckedB, UncheckedB, CheckedBH, UnCheckedBH, CheckedBD, UnCheckedBD: TBitmap;

procedure Register;
begin
  RegisterComponents('Hoang', [TNewBtn, TGraphicNewBtn, TFramedBtn, TNewCheckBox, TNewRadioButton]);
end;

{ TNewBtn }

procedure TNewBtn.BitmapChange(Sender: TObject);
begin
  Invalidate;
end;

function TNewBtn.ButtonGlyph(Width, Height: Integer; c1, c2: TColor; Up: Boolean): TBitmap;
begin
  Result := TBitmap.Create;
  Result.HandleType := bmDIB;
  Result.PixelFormat := pf24bit;
  Result.Width := Width; Result.Height := Height;
  c1 := ColorToRgb(c1); c2 := ColorToRgb(c2);
  DrawGradientFill(Result.Canvas, 1, 1, Width - 2, Height - 2,
    GradientColor(c1, c2, 0.1), GradientColor(c2, c1, 0.1), False);
  if Up then
    Frame(Result.Canvas, 0, 0, Width - 1, Height - 1, c1, c2)
  else
    Frame(Result.Canvas, 0, 0, Width - 1, Height - 1, c2, c1);
  Result.Canvas.Pixels[Width - 1, 0] := GradientColor(c1, c2, 0.5);
  Result.Canvas.Pixels[0, Height - 1] := GradientColor(c1, c2, 0.5); 
end;

procedure TNewBtn.Click;
var
  Form: TCustomForm;
begin
  inherited;
  if FModalResult <> mrNone then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.ModalResult := ModalResult;
    end;
end;

procedure TNewBtn.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      EmulateMouseClick;
      Result := 1;
    end else
      inherited;
end;

procedure TNewBtn.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if  (((CharCode = VK_RETURN) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      EmulateMouseClick;
      Result := 1;
    end else
      inherited;
end;

procedure TNewBtn.CMEnableChange(var message: TMessage);
var
  p: TPoint;
begin
  inherited;
  GetCursorPos(p);
  p := ScreenToClient(p);
  if PtInRect(Rect(0, 0, Width, Height), p) then
    FState := StateHighLight(FState);
  Invalidate;
end;

procedure TNewBtn.CMFocusChanged(var Message: TCMFocusChanged);
begin
  with Message do
    if Sender is TNewBtn then
      FActive := Sender = Self
    else
      FActive := FDefault;
  Invalidate;
  inherited;
end;

procedure TNewBtn.CMFontChanged(var Message: TMessage);
begin
  inherited;
  invalidate;
end;

procedure TNewBtn.CMMouseEnter(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    begin
      FState := StateHighLight(FState);
      Invalidate;
    end;
  inherited;
end;

procedure TNewBtn.CMMouseLeave(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    begin
      State := StateNormal(FState);
      Invalidate;
    end;
  inherited;
end;

procedure TNewBtn.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TNewBtn.Create(aOwner: TComponent);
begin
  inherited;
  UpBmp := nil;
  DownBmp := nil;
  UpBmp2 := nil;
  DownBmp2 := nil;
  DisableBmp := nil;
  Width := 80; Height := 24;
  DoubleBuffered := True;
  FState := nbsUp;
  FBitmap := TBitmap.Create;
  FBitmap.OnChange := BitmapChange;
  FDisableBitmap := TBitmap.Create;
  FDisableBitmap.OnChange := BitmapChange;
  FSpace := 3;
  FBitmapPos := nbbpLeft;
  FDefault := False;
  FCancel := False;
  FAllowDown := False;
  FModalResult := mrNone;
  FMoveWhenDown := True;
end;

procedure TNewBtn.CreateButtonImage;
begin
  if UpBmp <> nil then FreeAndNil(UpBmp);
  if DownBmp <> nil then FreeAndNil(DownBmp);
  UpBmp := ButtonGlyph(Width, Height, cLight, cShadow, True);
  DownBmp := ButtonGlyph(Width, Height, cLight, cShadow, False);
  if UpBmp2 <> nil then FreeAndNil(UpBmp2);
  if DownBmp2 <> nil then FreeAndNil(DownBmp2);
  UpBmp2 := ButtonGlyph(Width, Height, cSelectedLight, cSelectedShadow, True);
  DownBmp2 := ButtonGlyph(Width, Height, cSelectedLight, cSelectedShadow, False);
  if DisableBmp <> nil then FreeAndNil(DisableBmp);
  DisableBmp := ButtonGlyph(Width, Height, cDisableLight, cDisableShadow, True);
end;

procedure TNewBtn.CreateWnd;
begin
  inherited;
  CreateButtonImage;
  FActive := FDefault;
end;

destructor TNewBtn.Destroy;
begin
  if Assigned(UpBmp) then
    begin
      UpBmp.Free;
      DownBmp.Free;
      UpBmp2.Free;
      DownBmp2.Free;
      DisableBmp.Free;
    end;
  if Assigned(FBitmap) then FBitmap.Free;
  inherited;
end;

procedure TNewBtn.DrawFocusArea(Canvas: TCanvas; x1, y1, x2, y2: Integer; c1, c2: TColor);
var
  s: Integer;
begin
  s := Min(x2 - x1 + 1, y2 - y1 + 1) div 4;
  Line(Canvas, x1, y1, x1 + s, y1, c1);
  Line(Canvas, x1, y1, x1 , y1 + s, c1);
  Line(Canvas, x2, y2, x2 - s, y2, c2);
  Line(Canvas, x2, y2, x2 , y2 - s, c2);
end;

procedure TNewBtn.EmulateMouseClick;
begin
  Perform(WM_LBUTTONDOWN, 0, Width div 2 + Height div 2 shl 16);
  Perform(WM_LBUTTONUP, 0, Width div 2 + Height div 2 shl 16);
end;

function TNewBtn.IsDown: Boolean;
begin
  Result := FState in [nbsDown, nbsDownHighLight];
end;

procedure TNewBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then
    begin
      if AllowDown then FState := StateInvert(FState)
      else
        case FState of
          nbsUp: FState := nbsDown;
          nbsUpHighLight: FState := nbsDownHighLight;
        end;
      if TabStop then SetFocus;  
      Invalidate;
    end;
  inherited;
end;

procedure TNewBtn.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
    begin
      if not AllowDown then
        case FState of
          nbsDown: FState := nbsUp;
          nbsDownHighLight: FState := nbsUpHighLight;
        end;
      Invalidate;
    end;
end;

procedure TNewBtn.Paint;
var
  s: string;
  i, wtext, htext, wbitmap, hbitmap, wc, hc, xtext, ytext, xbitmap, ybitmap, incre, rs: Integer;
  bmp: TBitmap;
  c1, c2: TColor;
begin
  if (Caption = '') or FBitmap.Empty then rs := 0
  else rs := FSpace;
  bmp := DisableBmp;
  if Enabled then
    case FState of
      nbsUp: bmp := UpBmp;
      nbsDown: bmp := DownBmp;
      nbsUpHighLight: bmp := UpBmp2;
      nbsDownHighLight: bmp := DownBmp2;
    end;
  Canvas.Draw(0, 0, bmp);
  Canvas.Font := Font;
  s := Caption;
  for i := Length(s) downto 1 do
    if s[i] = '&' then Delete(s, i, 1);
  Canvas.Font := Font;
  if not Enabled and not FDisableBitmap.Empty then bmp := FDisableBitmap
  else bmp := FBitmap;
  wtext := Canvas.TextWidth(s);
  htext := Canvas.TextHeight(s);
  wbitmap := bmp.Width;
  hBitmap := bmp.Height;
  case FBitmapPos of
    nbbpLeft, nbbpRight:
      begin
        wc := wtext + wbitmap + rs;
        if FBitmapPos = nbbpLeft then
          begin
            xtext := (Width - wc) div 2 + wbitmap + rs;
            ytext := (Height - htext) div 2;
            xbitmap := (Width - wc) div 2;
            ybitmap := (Height - hbitmap) div 2;
          end
        else
          begin
            xtext := (Width - wc) div 2;
            ytext := (Height - htext) div 2;
            xbitmap := (Width - wc) div 2 + wtext + rs;
            ybitmap := (Height - hbitmap) div 2;
          end;
      end;
    else
      begin
        hc := htext + hbitmap + rs;
        if FBitmapPos = nbbpTop then
          begin
            xtext := (Width - wtext) div 2;
            ytext := (Height - hc) div 2 + hBitmap + rs;
            xbitmap := (Width - wbitmap) div 2;
            ybitmap := (Height - hc) div 2;
          end
        else
          begin
            xtext := (Width - wtext) div 2;
            ytext := (Height - hc) div 2;
            xbitmap := (Width - wbitmap) div 2;
            ybitmap := (Height - hc) div 2 + hText + rs;
          end;
      end;
  end;
  bmp.Transparent := True;
  if FMoveWhenDown and (FState in [nbsDown, nbsDownHighLight]) then Incre := 1
  else Incre := 0;
  Canvas.Draw(xbitmap + Incre, ybitmap + Incre, bmp);
  c1 := cDisableText; c2 := cDisableShortCut;
  if Enabled then
    case FState of
      nbsUp, nbsDown: begin c1 := cText; c2 := cShortCut; end;
      nbsUpHighLight, nbsDownHighLight: begin c1 := cSelectedText; c2 := cSelectedShortcut end;
    end;
  SetBkMode(Canvas.Handle, TRANSPARENT);  
  DrawCap(Canvas, xtext + Incre, ytext + Incre, Caption, $00, c1, c2, not Enabled);
  if TabStop and (GetFocus = Handle) then
    case FState of
      nbsUp: DrawFocusArea(Canvas, 1, 1, Width - 2, Height - 2, cShadow, cLight);
      nbsDown: DrawFocusArea(Canvas, 1, 1, Width - 2, Height - 2, cShadow, cLight);
      nbsUpHighLight: DrawFocusArea(Canvas, 1, 1, Width - 2, Height - 2, cSelectedShadow, cSelectedLight);
      nbsDownHighLight: DrawFocusArea(Canvas, 1, 1, Width - 2, Height - 2, cSelectedShadow, cSelectedLight);
    end;
end;

procedure TNewBtn.Resize;
begin
  inherited;
  CreateButtonImage;
  Invalidate;
end;

procedure TNewBtn.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
  FBitmap.HandleType := bmDIB;
  FBitmap.PixelFormat := pf24bit;
end;

procedure TNewBtn.SetBitmapPos(const Value: TNewBtnBitmapPosition);
begin
  FBitmapPos := Value;
  Invalidate;
end;

procedure TNewBtn.SetCancel(const Value: Boolean);
begin
  FCancel := Value;
  if FCancel and FDefault then Default := False;
end;

procedure TNewBtn.SetDefault(const Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
    end;
  if FDefault and FCancel then Cancel := False;
end;

procedure TNewBtn.SetDisableBitmap(const Value: TBitmap);
begin
  FDisableBitmap.Assign(Value);
  FDisableBitmap.HandleType := bmDIB;
  FDisableBitmap.PixelFormat := pf24bit;
end;

procedure TNewBtn.SetMoveWhenDown(const Value: Boolean);
begin
  FMoveWhenDown := Value;
  Invalidate;
end;

procedure TNewBtn.SetSpace(const Value: Integer);
begin
  FSpace := Value;
  Invalidate;
end;

procedure TNewBtn.SetState(const Value: TNewBtnState);
begin
  FState := Value;
  Invalidate;
end;

function TNewBtn.StateHighLight(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUp: Result := nbsUpHighLight;
    nbsDown: Result := nbsDownHighLight;
    else Result := State;
  end;
end;

function TNewBtn.StateInvert(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUp: Result := nbsDown;
    nbsDown: Result := nbsUp;
    nbsUpHighLight: Result := nbsDownHighLight;
    else Result := nbsUpHighLight;
  end;
end;

function TNewBtn.StateNormal(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUpHighLight: Result := nbsUp;
    nbsDownHighLight: Result := nbsDown;
    else Result := State;
  end;
end;

procedure TNewBtn.WMKeyDown(var Message: TWMKeydown);
begin
  if (Message.CharCode = VK_SPACE) and (GetFocus = Handle) then
    Perform(WM_LBUTTONDOWN, 0, Height div 2 shl 16 + Width div 2);
  inherited;
end;

procedure TNewBtn.WMKeyUp(var Message: TWMKeyUp);
begin
  if (Message.CharCode = VK_SPACE) and (GetFocus = Handle) then
    Perform(WM_LBUTTONUP, 0, Height div 2 shl 16 + Width div 2);
  inherited;
end;

{ TGraphicNewBtn }

procedure TGraphicNewBtn.BitmapChange(Sender: TObject);
begin
  Invalidate;
end;

function TGraphicNewBtn.ButtonGlyph(Width, Height: Integer; c1, c2: TColor; Up: Boolean): TBitmap;
begin
  Result := TBitmap.Create;
  Result.HandleType := bmDIB;
  Result.PixelFormat := pf24bit;
  Result.Width := Width; Result.Height := Height;
  c1 := ColorToRgb(c1); c2 := ColorToRgb(c2);
  DrawGradientFill(Result.Canvas, 1, 1, Width - 2, Height - 2,
    GradientColor(c1, c2, 0.1), GradientColor(c2, c1, 0.1), False);
  if Up then
    Frame(Result.Canvas, 0, 0, Width - 1, Height - 1, c1, c2)
  else
    Frame(Result.Canvas, 0, 0, Width - 1, Height - 1, c2, c1);
  Result.Canvas.Pixels[Width - 1, 0] := GradientColor(c1, c2, 0.5);
  Result.Canvas.Pixels[0, Height - 1] := GradientColor(c1, c2, 0.5);
end;

procedure TGraphicNewBtn.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TGraphicNewBtn.CMEnableChange(var message: TMessage);
var
  p: TPoint;
begin
  inherited;
  GetCursorPos(p);
  p := ScreenToClient(p);
  if PtInRect(Rect(0, 0, Width, Height), p) then
    FState := StateHighLight(FState);
  Invalidate;
end;

procedure TGraphicNewBtn.CMFontChanged(var Message: TMessage);
begin
  inherited;
  invalidate;
end;

procedure TGraphicNewBtn.CMMouseEnter(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    begin
      FState := StateHighLight(FState);
      Invalidate;
    end;
  inherited;
end;

procedure TGraphicNewBtn.CMMouseLeave(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    begin
      State := StateNormal(FState);
      Invalidate;
    end;
  inherited;
end;

procedure TGraphicNewBtn.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TGraphicNewBtn.Create(aOwner: TComponent);
begin
  inherited;
  UpBmp := nil;
  DownBmp := nil;
  UpBmp2 := nil;
  DownBmp2 := nil;
  DisableBmp := nil;
  Width := 24; Height := 24;
  FState := nbsUp;
  FBitmap := TBitmap.Create;
  FBitmap.OnChange := BitmapChange;
  FDisableBitmap := TBitmap.Create;
  FDisableBitmap.OnChange := BitmapChange;
  FSpace := 3;
  FBitmapPos := nbbpLeft;
  FAllowDown := False;
  CreateButtonImage;
  ControlStyle := ControlStyle - [csSetCaption];
end;

procedure TGraphicNewBtn.CreateButtonImage;
begin
  if UpBmp <> nil then FreeAndNil(UpBmp);
  if DownBmp <> nil then FreeAndNil(DownBmp);
  UpBmp := ButtonGlyph(Width, Height, cLight, cShadow, True);
  DownBmp := ButtonGlyph(Width, Height, cLight, cShadow, False);
  if UpBmp2 <> nil then FreeAndNil(UpBmp2);
  if DownBmp2 <> nil then FreeAndNil(DownBmp2);
  UpBmp2 := ButtonGlyph(Width, Height, cSelectedLight, cSelectedShadow, True);
  DownBmp2 := ButtonGlyph(Width, Height, cSelectedLight, cSelectedShadow, False);
  if DisableBmp <> nil then FreeAndNil(DisableBmp);
  DisableBmp := ButtonGlyph(Width, Height, cDisableLight, cDisableShadow, True);
end;

destructor TGraphicNewBtn.Destroy;
begin
  if Assigned(UpBmp) then
    begin
      UpBmp.Free;
      DownBmp.Free;
      UpBmp2.Free;
      DownBmp2.Free;
      DisableBmp.Free;
    end;
  if Assigned(FBitmap) then FBitmap.Free;
  inherited;
end;

function TGraphicNewBtn.IsDown: Boolean;
begin
  Result := FState in [nbsDown, nbsDownHighLight];
end;

procedure TGraphicNewBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then
    begin
      if AllowDown then FState := StateInvert(FState)
      else
        case FState of
          nbsUp: FState := nbsDown;
          nbsUpHighLight: FState := nbsDownHighLight;
        end;
      Invalidate;
    end;
  inherited;
end;

procedure TGraphicNewBtn.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
    begin
      if not AllowDown then
        case FState of
          nbsDown: FState := nbsUp;
          nbsDownHighLight: FState := nbsUpHighLight;
        end;
      Invalidate;
    end;
end;

procedure TGraphicNewBtn.Paint;
var
  s: string;
  i, wtext, htext, wbitmap, hbitmap, wc, hc, xtext, ytext, xbitmap, ybitmap, incre, rs: Integer;
  bmp: TBitmap;
  c1, c2: TColor;
begin
  if (Caption = '') or FBitmap.Empty then rs := 0
  else rs := FSpace;
  bmp := DisableBmp;
  if Enabled then
    case FState of
      nbsUp: bmp := UpBmp;
      nbsDown: bmp := DownBmp;
      nbsUpHighLight: bmp := UpBmp2;
      nbsDownHighLight: bmp := DownBmp2;
    end;
  Canvas.Draw(0, 0, bmp);
  Canvas.Font := Font;
  s := Caption;
  for i := Length(s) downto 1 do
    if s[i] = '&' then Delete(s, i, 1);
  Canvas.Font := Font;
  if not Enabled and not FDisableBitmap.Empty then bmp := FDisableBitmap
  else bmp := FBitmap;
  wtext := Canvas.TextWidth(s);
  htext := Canvas.TextHeight(s);
  wbitmap := bmp.Width;
  hBitmap := bmp.Height;
  case FBitmapPos of
    nbbpLeft, nbbpRight:
      begin
        wc := wtext + wbitmap + rs;
        if FBitmapPos = nbbpLeft then
          begin
            xtext := (Width - wc) div 2 + wbitmap + rs;
            ytext := (Height - htext) div 2;
            xbitmap := (Width - wc) div 2;
            ybitmap := (Height - hbitmap) div 2;
          end
        else
          begin
            xtext := (Width - wc) div 2;
            ytext := (Height - htext) div 2;
            xbitmap := (Width - wc) div 2 + wtext + rs;
            ybitmap := (Height - hbitmap) div 2;
          end;
      end;
    else
      begin
        hc := htext + hbitmap + rs;
        if FBitmapPos = nbbpTop then
          begin
            xtext := (Width - wtext) div 2;
            ytext := (Height - hc) div 2 + hBitmap + rs;
            xbitmap := (Width - wbitmap) div 2;
            ybitmap := (Height - hc) div 2;
          end
        else
          begin
            xtext := (Width - wtext) div 2;
            ytext := (Height - hc) div 2;
            xbitmap := (Width - wbitmap) div 2;
            ybitmap := (Height - hc) div 2 + hText + rs;
          end;
      end;
  end;
  bmp.Transparent := True;
  if FState in [nbsDown, nbsDownHighLight] then Incre := 1
  else Incre := 0;
  Canvas.Draw(xbitmap + Incre, ybitmap + Incre, bmp);
  c1 := cDisableText; c2 := cDisableShortCut;
  if Enabled then
    case FState of
      nbsUp, nbsDown: begin c1 := cText; c2 := cShortCut; end;
      nbsUpHighLight, nbsDownHighLight: begin c1 := cSelectedText; c2 := cSelectedShortcut end;
    end;
  SetBkMode(Canvas.Handle, TRANSPARENT);
  DrawCap(Canvas, xtext + Incre, ytext + Incre, Caption, $00, c1, c2, not Enabled);
end;

procedure TGraphicNewBtn.Resize;
begin
  inherited;
  CreateButtonImage;
  Invalidate;
end;

procedure TGraphicNewBtn.SetBitmap(const Value: TBitmap);
var
  s: Integer;
begin
  if not (csDesigning in ComponentState) then
    FBitmap.Assign(Value)
  else
    if Value.Width = 2 * Value.Height then
      begin
        s := Value.Height;
        FBitmap.Width := s;
        FBitmap.Height := s;
        FDisableBitmap.Width := s;
        FDisableBitmap.Height := s;
        FBitmap.Canvas.CopyRect(Rect(0, 0, s, s), Value.Canvas, Rect(0, 0, s, s));
        FDisableBitmap.Canvas.CopyRect(Rect(0, 0, s, s), Value.Canvas, Rect(s, 0, 2 * s, s));
      end
    else
      FBitmap.Assign(Value);  
end;

procedure TGraphicNewBtn.SetBitmapPos(const Value: TNewBtnBitmapPosition);
begin
  FBitmapPos := Value;
  Invalidate;
end;

procedure TGraphicNewBtn.SetDisableBitmap(const Value: TBitmap);
begin
  FDisableBitmap.Assign(Value);
  Invalidate;
end;

procedure TGraphicNewBtn.SetSpace(const Value: Integer);
begin
  FSpace := Value;
  Invalidate;
end;

procedure TGraphicNewBtn.SetState(const Value: TNewBtnState);
begin
  FState := Value;
  Invalidate;
end;

function TGraphicNewBtn.StateHighLight(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUp: Result := nbsUpHighLight;
    nbsDown: Result := nbsDownHighLight;
    else Result := State;
  end;
end;

function TGraphicNewBtn.StateInvert(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUp: Result := nbsDown;
    nbsDown: Result := nbsUp;
    nbsUpHighLight: Result := nbsDownHighLight;
    else Result := nbsUpHighLight;
  end;
end;

function TGraphicNewBtn.StateNormal(State: TNewBtnState): TNewBtnState;
begin
  case State of
    nbsUpHighLight: Result := nbsUp;
    nbsDownHighLight: Result := nbsDown;
    else Result := State;
  end;
end;

{ TFramedBtn }

function TFramedBtn.ButtonGlyph(Width, Height: Integer; c1, c2: TColor;
  Up: Boolean): TBitmap;
begin
  Result := TBitmap.Create;
  Result.HandleType := bmDIB;
  Result.PixelFormat := pf24bit;
  Result.Width := Width; Result.Height := Height;
  c1 := ColorToRGB(c1); c2 := ColorToRgb(c2);
  Result.Canvas.Brush.Color := GradientColor(c1, c2, 0.5);
  Result.Canvas.FillRect(Rect(1, 1, Width - 1, Height - 1));
  if Up then
    DoubleFrame(Result.Canvas, 0, 0, Width - 1, Height - 1, c2, c1, c1, c2)
  else
    Frame(Result.Canvas, 0, 0, Width - 1, Height - 1, c2, c1);
end;

{ TNewCheckBox }

procedure TNewCheckBox.AutoResize;
var
  S: TSize;
begin
  Canvas.Font := Font;
  S := Canvas.TextExtent(RealCap(Caption));
  S.cx := S.cx + 15 + 2;
  s.cy := Max(s.cy, 15);
  Width := s.cx;
  Height := s.cy;
end;

procedure TNewCheckBox.CheckedChange;
begin
  //Do nothing
end;

procedure TNewCheckBox.Click;
begin
  if not (csDesigning in ComponentState) then
    begin
      Checked := not FChecked;
      if TabStop then SetFocus;
      Invalidate;
    end;
  inherited;
end;

procedure TNewCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      Checked := not FChecked;
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TNewCheckBox.CMEnableChange(var message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TNewCheckBox.CMFocusChanged(var Message: TCMFocusChanged);
begin
  inherited;
  invalidate;
end;

procedure TNewCheckBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  invalidate;
end;

procedure TNewCheckBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    begin
      IsMouseIn := True;
      Invalidate;
    end;
end;

procedure TNewCheckBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    begin
      IsMouseIn := False;
      Invalidate;
    end;
end;

procedure TNewCheckBox.CMTextChanged(var Message: TMessage);
begin
  inherited;
  invalidate;
end;

constructor TNewCheckBox.Create(aOwner: TComponent);
begin
  inherited;
  Checked := False;
  CreateCheckImages;
  Width := 96;
  Height := 13;
  IsMouseIn := False;
  ControlStyle := ControlStyle + [csDesignInteractive];
end;

procedure TNewCheckBox.CreateCheckImages;
begin
  FCheckedBmp := TBitmap.Create; FCheckedBmp.Assign(CheckedA);
  FUnCheckedBmp := TBitmap.Create; FUnCheckedBmp.Assign(UnCheckedA);
  FCheckedBmpH := TBitmap.Create; FCheckedBmpH.Assign(CheckedAH);
  FUncheckedBmpH := TBitmap.Create; FUnCheckedBMPH.Assign(UnCheckedAH);
  FCheckedBmpD := TBitmap.Create; FCheckedBmpD.Assign(CheckedAD);
  FUncheckedBmpD := TBitmap.Create; FUnCheckedBmpD.Assign(UncheckedAD);
end;

destructor TNewCheckBox.Destroy;
begin
  FCheckedBmp.Free; FUncheckedBmp.Free;
  FCheckedBmpH.Free; FUnCheckedBmpH.Free;
  FCheckedBmpD.Free; FUnCheckedBmpD.Free;
  inherited;
end;

procedure TNewCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if csDesigning in ComponentState then
    AutoResize;
end;

procedure TNewCheckBox.Paint;
var
  bmp: TBitmap;
begin
  inherited;
  Canvas.Brush.Color := cFace;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  case Enabled of
    True:
      case FChecked of
        True: if IsMouseIn then bmp := FCheckedBmpH else bmp := FCheckedBmp;
        else if IsMouseIn then bmp := FUncheckedBmpH else bmp := FUncheckedBmp;
      end;
    else
      if Checked then bmp := FCheckedBmpD else bmp := FUnCheckedBmpD
  end;
  Canvas.Draw(0, Height div 2 - 6, bmp);
  Canvas.Font := Font;
  SetBkMode(Canvas.Handle, TRANSPARENT);
  if Enabled then
    DrawCap(Canvas, 15, Height div 2, Caption, $10, cText, cShortCut)
  else
    DrawCap(Canvas, 15, Height div 2, Caption, $10, cFace, cDisableShortcut, True);
  if GetFocus = Handle then
    DrawFocusRect(Canvas.Handle, Rect(14, 0, Width, Height));
end;

procedure TNewCheckBox.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
  CheckedChange;
  Invalidate;
end;

procedure TNewCheckBox.WMKeyDown(var Message: TWMKeydown);
begin
  if (Message.CharCode = VK_SPACE) and (GetFocus = Handle) then
    Perform(WM_LBUTTONDOWN, 0, Height div 2 shl 16 + Width div 2);
  inherited;
end;

procedure TNewCheckBox.WMKeyUp(var Message: TWMKeyUp);
begin
  if (Message.CharCode = VK_SPACE) and (GetFocus = Handle) then
    Perform(WM_LBUTTONUP, 0, Height div 2 shl 16 + Width div 2);
  inherited;
end;

{ TNewRadioButton }

procedure TNewRadioButton.CheckedChange;
begin
  inherited;
  ResetOthers;
end;

constructor TNewRadioButton.Create(aOwner: TComponent);
begin
  inherited;
  FGroupIndex := 0;
end;

procedure TNewRadioButton.CreateCheckImages;
begin
  FCheckedBmp := TBitmap.Create; FCheckedBmp.Assign(CheckedB);
  FUnCheckedBmp := TBitmap.Create; FUnCheckedBmp.Assign(UnCheckedB);
  FCheckedBmpH := TBitmap.Create; FCheckedBmpH.Assign(CheckedBH);
  FUncheckedBmpH := TBitmap.Create; FUnCheckedBMPH.Assign(UnCheckedBH);
  FCheckedBmpD := TBitmap.Create; FCheckedBmpD.Assign(CheckedBD);
  FUncheckedBmpD := TBitmap.Create; FUnCheckedBmpD.Assign(UncheckedBD);
end;

procedure TNewRadioButton.ResetOthers;
var
  c: TWinControl;
  i: Integer;
begin
  if not FChecked then Exit;
  c := Parent;
  if not Assigned(c) then Exit;
  for i := 0 to c.ControlCount - 1 do
    if (c.Controls[i] is TNewRadioButton) and (c.Controls[i] <> Self) then
      (c.Controls[i] as TNewRadioButton).Checked := False;
end;

procedure TNewRadioButton.SetGroupIndex(const Value: Integer);
begin
  FGroupIndex := Value;
end;

procedure CreatePatterns;

  procedure CreateaPair1(bmp1, bmp2: TBitmap; Light, Shadow, Face, TC: TColor);
  const
    Map: array[0..6, 0..6] of Integer = (
    (0, 0, 0, 0, 0, 0, 1),
    (0, 0, 0, 0, 0, 1, 1),
    (1, 0, 0, 0, 1, 1, 1),
    (1, 1, 0, 1, 1, 1, 0),
    (1, 1, 1, 1, 1, 0, 0),
    (0, 1, 1, 1, 0, 0, 0),
    (0, 0, 1, 0, 0, 0, 0)
    );
  var
    i, j: Integer;
  begin
    bmp1.HandleType := bmDIB;
    bmp1.PixelFormat := pf24bit;
    bmp1.Width := 13;
    bmp1.Height := 13;
    Light := ColorToRGB(Light); Shadow := ColorToRgb(Shadow);
    with bmp1 do
      begin
        DrawGradientFill(bmp1.Canvas, 1, 1, 11, 11,
          GradientColor(Shadow, Face, 0.2), GradientColor(Light, Face, 0.2), False);
        Frame(bmp1.Canvas, 0, 0, 12, 12, Shadow, Light);
      end;
    bmp2.Assign(bmp1);
    with bmp1.Canvas do
      for i := 0 to 6 do
        for j := 0 to 6 do
          if Map[j, i] = 1 then Pixels[i + 3, j + 3] := TC;
  end;

  procedure CreateaPair2(bmp1, bmp2: TBitmap; Light, Shadow, Face, TC: TColor);
  const
    p: array[1..2, 0..8, 1..2] of Integer = (
    ((0, 9), (0, 3), (3, 0), (9, 0), (12, 3), (12, 9), (9, 12), (3, 12), (0, 9)),
    ((3, 7), (3, 5), (5, 3), (7, 3), (9, 5), (9, 7), (7, 9), (5, 9), (3, 7))
    );

  type
    TP = array[0..8] of TPoint;

  var
    i: Integer;
    AndMask, XorMask: TBitmap;
    q: ^TP;
  begin
    AndMask := TBitmap.Create;
    AndMask.Width := 13; AndMask.Height := 13;
    AndMask.HandleType := bmDIB; AndMask.PixelFormat := pf24Bit;
    AndMask.Canvas.Brush.Color := $00000000;
    AndMask.Canvas.FillRect(Rect(0, 0, 13, 13));
    AndMask.Canvas.Brush.Color := $00FFFFFF;
    AndMask.Canvas.Pen.Color := $00FFFFFF;
    q := @p[1];
    AndMask.Canvas.Polygon(q^);

    XorMask := TBitmap.Create;
    XorMask.Width := 13; XorMask.Height := 13;
    XorMask.HandleType := bmDIB; XorMask.PixelFormat := pf24Bit;
    XorMask.Canvas.Brush.Color := cFace;
    XorMask.Canvas.Pen.Color := cFace;
    XorMask.Canvas.FillRect(Rect(0, 0, 13, 13));
    XorMask.Canvas.Brush.Color := $00000000;
    XorMask.Canvas.Pen.Color := $00000000;
    XorMask.Canvas.Polygon(q^);

    bmp1.Width := 13;
    bmp1.Height := 13;
    Light := ColorToRGB(Light); Shadow := ColorToRgb(Shadow);
    with bmp1 do
      begin
        DrawGradientFill(Canvas, 1, 0, 11, 12,
          GradientColor(Shadow, Face, 0.2), GradientColor(Light, Face, 0.2), False);
        BitBlt(Canvas.Handle, 0, 0, 13, 13, AndMask.Canvas.Handle, 0, 0, SRCAND);
        BitBlt(Canvas.Handle, 0, 0, 13, 13, XorMask.Canvas.Handle, 0, 0, SRCINVERT);
        Canvas.Pen.Color := Shadow;
        Canvas.MoveTo(p[1][0][1], p[1][0][2]);
        for i := 1 to 4 do Canvas.LineTo(p[1][i][1], p[1][i][2]);
        Canvas.Pen.Color := Light;
        for i := 5 to 8 do Canvas.LineTo(p[1][i][1], p[1][i][2]);
      end;
    bmp2.Assign(bmp1);
    with bmp1 do
      begin
        Canvas.Pen.Color := TC;
        Canvas.Brush.Color := TC;
        q := @p[2];
        Canvas.Polygon(q^);
      end;
    AndMask.Free; XorMask.Free;
  end;

begin
  CheckedA := TBitmap.Create;
  UnCheckedA := TBitmap.Create;
  CheckedAH := TBitmap.Create;
  UnCheckedAH := TBitmap.Create;
  CheckedAD := TBitmap.Create;
  UnCheckedAD := TBitmap.Create;
  CheckedB := TBitmap.Create;
  UnCheckedB := TBitmap.Create;
  CheckedBH := TBitmap.Create;
  UnCheckedBH := TBitmap.Create;
  CheckedBD := TBitmap.Create;
  UnCheckedBD := TBitmap.Create;
  CreateaPair1(CheckedA, UncheckedA, cLight, cShadow, cFace, cText);
  CreateaPair1(CheckedAH, UncheckedAH, cSelectedLight, cSelectedShadow, cSelectedFace, cSelectedText);
  CreateaPair1(CheckedAD, UncheckedAD, cDisableLight, cDisableShadow, cDisableFace, cDisableText);
  CreateaPair2(CheckedB, UncheckedB, cLight, cShadow, cFace, cText);
  CreateaPair2(CheckedBH, UncheckedBH, cSelectedLight, cSelectedShadow, cSelectedFace, cSelectedText);
  CreateaPair2(CheckedBD, UncheckedBD, cDisableLight, cDisableShadow, cDisableFace, cDisableText);
end;

procedure FreePatterns;
begin
  CheckedA.Free; UnCheckedA.Free;
  CheckedAH.Free; UnCheckedAH.Free;
  CheckedAD.Free; UnCheckedAD.Free;
  CheckedB.Free; UnCheckedB.Free;
  CheckedBH.Free; UnCheckedBH.Free;
  CheckedBD.Free; UnCheckedBD.Free;
end;

initialization
  CreatePatterns;
finalization
  FreePatterns;
end.

