unit HSCtls;

interface

uses
  Windows, Graphics, Messages, SysUtils, Classes, Controls, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Grids, ValEdit, Forms, MyConst;

type
  TFSLabel = class(TLabel)
  protected
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TFSListBox = class(TListBox)
  private
    Mask, MaskH: TBitmap;
    procedure DrawItemEvent(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure CreateCheckMark;
  protected
    procedure Click; override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Style stored False;
    property OnDrawItem stored False;
  end;

  TFSCombobox = class(TCombobox)
  private
    procedure DrawItemEvent(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    function GetHorizontalExtent: Word;
    procedure SetHorizontalExtent(const Value: Word);
    function GetDroppedWidth: Word;
    procedure SetDroppedWidth(const Value: Word);
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Style stored False;
    property HorizontalExtent: Word read GetHorizontalExtent write SetHorizontalExtent;
    property DroppedWidth: Word read GetDroppedWidth write SetDroppedWidth;
  end;

  TFSDirListBox = class(TFSListBox)
  private
    procedure WMDropFiles(var msg: TMessage); message WM_DROPFILES;
    function GetDirectories: string;
    procedure SetDirectories(const Value: string);
  protected
    procedure CreateWnd; override;
  public
    procedure AddDirDlg;
    procedure RemoveDir;
    procedure ShowExplorer;
  published
    property Directories: string read GetDirectories write SetDirectories;
  end;

  TFSDTPicker = class(TDateTimePicker)
  protected
    procedure WMPaint(var message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPAINT); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TFSEdit = class(TEdit)
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TFSMemo =  class(TMemo)
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TFSRichEdit = class(TRichEdit)
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TNumberEdit = class(TFSEdit)
  private
    FMin: Int64;
    FMax: Int64;
    { Private declarations }
    function isValidChar(Ch: Char): Boolean;
    function GetValue: Int64;
    procedure SetValue(const Value: Int64);
    procedure SetMax(const Value: Int64);
    procedure SetMin(const Value: Int64);
  protected
    { Protected declarations }
    procedure Keypress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CMExit(var msg: TCMExit); message CM_EXIT;
    procedure CMEnter(var msg: TCMEnter); message CM_ENTER;
  public
    { Public declarations }
    constructor Create(aOWner: TComponent); override;
  published
    { Published declarations }
    property Value: Int64 read GetValue write SetValue;
    property Min: Int64 read FMin write SetMin;
    property Max: Int64 read FMax write SetMax;
  end;

  TFSValueListEditor = class(TValueListEditor)
  protected
    procedure DrawCellEvent(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property GridLineWidth stored False;
    property DefaultDrawing stored False;
    property OnDrawCell stored False;
  end;

  TFSScrollBox = class(TScrollBox)
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  end;

  TFSPageControl = class(TPageControl)
  private
    procedure DrawTabEvent(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
  protected
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property OwnerDraw stored False;
    property OnDrawTab stored False;
    property TabPosition stored False;
  end;

  TAutomaticAnswer = class(TTimer)
  private
    FCount: Integer;
    FTimeOut: Integer;
    Fanswer: TModalResult;
    FCaption: string;
    procedure TimerEvent(Sender: TObject);
    property OnTimer;
  public
    Form: TForm;
    constructor Create(aOwner: TComponent); override;
    procedure StartCount;
  published
    property Answer: TModalResult read Fanswer write FAnswer;
    property TimeOut: Integer read FTimeOut write FTimeOut;
  end;

  function AdvancedMsgDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
                          TimeOut: Integer; DefaultValue: TModalResult): TModalResult;

procedure Register;

implementation
uses Hgeneral, Math, CtrlCreate, ShellApi, {$WARNINGS OFF} FileCtrl {$WARNINGS ON};

procedure Register;
begin
  RegisterComponents('HoangSF', [
  TFSListBox,
  TFSCombobox,
  TFSDirListBox,
  TFSDTPicker,
  TFSEdit,
  TFSMemo,
  TFSRichEdit,
  TNumberEdit,
  TFSValueListEditor,
  TFSScrollBox,
  TFSPageControl,
  TAutomaticAnswer
  ]);
end;

{ TFSLabel }

procedure TFSLabel.CMApplyStyle(var msg: TMessage);
begin
  ParentColor := False;
  Color := cFace;
  Font := DefaultFont;
end;

{ TFSListBox }

procedure TFSListBox.Click;
var
  s: string;
begin
  inherited;
  s := Items[ItemIndex];
  Canvas.Font := Font;
  ScrollWidth := Canvas.TextWidth(s) + 16;
end;

procedure TFSListBox.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
end;

constructor TFSListBox.Create(aOwner: TComponent);
begin
  inherited;
  Style := lbOwnerDrawFixed;
  OnDrawItem := DrawItemEvent;
  CreateCheckMark;
end;

procedure TFSListBox.CreateCheckMark;
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
  Back1, Back2, Fore1, Fore2: TColor;
  i, j: Integer;
begin
  Mask := TBitmap.Create;
  Mask.Width := 7; Mask.Height := 7;
  Mask.HandleType := bmDIB;
  Mask.PixelFormat := pf24bit;
  Mask.Transparent := True;
  MaskH := TBitmap.Create;
  MaskH.Assign(Mask);
  Fore1 := cText; Back1 := cText xor $00FFFFFF;
  Fore2 := cSelectedText; Back2 := cSelectedText xor $00FFFFFF;
  for j := 0 to 6 do
    for i := 0 to 6 do
      if Map[j, i] = 0 then
        begin
          Mask.Canvas.Pixels[i, j] := Back1;
          MaskH.Canvas.Pixels[i, j] := Back2;
        end
      else
        begin
          Mask.Canvas.Pixels[i, j] := Fore1;
          MaskH.Canvas.Pixels[i, j] := Fore2;
        end;
end;

destructor TFSListBox.Destroy;
begin
  Mask.Free;
  MaskH.Free;
  inherited;
end;

procedure TFSListBox.DrawItemEvent(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Color1, Color2, Color3: TColor;
  h: Integer;
  s: string;
begin
  if not Enabled then
    begin
      Color1 := cDisableLight;
      Color2 := cDisableShadow;
      Color3 := cDisableText;
    end
  else
    if odFocused in State then
      begin
        Color1 := cSelectedLight;
        Color2 := cSelectedShadow;
        Color3 := cSelectedText;
      end
    else
      begin
        Color1 := cLight;
        Color2 := cShadow;
        Color3 := cText;
      end;
  DrawGradientFill(Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, Color1, Color2, False);
  Canvas.Font := Font;
  Canvas.Font.Color := Color3;
  SetTextAlign(Canvas.Handle, TA_LEFT or TA_TOP);
  SetBkMode(Canvas.Handle, TRANSPARENT);
  if Index >= 0 then
    begin
      s := Items.Strings[Index];
      h := Canvas.TextHeight(s);
      if MultiSelect then
        Canvas.TextOut(10, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, s)
      else
        Canvas.TextOut(1, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, s);
    end;
  if MultiSelect and ([odSelected, odFocused] * State <> []) then
    if odFocused in State then
      Canvas.Draw(1, Rect.Top + (Rect.Bottom - Rect.Top - 7) div 2, MaskH)
    else
      Canvas.Draw(1, Rect.Top + (Rect.Bottom - Rect.Top - 7) div 2, Mask)
end;

procedure TFSListBox.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSListBox.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSComboBox }

procedure TFSComboBox.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
end;

constructor TFSComboBox.Create(aOwner: TComponent);
begin
  inherited;
  Style := csOwnerDrawFixed;
  OnDrawItem := DrawItemEvent;
end;

procedure TFSComboBox.DrawItemEvent(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Color1, Color2, Color3: TColor;
  h: Integer;
  s: string;
begin
  if not Enabled then
    begin
      Color1 := cDisableLight;
      Color2 := cDisableShadow;
      Color3 := cDisableText;
    end
  else
    if odFocused in State then
      begin
        Color1 := cSelectedLight;
        Color2 := cSelectedShadow;
        Color3 := cSelectedText;
      end
    else
      begin
        Color1 := cLight;
        Color2 := cShadow;
        Color3 := cText;
      end;
  DrawGradientFill(Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, Color1, Color2, False);
  Canvas.Font := Font;
  Canvas.Font.Color := Color3;
  SetTextAlign(Canvas.Handle, TA_LEFT or TA_TOP);
  SetBkMode(Canvas.Handle, TRANSPARENT);
  if Index >= 0 then
    begin
      s := Items.Strings[Index];
      h := Canvas.TextHeight(s);
      Canvas.TextOut(3, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, s);
    end;
end;

function TFSCombobox.GetDroppedWidth: Word;
begin
  Result := Perform(CB_GETDROPPEDWIDTH, 0, 0);
end;

function TFSCombobox.GetHorizontalExtent: Word;
begin
  Result := Perform(CB_GETHORIZONTALEXTENT, 0, 0);
end;

procedure TFSCombobox.SetDroppedWidth(const Value: Word);
begin
  Perform(CB_SETDROPPEDWIDTH, Value, 0);
end;

procedure TFSCombobox.SetHorizontalExtent(const Value: Word);
begin
  Perform(CB_SETHORIZONTALEXTENT, Value, 0);
end;

procedure TFSComboBox.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSComboBox.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSDirListBox }

procedure TFSDirListBox.AddDirDlg;
var
  s: string;
begin
  SelectDirectory('Select Directory', '', s);
  if s <> '' then Items.Add(s);
end;

procedure TFSDirListBox.CreateWnd;
begin
  inherited;
  DragAcceptFiles(Handle, True);
  Items.Delimiter := '|';
  Items.QuoteChar := '"';
end;

function TFSDirListBox.GetDirectories: string;
begin
  Result := Items.DelimitedText;
end;

procedure TFSDirListBox.RemoveDir;
var
  i: Integer;
begin
  i := ItemIndex;
  if  i <> -1 then
    begin
      Items.Delete(i);
      if i < Items.Count then ItemIndex := i
      else ItemIndex := Items.Count - 1;
    end;
end;

procedure TFSDirListBox.SetDirectories(const Value: string);
begin
  Items.DelimitedText := Value;
end;

procedure TFSDirListBox.ShowExplorer;
begin
  WinExecNoWait(Handle, 'explore', Mydir, '', SW_SHOW);
end;

procedure TFSDirListBox.WMDropFiles(var msg: TMessage);
var
  drophandle: HDROP;
  i, nFiles: Integer;
  dname: array[0..MAX_PATH] of Char;
  s: string;
begin
  inherited;
  drophandle := msg.WParam;
  nFiles := DragQueryFile(drophandle, Cardinal($FFFFFFFF), dname, MAX_PATH);
  for i := 0 to nFiles - 1 do
    begin
      DragQueryFile(drophandle, Cardinal(i), dname, MAX_PATH);
      s := LowerCase(string(dname));
      if (s <> '') and (GetFileAttributes(dName) and FILE_ATTRIBUTE_DIRECTORY <> 0) then Items.Add(s);
    end;
  DragFinish(drophandle);
end;

{ TFSDTPicker }

procedure TFSDTPicker.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
end;

procedure TFSDTPicker.WMNCPaint(var message: TWMNCPAINT);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSDTPicker.WMPaint(var message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSEdit }

procedure TFSEdit.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
end;

procedure TFSEdit.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSMemo }

procedure TFSMemo.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
end;

procedure TFSMemo.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSMemo.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSRichEdit }

procedure TFSRichEdit.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
  BorderWidth := 4;
end;

procedure TFSRichEdit.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSRichEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TNumberEdit }

