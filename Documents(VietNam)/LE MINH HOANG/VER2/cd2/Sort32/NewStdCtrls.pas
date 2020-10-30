unit NewStdCtrls;

interface

uses
  Windows, Graphics, Messages, SysUtils, Classes, Controls, MyConst;

type
  TNewLabel = class(TGraphicControl)
  private
    FAlignment: TAlignment;
    FMultiLines: Boolean;
    FAutoFit: Boolean;
    FShadow: Boolean;
    FShadowColor: TColor;
    FTransparent: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetMultiLines(const Value: Boolean);
    procedure SetAutoFit(const Value: Boolean);
    procedure SetShadow(const Value: Boolean);
    procedure SetShadowColor(const Value: TColor);
    procedure SetTransparent(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
    procedure AutoResize;
    procedure Paint; override;
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
    procedure CMEnableChange(var message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
  published
    { Published declarations }
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property MultiLines: Boolean read FMultiLines write SetMultiLines default False;
    property AutoFit: Boolean read FAutoFit write SetAutoFit default False;
    property Shadow: Boolean read FShadow write SetShadow default False;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default cShadow;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property Color;
    property ParentColor;
    property Font;
    property ParentFont;
    property Caption;
    property Hint;
    property ShowHint;
    property ParentShowHint;
  end;

  
  TNewFrame = class(TGraphicControl)
  private
    FLight, FShadow: TColor;
    FCaptionShadow: Boolean;
    procedure SetLight(const Value: TColor);
    procedure SetShadow(const Value: TColor);
    procedure SetCaptionShadow(const Value: Boolean);
  protected
    procedure CMApplyStyle(var msg: TMessage); message CM_APPLYSTYLE;
    procedure Paint; override;
    procedure CMEnableChange(var message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;    
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Light: TColor read FLight write SetLight default cLight;
    property Shadow: TColor read FShadow write SetShadow default cShadow;
    property CaptionShadow: Boolean read FCaptionShadow write SetCaptionShadow default False;
    property Font;
    property ParentFont;
    property Color;
    property ParentColor;
    property Caption;
  end;

procedure Register;

implementation

uses Math, CtrlCreate;

procedure Register;
begin
  RegisterComponents('Hoang', [
  TNewLabel,
  TNewFrame
  ]);
end;

{ TNewLabel }

procedure TNewLabel.AutoResize;
var
  r: TRect;
  Format: Cardinal;
  w, h: Integer;
  s: string;
begin
  if FShadow then r := Rect(0, 0, Width - 1, Height - 1)
  else r := Rect(0, 0, Width, Height);
  s := Caption;
  Canvas.Font := Font;
  Format := DT_NOCLIP or DT_CALCRECT;
  case FAlignment of
    taLeftJustify: Format := Format or DT_LEFT;
    taRightJustify: Format := Format or DT_RIGHT;
    taCenter: Format := Format or DT_CENTER;
  end;
  Canvas.Font := Font;
  w := 0;
  if FMultiLines then
    begin
      Format := Format or DT_WORDBREAK;
      h := DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
    end
  else
    begin
      Format := Format or DT_SINGLELINE;
      h := DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
      w:= r.Right;
    end;
  if FMultiLines then
    if FShadow then Height := h + 1
    else Height := h
  else
    if FShadow then
      begin
        Width := w + 1;
        Height := h + 1;
      end
    else
      begin
        Width := w;
        Height := h;
      end;
  Invalidate;
end;

procedure TNewLabel.CMApplyStyle(var msg: TMessage);
begin
  FShadowColor := cShadow;
  ParentColor := False;
  Color := cFace;
  ParentFont := False;
  Font := DefaultFont;
  Invalidate;
end;

procedure TNewLabel.CMEnableChange(var message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TNewLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if FAutoFit then AutoResize;
  Invalidate;
end;

procedure TNewLabel.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if FAutoFit then AutoResize;
  Invalidate;
end;

constructor TNewLabel.Create(aOwner: TComponent);
begin
  inherited;
  FAlignment := taLeftJustify;
  FMultiLines := False;
  FAutoFit := False;
  Width := 100;
  Height := 20;
  FShadow := False;
  FShadowColor := cShadow;
  FTransparent := False;
  controlstyle := controlstyle + [csSetCaption];
end;

procedure TNewLabel.Paint;
var
  r, r2: TRect;
  Format: Cardinal;
  s: string;
begin
  inherited;
  if not FTransparent then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
  if FShadow then r := Rect(0, 0, Width - 1, Height - 1)
  else r := Rect(0, 0, Width, Height);
  r2 := r;
  OffsetRect(r2, 1, 1);
  s := Caption;
  Canvas.Font := Font;
  SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
  Format := DT_NOCLIP;
  case FAlignment of
    taLeftJustify: Format := Format or DT_LEFT;
    taRightJustify: Format := Format or DT_RIGHT;
    taCenter: Format := Format or DT_CENTER;
  end;
  Canvas.Font := Font;
  if FMultiLines then
    begin
      Format := Format or DT_WORDBREAK;
      if not Enabled then
        begin
          Canvas.Font.Color := LightenColor(Color, 1.5);
          DrawText(Canvas.Handle, PChar(s), Length(s), r2, Format);
          Canvas.Font.Color := LightenColor(Color, 0.5);
          DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
        end
      else
        begin
          if FShadow then
            begin
              Canvas.Font.Color := FShadowColor;
              DrawText(Canvas.Handle, PChar(s), Length(s), r2, Format);
              Canvas.Font.Color := Font.Color;
            end;
          DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
        end;
    end
  else
    begin
      Format := Format or DT_SINGLELINE;
      if not Enabled then
        begin
          Canvas.Font.Color := LightenColor(Color, 1.5);
          DrawText(Canvas.Handle, PChar(s), Length(s), r2, Format);
          Canvas.Font.Color := LightenColor(Color, 0.5);
          DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
        end
      else
        begin
          if FShadow then
            begin
              Canvas.Font.Color := FShadowColor;
              DrawText(Canvas.Handle, PChar(s), Length(s), r2, Format);
              Canvas.Font.Color := Font.Color;
            end;
          DrawText(Canvas.Handle, PChar(s), Length(s), r, Format);
        end;
    end;
end;

procedure TNewLabel.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      Invalidate;
    end;
end;

procedure TNewLabel.SetAutoFit(const Value: Boolean);
begin
  if FAutoFit xor Value then
    begin
      FAutoFit := Value;
      if FAutoFit then AutoResize;
    end;
end;

procedure TNewLabel.SetMultiLines(const Value: Boolean);
begin
  if FMultiLines <> Value then
    begin
      FMultiLines := Value;
      if FAutoFit then AutoResize;
      Invalidate;
    end;
end;

procedure TNewLabel.SetShadow(const Value: Boolean);
begin
  if FShadow xor Value then
    begin
      FShadow := Value;
      If FAutoFit then AutoResize;
      invalidate;
    end;
end;

procedure TNewLabel.SetShadowColor(const Value: TColor);
begin
  FShadowColor := Value;
  Invalidate;
end;

procedure TNewLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent xor Value then
    begin
      FTransparent := Value;
      Invalidate;
    end;
end;

{ TNewFrame }

procedure TNewFrame.CMApplyStyle(var msg: TMessage);
begin
  Light := cLight;
  Shadow := cShadow;
  ParentColor := False;
  Color := cFace;
  ParentFont := False;
  Font := DefaultFont;
  FCaptionShadow := False;
  Invalidate;
end;

procedure TNewFrame.CMEnableChange(var message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TNewFrame.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TNewFrame.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TNewFrame.Create(aOwner: TComponent);
begin
  inherited;
  FLight := cLight;
  FShadow := cShadow;
  Width := 40; Height := 40;
end;

procedure TNewFrame.Paint;
var
  r: TRect;
begin
  inherited;
  Canvas.Font := Font;
  DoubleFrame(Canvas, 0, Canvas.TextHeight(Caption) div 2, Width - 1, Height - 1, FShadow, FLight, FLight, FShadow);
  r.Left := (Width - Canvas.TextWidth(Caption)) div 2;
  r.Top := 0;
  r.Right := R.Left + Canvas.TextWidth(Caption);
  r.Bottom := R.Top + Canvas.TextHeight(Caption);
  if FCaptionShadow then
    begin
      Inc(R.Right);
      Inc(R.Bottom);
    end;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(r);
  SetBkColor(Canvas.Handle, Color);
  SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
  if FCaptionShadow then
    begin
      Canvas.Font.Color := FShadow;
      DrawCap(Canvas, Width div 2 + 1, 0 + 1, Caption, $01, Canvas.Font.Color);
      Canvas.Font.Color := Font.Color;
    end;
  DrawCap(Canvas, Width div 2, 0, Caption, $01, Canvas.Font.Color);
end;

procedure TNewFrame.SetCaptionShadow(const Value: Boolean);
begin
  if FCaptionShadow xor Value then
    begin
      FCaptionShadow := Value;
      Invalidate;
    end;
end;

procedure TNewFrame.SetLight(const Value: TColor);
begin
  FLight := Value;
  Invalidate;
end;

procedure TNewFrame.SetShadow(const Value: TColor);
begin
  FShadow := Value;
  Invalidate;
end;

end.
