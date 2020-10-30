unit FormTitleBars;

interface
uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, StdCtrls, NewBtns, Forms, Messages, Menus;
const
  DefaultHeight = 19;
  ButtonSize = 17;
  DefaultBtnTop = 1;
  TitleBarSpace = 8;

type
  TFormTitleBarButtons = (ftbClose, ftbMax, ftbNormal, ftbMin);
  TFormTitleBarVisibleButtons = set of TFormTitleBarButtons;
  TFormTitleBar = class(TCustomControl)
  private
    { Private declarations }
    ActiveStatus: Boolean;
    FMenu: TPopupMenu;
    Btns: array[1..4] of TFramedBtn;
    FMinBtn, FMaxBtn, FNorBtn, FCloBtn: TFramedBtn;
    FTimer: TTimer;
    FForm: TCustomForm;
    LastP, LastCorner: TPoint;
    MDown: Boolean;
    FVisibleButtons: TFormTitleBarVisibleButtons;
    FAutoArrangeForm: Boolean;
    FFormPaint, FFormResize: TNotifyEvent;
    procedure ReAlign;
    function FormHasFocus: Boolean;
    procedure BtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure SetVisibleButtons(const Value: TFormTitleBarVisibleButtons);
    procedure MenuItemClick(Sender: TObject);
    procedure FTimerTimer(Sender: TObject);
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure Resize; override;
    procedure SetParent(Parent: TWinControl); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateTheme;
    procedure DeactivateTheme;
    procedure AlignFormControls(PBorderSize: Integer; ResizeForm: Boolean = False);
    procedure AlignFormControl(Control: TControl; Align: TAlign);
    function WMNCHITTESTHandle(const message: TWMNCHITTEST): LRESULT;
  published
    { Published declarations }
    property Align default alTop;
    property VisibleButtons: TFormTitleBarVisibleButtons read FVisibleButtons write SetVisibleButtons;
    property Height default DefaultHeight;
    property AutoArrangeForm: Boolean read FAutoArrangeForm write FAutoArrangeForm default False;
    property OnFormPaint: TNotifyEvent read FFormPaint write FFormPaint;
    property OnFormResize: TNotifyEvent read FFormResize write FFormResize;
  end;

  TCommonCtrl = class(TControl)
  public
    property Font;
    property Color;
    property ParentFont;
    property ParentColor;
  end;

  TCommonWinCtrl = class(TWinControl)
  public
    property Ctl3D;
    property ParentCtl3D;
  end;
  
procedure Register;

implementation
uses CtrlCreate, MyConst, Math, Dialogs;

procedure Register;
begin
  RegisterComponents('Hoang', [TFormTitleBar]);
end;

{ TFormTitleBar }
{$R *.res}

procedure TFormTitleBar.ActivateTheme;
begin
  if Assigned(FForm) then
    begin
      if not (csDesigning in ComponentState) then
        begin
          TForm(FForm).OnResize := FormResize;
          TForm(FForm).OnPaint := FormPaint;
        end;
      TForm(FForm).Color := cFace;
      TForm(FForm).Scaled := False;
      TForm(FForm).AutoSize := False;
      TForm(FForm).Font := DefaultFont;
      TForm(FForm).Ctl3D := False;
      TForm(FForm).BorderStyle := bsNone;
      Caption := FForm.Caption;
      Realign;
    end;
end;

procedure TFormTitleBar.AlignFormControl(Control: TControl; Align: TAlign);
begin
  if not Assigned(FForm) or (Control.Parent <> FForm) then Exit;
  case Align of
    alClient:
      begin
        Control.Left := TitleBarSpace;
        Control.Top := TitleBarSpace + DefaultHeight;
        Control.Width := FForm.Width - 2 * TitleBarSpace;
        Control.Height := FForm.Height - 2 * TitleBarSpace - DefaultHeight;
      end;
  end;
end;

procedure TFormTitleBar.AlignFormControls(PBorderSize: Integer; ResizeForm: Boolean = False);
var
  i: Integer;
  MinX, MaxX, MinY, MaxY: Integer;
begin
  if not Assigned(FForm) then Exit;
  Height := DefaultHeight;
  MinX := MaxInt; MinY := MaxInt;
  MaxX := -1; MaxY := - 1;
  with FForm do
    for i := 0 to ControlCount - 1 do
      if Controls[i].Visible and (Controls[i] <> Self) then
        with Controls[i] do
          begin
            MinX := Min(MinX, Left); MinY := Min(MinY, Top);
            MaxX := Max(MaxX, Left + Width - 1); MaxY := Max(MaxY, Top + Height - 1);
          end;
  if (MinX > MaxX) or (MinY > MaxY) then Exit;
  with FForm do
    for i := 0 to ControlCount - 1 do
      if Controls[i].Visible then
        with Controls[i] do
          begin
            Left := Left - MinX + PBorderSize; Top := Top - MinY + PBorderSize + DefaultHeight;
          end;
  if ResizeForm then
    begin
      TForm(FForm).ClientWidth := MaxX - MinX + 2 * PBorderSize + 1;
      TForm(FForm).ClientHeight := MaxY - MinY + 2 * PBorderSize + DefaultHeight + 1;
    end;