procedure TNumberEdit.CMEnter(var msg: TCMEnter);
begin
  inherited;
  SelectAll;
end;

procedure TNumberEdit.CMExit(var msg: TCMExit);
begin
  inherited;
  SetValue(GetValue);
end;

constructor TNumberEdit.Create(aOWner: TComponent);
begin
  inherited;
  Text := '0';
  FMin := 0;
  FMax := High(Int64);
end;

function TNumberEdit.GetValue: Int64;
begin
  try
    Result := StrToInt64Def(Text, 0);
  except
    Result := EnsureRange(0, FMin, FMax);
  end;
end;

function TNumberEdit.isValidChar(Ch: Char): Boolean;
begin
  Result := (Ch in ['+', '-', '0'..'9']) or
    ((Ch < #32) and (Ch <> Chr(VK_RETURN)));
end;

procedure TNumberEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_UP:
      begin
        Value := Value + 1;
        Key := 0;
      end;
    VK_DOWN:
      begin
        Value := Value - 1;
        Key := 0;
      end;
  end;
  if Key <> 0 then inherited KeyDown(Key, Shift);
end;

procedure TNumberEdit.Keypress(var Key: Char);
begin
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_ESCAPE)) then
    begin
      PostMessage(Parent.Handle, WM_KEYDOWN, wParam(Key), 0);
      PostMessage(Parent.Handle, WM_KEYUP, wParam(Key), 0);
      Key := #0;
      Exit;
    end;
  if not isValidChar(Key) then
    begin
      Key := #0;
      MessageBeep(0);
    end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TNumberEdit.SetMax(const Value: Int64);
