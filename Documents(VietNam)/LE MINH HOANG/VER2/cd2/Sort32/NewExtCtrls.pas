unit NewExtCtrls;

interface

uses
  SysUtils, Classes, Forms, Types, Messages, Controls, Graphics, NewBtns, MyConst;

type

  TNewPanel = class(TCustomControl)
  private
    FBorderWidth: Integer;
    FBevelOuter: TBevelCut;
    FBevelInner: TBevelCut;
    FSmoothing: Boolean;
    procedure SetBevelInner(const Value: TBevelCut);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetSmoothing(const Value: Boolean);
    procedure SetBevelOuter(const Value: TBevelCut);
  protected
    function GetClientRect: TRect; override;
    procedure ClientChanged; virtual;
    procedure Paint; override;
    procedure Resize; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Align;
    property BevelInner: TBevelCut read FBevelInner write SetBevelInner default bvLowered;
    property BevelOuter: TBevelCut read FBevelOuter write SetBevelOuter default bvRaised;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth default 2;
    property Smoothing: Boolean read FSmoothing write SetSmoothing default False;
    property Font;
    property ParentFont;
  end;

  TNewListCheckBoxKind = (lcbCheck, lcbRadio);
  TNewListCheckBox = class(TNewPanel)
  private
    { Private declarations }
    FItems: TStringList;
    FKind: TNewListCheckBoxKind;
    FBoxes: array of TNewCheckBox;
    FItemSpace: Integer;
    FOnClickCheck: TNotifyEvent;
    function GetItems: TStrings;
    procedure SetItems(const Value: TStrings);
    procedure FItemsChange(Sender: TObject);
    procedure SetKind(const Value: TNewListCheckBoxKind);
    procedure RealignControls;
    procedure SetItemSpace(const Value: Integer);
    function GetChecked(Index: Integer): Boolean;
    procedure SetChecked(Index: Integer; const Value: Boolean);
    procedure BoxClick(Sender: TObject);
  protected
    { Protected declarations }
    procedure RecreateBoxes;
    procedure ClientChanged; override;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
  published
    { Published declarations }
    property Items: TStrings read GetItems write SetItems;
    property Kind: TNewListCheckBoxKind read FKind write SetKind default lcbCheck;
    property ItemSpace: Integer read FItemSpace write SetItemSpace default 1;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
  end;

procedure Register;

implementation

uses Math, CtrlCreate;

procedure Register;
begin
  RegisterComponents('Hoang', [TNewPanel, TNewListCheckBox]);
end;

{ TNewPanel }

procedure TNewPanel.ClientChanged;
begin
  ReAlign;
  Invalidate;
end;

constructor TNewPanel.Create(aOwner: TComponent);
begin
  inherited;
  FBevelInner := bvLowered;
  FBevelOuter := bvRaised;
  FBorderWidth := 2;
  FSmoothing := False;
  ControlStyle := ControlStyle + [csAcceptsControls];
  DoubleBuffered := True;
end;

function TNewPanel.GetClientRect: TRect;
begin
  Result := Rect(FBorderWidth, FBorderWidth, Width - FBorderWidth, Height - FBorderWidth);
end;

procedure TNewPanel.Paint;
var
  c1, c2, c3, c4: TColor;
  t: Integer;
  x: Single;
begin
  inherited;
  Canvas.Brush.Color := cFace;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  case FBevelOuter of
    bvLowered:
      begin
        c1 := cShadow; c2 := cLight;
      end;
    bvRaised:
      begin
        c1 := cLight; c2 := cShadow;
      end;
    else
      begin
        c1 := cFace; c2 := cFace;
      end;
  end;
  if FBorderWidth < 2 then Exit;
  case FBevelInner of
    bvLowered:
      begin
        c3 := GradientColor(cShadow, cLight, 0.25); c4 := GradientColor(cLight, cShadow, 0.25);
      end;
    bvRaised:
      begin
        c3 := GradientColor(cLight, cShadow, 0.25);; c4 := GradientColor(cShadow, cLight, 0.25)
      end;
    else
      begin
        c3 := cFace; c4 := cFace;
      end;
  end;
  if FSmoothing then
    for t := 0 to FBorderWidth - 1 do
      begin
        if t < FBorderWidth div 2 then
          begin
            x := t / (FBorderWidth div 2);
            Frame(Canvas, t, t, Width - t - 1, Height - t - 1, GradientColor(c1, cFace, x), GradientColor(c2, cFace, x));
          end
        else
          begin
            if t = FBorderWidth - 1 then x := 1
            else
              x := (t - FBorderWidth div 2) / (FBorderWidth - 1 - FBorderWidth div 2);
            Frame(Canvas, t, t, Width - t - 1, Height - t - 1, GradientColor(cFace, c3, x), GradientColor(cFace, c4, x));
          end
      end
  else
    begin
      Frame(Canvas, 0, 0, Width - 1, Height - 1, c1, c2);
      Frame(Canvas, FBorderWidth - 1, FBorderWidth - 1, Width - FBorderWidth, Height - FBorderWidth, c3, c4);
    end;
