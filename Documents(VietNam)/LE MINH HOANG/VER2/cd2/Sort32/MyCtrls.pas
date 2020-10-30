unit MyCtrls;

interface
uses Controls, Classes, Forms;
type

  TNewCustomButton = class(TCustomControl)
  public
    constructor Create(aOwner: TComponent); override;
  published
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property Enabled;
    property Visible;
    property Font;
    property ParentFont;
    property Hint;
    property ShowHint;
    property ParentShowHint;
    property Caption;
    property TabStop default True;
    property TabOrder;
    property Cursor default 1;
  end;

  TNewGraphicButton = class(TGraphicControl)
  public
    constructor Create(aOwner: TComponent); override;
  published
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property Enabled;
    property Visible;
    property Font;
    property ParentFont;
    property Hint;
    property ShowHint;
    property ParentShowHint;
    property Caption;
    property Cursor default 1;
  end;

  TNewScrollingWinControl = class(TScrollingWinControl)
  end;

implementation
uses HGeneral, MyConst;
{ TNewCustomButton }

constructor TNewCustomButton.Create(aOwner: TComponent);
begin
  inherited;
  Cursor := crHand;
  TabStop := True;
  DoubleBuffered := True;
end;

{ TNewGraphicButton }

constructor TNewGraphicButton.Create(aOwner: TComponent);
begin
  inherited;
  Cursor := crHand;
end;


end.