end;

procedure TFormTitleBar.BtnClick(Sender: TObject);
begin
  if not Assigned(FForm) then Exit;
  if Sender = FMaxBtn then FForm.WindowState := wsMaximized;
  if Sender = FMinBtn then FForm.WindowState := wsMinimized;
  if Sender = FNorBtn then FForm.WindowState := wsNormal;
  if Sender = FCloBtn then FForm.Close;
end;

constructor TFormTitleBar.Create(aOwner: TComponent);

  function CreateBtn(pHint: String): TFramedBtn;
  begin
    Result := TFramedBtn.Create(Self);
    Result.Parent := Self;
    Result.Width := ButtonSize;
    Result.Height := ButtonSize;
    Result.OnClick := BtnClick;
    Result.Visible := False;
    Result.ShowHint := True;
    Result.Hint := pHint;
  end;

  function CreateMenuItem(Caption: string): TMenuItem;
  begin
    Result := TMenuItem.Create(FMenu);
    Result.Caption := Caption;
    Result.OnClick := MenuItemClick;
  end;

begin
  inherited;
  Height := DefaultHeight;
  FMinBtn := CreateBtn('Minimize');
  FNorBtn := CreateBtn('Restore');
  FMaxBtn := CreateBtn('Maximize');
  FCloBtn := CreateBtn('Close');
  Btns[1] := FCloBtn;
  Btns[2] := FMaxBtn;
  Btns[3] := FNorBtn;
  Btns[4] := FMinBtn;
  Align := alTop;
  FForm := nil;
  MDown := False;
  FMinBtn.Bitmap.LoadFromResourceName(HInstance, 'MINIMIZEBUTTON');
  FMaxBtn.Bitmap.LoadFromResourceName(HInstance, 'MAXIMIZEBUTTON');
  FCloBtn.Bitmap.LoadFromResourceName(HInstance, 'CLOSEBUTTON');
  FNorBtn.Bitmap.LoadFromResourceName(HInstance, 'NORMALBUTTON');
  FMenu := TPopupMenu.Create(Self);
  FMenu.Items.Add(CreateMenuItem('Adjust form size'));
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 100;
  FTimer.OnTimer := FTimerTimer;
  ControlStyle := ControlStyle + [csDesignInteractive, csClickEvents];
  FVisibleButtons := [ftbClose];
  FAutoArrangeForm := False;
  ControlStyle := ControlStyle + [csFixedHeight];
end;

procedure TFormTitleBar.DeactivateTheme;
begin
  if Assigned(FForm) then
    begin
      TForm(FForm).OnActivate := nil;
      TForm(FForm).OnDeactivate := nil;
      TForm(FForm).OnResize := nil;
      TForm(FForm).OnPaint := nil;
      Application.OnActivate := nil;
      Application.OnDeactivate := nil;
    end;
end;

destructor TFormTitleBar.Destroy;
var
  i: Integer;
begin
  DeactivateTheme;
  for i := 4 downto 1 do Btns[i].Free;
  inherited;
end;

function TFormTitleBar.FormHasFocus: Boolean;
begin
  Result := Application.Active and Assigned(FForm) and FForm.Active;
end;

procedure TFormTitleBar.FormPaint(Sender: TObject);
begin
  if Assigned(FForm) then
    with TForm(FForm) do
      begin
        Frame(Canvas, 0, DefaultHeight, Width - 1, Height - 1, 0, 0);
        DoubleFrame(Canvas, 1, DefaultHeight, Width - 2, Height - 2, cLight, cShadow,
        GradientColor(cLight, cFace, 0.5), GradientColor(cShadow, cFace, 0.5));
      end;
  if Assigned(FFormPaint) then FFormPaint(Self);
end;

procedure TFormTitleBar.FormResize(Sender: TObject);
begin
  ReAlign;
  if FAutoArrangeForm then AlignFormControls(TitleBarSpace, False);
  if Assigned(FFormResize) then FFormResize(Self);
  if Assigned(FForm) then FForm.Repaint;
end;

procedure TFormTitleBar.FTimerTimer(Sender: TObject);
begin
  if FormHasFocus xor ActiveStatus then
    begin
      ActiveStatus := FormHasFocus;
      Repaint;
    end;
end;

procedure TFormTitleBar.MenuItemClick(Sender: TObject);
begin
  AlignFormControls(TitleBarSpace, True);
end;

procedure TFormTitleBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  p: TPoint;
begin
  inherited;
  if csDesigning in ComponentState then
    begin
      GetCursorPos(p);
      FMenu.Popup(p.X, p.Y);
    end
  else
    if Assigned(FForm) and (Button = mbLeft) then
      begin
        MDown := True;
        GetCursorPos(LastP);
        LastCorner := Point(FForm.Left, FForm.Top);
      end;
end;