end;

procedure TNewPanel.Resize;
begin
  inherited;
  ClientChanged;
  Invalidate;
end;

procedure TNewPanel.SetBevelInner(const Value: TBevelCut);
begin
  if FBevelInner <> Value then
    begin
      FBevelInner := Value;
      Invalidate;
    end;
end;

procedure TNewPanel.SetBevelOuter(const Value: TBevelCut);
begin
  if BevelOuter <> Value then
    begin
      FBevelOuter := Value;
      Invalidate;
    end;
end;

procedure TNewPanel.SetBorderWidth(const Value: Integer);
begin
  if FBorderWidth <> Value then
    begin
      FBorderWidth := Value;
      ClientChanged;
    end;
end;

procedure TNewPanel.SetSmoothing(const Value: Boolean);
begin
  if FSmoothing xor Value then
    begin
      FSmoothing := Value;
      Invalidate;
    end;
end;

{ TNewListCheckBox }

procedure TNewListCheckBox.BoxClick(Sender: TObject);
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;

procedure TNewListCheckBox.ClientChanged;
begin
  inherited;
  RealignControls;
end;

constructor TNewListCheckBox.Create(aOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  FItems.OnChange := FItemsChange;
  FKind := lcbCheck;
  Width := 100;
  Height := 80;
  FItemSpace := 1;
  ControlStyle := ControlStyle - [csAcceptsControls];
end;

destructor TNewListCheckBox.Destroy;
var
  i: Integer;
begin
  for i := High(FBoxes) downto 0 do FBoxes[i].Free;
  FItems.Free;
  FBoxes := nil;
  inherited;
end;

procedure TNewListCheckBox.FItemsChange(Sender: TObject);
begin
  RecreateBoxes;
end;

function TNewListCheckBox.GetChecked(Index: Integer): Boolean;
begin
  Result := FBoxes[Index].Checked;
end;

function TNewListCheckBox.GetItems: TStrings;
begin
  Result := FItems;
end;

procedure TNewListCheckBox.RealignControls;
var
  i: Integer;
  t, l, h: Integer;
begin
  t := FBorderWidth;
  l := FBorderWidth;
  if Length(FBoxes) > 0 then h := Max((Height - 2 * FBorderWidth - High(FBoxes) * FItemSpace) div Length(FBoxes), 0)
  else h := 0;
  for i := 0 to High(FBoxes) do
   begin
     FBoxes[i].Left := l + FItemSpace; FBoxes[i].Top := t;
     FBoxes[i].Width := Width - 2 * FBorderWidth - 2 * FItemSpace;
     FBoxes[i].Height := h;
     t := t + h + FItemSpace;
   end;
end;

procedure TNewListCheckBox.RecreateBoxes;
var
  i: Integer;
begin
  if Length(FBoxes) = FItems.Count then
    for i := 0 to FItems.Count - 1 do
      FBoxes[i].Caption := FItems.Strings[i]
  else
    begin
      for i := High(FBoxes) downto 0 do
        FBoxes[i].Free;
      SetLength(FBoxes, FItems.Count);
      for i := 0 to FItems.Count - 1 do
        begin
          if FKind = lcbCheck then FBoxes[i] := TNewCheckBox.Create(Self)
          else FBoxes[i] := TNewRadioButton.Create(Self);
          FBoxes[i].Parent := Self;
          FBoxes[i].Caption := FItems.Strings[i];
          FBoxes[i].OnClick := BoxClick;
        end;
    end;
  RealignControls;
end;

procedure TNewListCheckBox.SetChecked(Index: Integer;
  const Value: Boolean);
begin
  if InRange(Index, 0, High(FBoxes)) then
    FBoxes[Index].Checked := Value;
end;

procedure TNewListCheckBox.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TNewListCheckBox.SetItemSpace(const Value: Integer);
begin
  if FItemSpace <> Value then
    begin
      FItemSpace := Value;
      RealignControls;
    end;
end;

procedure TNewListCheckBox.SetKind(const Value: TNewListCheckBoxKind);
begin
  FKind := Value;
  RecreateBoxes;
end;

end.