begin
  FMax := Value;
  Self.Value := EnsureRange(GetValue, FMin, FMax);
end;

procedure TNumberEdit.SetMin(const Value: Int64);
begin
  FMin := Value;
  Self.Value := EnsureRange(GetValue, FMin, FMax);
end;

procedure TNumberEdit.SetValue(const Value: Int64);
begin
  Text := Inttostr(EnsureRange(Value, FMin, FMax));
end;

{ TFSValueListEditor }

procedure TFSValueListEditor.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
  DefaultRowHeight := 20;
end;

constructor TFSValueListEditor.Create(aOwner: TComponent);
begin
  inherited;
  GridLineWidth := 0;
  DefaultDrawing := False;
  OnDrawCell := DrawCellEvent;
end;

procedure TFSValueListEditor.DrawCellEvent(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if gdFixed in State then
    begin
      DrawGradientFill(Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                               cLight, cShadow, False);
      Frame(Canvas, Rect.Left, Rect.Top, Rect.Right - 1, Rect.Bottom - 1, cLight, cShadow);
    end
  else
    if ACol = 0 then
      begin
        Canvas.Brush.Color := cFace;
        Canvas.FillRect(Rect);
        Frame(Canvas, Rect.Left, Rect.Top, Rect.Right - 1, Rect.Bottom - 1, cLight, cShadow);
      end
    else
      begin
        Canvas.Brush.Color := cWindow;
        Canvas.FillRect(Rect);
        Line(Canvas, Rect.Left, Rect.Bottom - 1, Rect.Right, Rect.Bottom - 1, cFace);
      end;
  SetBkMode(Canvas.Handle, TRANSPARENT);
  Canvas.Font := Font;
  DrawStr(Canvas, Rect.Left + 4, (Rect.Top + Rect.Bottom) div 2, Cells[ACol, aRow], $10);
end;

procedure TFSValueListEditor.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSValueListEditor.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSScrollBox }

