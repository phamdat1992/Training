unit ThemeApply;

interface

uses
  SysUtils, Classes, Controls;

type
  TThemeApply = class(TComponent)
  private
    FParentControl: TWinControl;
    procedure Applyfor1Control(Control: TControl);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Apply;
  published
    { Published declarations }
    property ParentControl: TWinControl read FParentControl write FParentControl;
  end;

procedure Register;

implementation

uses Forms, MyConst;

procedure Register;
begin
  RegisterComponents('Hoang', [TThemeApply]);
end;

{ TThemeApply }

procedure TThemeApply.Apply;
begin
  if Assigned(FParentControl) then
    Applyfor1Control(FParentControl);
end;

procedure TThemeApply.Applyfor1Control(Control: TControl);
var
  i: Integer;
begin
  Control.Perform(CM_APPLYSTYLE, 0, 0);
  if Control is TWinControl then
    with Control as TWinControl do
      for i := 0 to ControlCount - 1 do
        Applyfor1Control(Controls[i]);
end;

end.