procedure TFormTitleBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  inherited;
  if MDown and Assigned(FForm)then
    begin
      GetCursorPos(P);
      FForm.Left := LastCorner.X + P.X - LastP.X;
      FForm.Top := LastCorner.Y + P.Y - LastP.Y;
    end;
end;

procedure TFormTitleBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  MDown := False;
end;

procedure TFormTitleBar.Paint;
var
  w, h, sp: Integer;
  r: TRect;
begin
  inherited;
  if Assigned(FForm) and FormHasFocus then
    DrawGradientFill(Canvas, TitleBarSpace, 0, Width - 2 * TitleBarSpace, Height, cTitleLight, cTitleShadow, False)
  else
    DrawGradientFill(Canvas, TitleBarSpace, 0, Width - 2 * TitleBarSpace, Height, cDisableLight, cDisableShadow, False);
  DrawGradientFill(Canvas, 1, 0, TitleBarSpace, Height, $0000FFFF, $00000080, False);
  DrawGradientFill(Canvas, Width - TitleBarSpace - 1, 0, TitleBarSpace, Height, $0000FFFF, $00000080, False);
  Canvas.Font := Font;
  SetBKMode(Canvas.Handle, Transparent);
  w := Canvas.TextWidth(Caption); h := Canvas.TextHeight(Caption);
  sp := 4 * TitleBarSpace;
  r := Rect((Width - w) div 2 - sp, 1, (Width + w) div 2 + sp, DefaultHeight - 2);
  r.Left := Max(r.Left, Width div 4);
  r.Right := Min(r.Right, Width * 3 div 4);
  if Assigned(FForm) and FormHasFocus then
    begin
      Canvas.Brush.Color := cTitleTextBackground;
      Canvas.FillRect(Rect(r.Left, r.Top, r.Right + 1, r.Bottom + 1));
      Frame(Canvas, r.left, r.Top, r.Right, r.Bottom, cShadow, cLight);
      Canvas.Font.Color := cTitleText;
    end
  else
    begin
      Canvas.Brush.Color := cTitleTextBgrInactive;
      Canvas.FillRect(Rect(r.Left, r.Top, r.Right + 1, r.Bottom + 1));
      Frame(Canvas, r.left, r.Top, r.Right, r.Bottom, cShadow, cLight);
      Canvas.Font.Color := cTitleTextInactive;
    end;
  Canvas.TextRect(r, (Width - w) div 2, (Height - h) div 2, Caption);
  Frame(Canvas, 0, 0, Width - 1, Height - 1, cLight, cShadow);
end;

procedure TFormTitleBar.ReAlign;
var
  i, p: Integer;
begin
  for i := 1 to 4 do
    Btns[i].Visible := TFormTitleBarButtons(i - 1) in FVisibleButtons;
  if Assigned(FForm) then
    begin
      if FForm.WindowState = wsMaximized then FMaxBtn.Visible := False;
      if FForm.WindowState = wsNormal then FNorBtn.Visible := False;
    end;
  p := Width - ButtonSize - TitleBarSpace - 1;
  for i := 1 to 4 do
    if Btns[i].Visible then
      begin
        Btns[i].Top := DefaultBtnTop;
        Btns[i].Left := p;
        p := p - ButtonSize;
      end;
end;

procedure TFormTitleBar.Resize;
begin
  inherited;
  ReAlign;
end;

procedure TFormTitleBar.SetParent(Parent: TWinControl);
begin
  inherited;
  if Assigned(Parent) then
    begin
      ReAlign;
      FForm := GetParentForm(Self);
      ActivateTheme;
    end;  
end;

procedure TFormTitleBar.SetVisibleButtons(
  const Value: TFormTitleBarVisibleButtons);
var
  i: Integer;
begin
  FVisibleButtons := Value;
  for i := 1 to 4 do
    Btns[i].Visible := TFormTitleBarButtons(i - 1) in FVisibleButtons;
  Realign;
end;

function TFormTitleBar.WMNCHITTESTHandle(const message: TWMNCHITTEST): LResult;
var
  State: Integer;
begin
  Result := HTERROR;
  if not Assigned(FForm) then Exit;
  State := 0;
  if FForm.WindowState <> wsNormal then
    begin
      Result := HTBORDER;
      Exit;
    end;
  with Message do
    begin
      if Abs(XPos - FForm.Left) < TitleBarSpace then State := State + 1;
      if Abs(XPos - (FForm.Left + FForm.Width)) < TitleBarSpace then State := State + 2;
      if Abs(YPos - (FForm.Top + DefaultHeight)) < TitleBarSpace then State := State + 4;
      if Abs(YPos - (FForm.Top + FForm.Height)) < TitleBarSpace then State := State + 8;
    end;
  case State of
    1: Result := HTLEFT;
    2: Result := HTRIGHT;
    4: Result := HTTOP;
    8: Result := HTBOTTOM;
    5: Result := HTTOPLEFT;
    6: Result := HTTOPRIGHT;
    9: Result := HTBOTTOMLEFT;
    10: Result := HTBOTTOMRIGHT;
    else Result := 0;
  end;
end;

end.