procedure TFSScrollBox.CMApplyStyle(var msg: TMessage);
begin
  ParentCtl3D := False;
  Ctl3D := True;
  ParentColor := False;
  Color := cWindow;
  ParentFont := False;
  Font := DefaultFont;
  BorderStyle := bsSingle;
end;

procedure TFSScrollBox.WMNCPaint(var message: TWMNCPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

procedure TFSScrollBox.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if not HandleAllocated then Exit;
  PaintControlBorderDown(Self);
end;

{ TFSPageControl }

procedure TFSPageControl.CMApplyStyle(var msg: TMessage);
begin
  Color := cFace;
end;

constructor TFSPageControl.Create(aOwner: TComponent);
begin
  inherited;
  OwnerDraw := True;
  OnDrawTab := DrawTabEvent;
end;

procedure TFSPageControl.DrawTabEvent(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  DrawGradientFill(Control.Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                   cLight, cFace, False);
  Control.Canvas.Font := Font;
  SetBKMode(Control.Canvas.Handle, TRANSPARENT );
  DrawCap(Control.Canvas, (Rect.Left + Rect.Right) div 2, (Rect.Top + Rect.Bottom) div 2,
              (Control As TPageControl).Pages[TabIndex].Caption, $11, cShortCut);
end;

{ TAutomaticAnswer }

constructor TAutomaticAnswer.Create(aOwner: TComponent);
begin
  inherited;
  Enabled := False;
  FTimeOut := 30;
  FCount := 0;
  Fanswer := mrOK;
  OnTimer := TimerEvent;
end;

procedure TAutomaticAnswer.StartCount;
begin
  Enabled := True;
  if Assigned(Form) then FCaption := Form.Caption;
  TimerEvent(Self);
end;

procedure TAutomaticAnswer.TimerEvent(Sender: TObject);
begin
  if Assigned(Form) then
    begin
      Form.Caption := FCaption + ' - ' + InttoStr(FTimeOut - FCount);
      if FCount >= FTimeOut then Form.ModalResult := Fanswer;
      Inc(FCount);
    end;
end;

function AdvancedMsgDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
                        TimeOut: Integer; DefaultValue: TModalResult): TModalResult;
var
  F: TForm;
  FAnswer: TAutomaticAnswer;
  p: TPoint;
begin
  F := CreateMessageDialog(Msg, DlgType, Buttons);
  FAnswer := TAutomaticAnswer.Create(F);
  FAnswer.FTimeOut := TimeOut;
  FAnswer.Answer := DefaultValue;
  FAnswer.Form := F;
  F.Position := poDesigned;
  GetCursorPos(p);
  F.Left := p.X - F.Width div 2;
  F.Top := p.Y - F.Height div 2;
  RectFit(Rect(0, 0, Screen.Width, Screen.Height), F);
  F.FormStyle := fsStayOnTop;
  SetWindowPos(F.Handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  FAnswer.StartCount;
  Result := F.ShowModal;
  F.Free;
end;

end.
