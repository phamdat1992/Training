unit RInputU;

interface

uses Forms, Windows, SysUtils, ThemeApply, FormTitleBars, StdCtrls, Controls, NewExtCtrls,
  HSCtls, NewStdCtrls, ComCtrls, Classes, MyCtrls, NewBtns;

type
  TRInput = class(TForm)
    OKBtn: TNewBtn;
    CancelBtn: TNewBtn;
    ThemeApply1: TThemeApply;
    NewFrame1: TNewFrame;
    Label1: TNewLabel;
    neNofKeys: TNumberEdit;
    NewLabel6: TNewLabel;
    neMin: TNumberEdit;
    Label3: TNewLabel;
    neMax: TNumberEdit;
    NewLabel3: TNewLabel;
    CL1: TNewListCheckBox;
    NewFrame2: TNewFrame;
    NewLabel1: TNewLabel;
    NewLabel2: TNewLabel;
    NewLabel4: TNewLabel;
    LabmNeeded1: TNewLabel;
    LabmNeeded2: TNewLabel;
    NewFrame3: TNewFrame;
    LabpmTotal: TNewLabel;
    LabpmFree: TNewLabel;
    FormTitleBar1: TFormTitleBar;
    procedure FormCreate(Sender: TObject);
    procedure CL1ClickCheck(Sender: TObject);
    procedure NumberEdit1Change(Sender: TObject);
    procedure NumberEdit2Change(Sender: TObject);
    procedure neNofKeysChange(Sender: TObject);
    procedure neMinChange(Sender: TObject);
    procedure neMaxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Recal;
  end;

var
  RInput: TRInput;
function RandomInput(var n, MinV, SupV: Integer): Boolean;

implementation
uses Math, Main1U;
{$R *.DFM}

function RandomInput(var n, MinV, SupV: Integer): Boolean;
var
  i: Integer;
begin
  RInput := TRInput.Create(Application);
  for i := 0 to 9 do
    if Main1U.Main1.SortList.Checked[i] then
      RInput.Cl1.Checked[i] := True;
  RInput.Recal;
  RInput.neNofKeys.Value := n;
  RInput.neMin.Value := MinV;
  RInput.neMax.Value := SupV - 1;
  RInput.ShowModal;
  if RInput.ModalResult = mrOK then
    begin
      n := RInput.neNOfKeys.Value;
      MinV := RInput.neMin.Value;
      SupV := Max(RInput.neMax.Value + 1, MinV + 1);
      for i := 0 to 9 do
        Main1U.Main1.SortList.Checked[i] := RInput.CL1.Checked[i];
      Result := True;
    end
  else
    Result := False;
end;

procedure TRInput.CL1ClickCheck(Sender: TObject);
begin
  ReCal;
end;

procedure TRInput.FormCreate(Sender: TObject);
begin
  ThemeApply1.ParentControl := Self;
  ThemeApply1.Apply;
end;

procedure TRInput.NumberEdit1Change(Sender: TObject);
begin
  Recal;
end;

procedure TRInput.NumberEdit2Change(Sender: TObject);
begin
  Recal;
end;

procedure TRInput.Recal;
const
  nUsed: array[0..9] of Int64 =
  (1, 1, 1, 1, 1, 1, 2, 1, 2, 2);
  mUsed: array[0..9] of Int64 =
  (0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
  NameArray: array[0..9] of string =
  (
    'SelectionSort',
    'BubbleSort',
    'InsertionSort',
    'ShellSort',
    'QuickSort',
    'HeapSort',
    'Distribution Counting',
    'Exchange Radix Sort',
    'Straight Radix Sort',
    'MergeSort'
  );
var
  i: Integer;
  n, m: Int64;
  TotalU, MaxU, U: Int64;
  MStatus: TMemoryStatus;
begin
  n := Max(neNofKeys.Value, 1);
  m := Max(neMax.Value, 0);
  TotalU := 1024;
  MaxU := 0;
  for i := 0 to 9 do
    if Cl1.Checked[i] then
      begin
        U := nUsed[i] * n + mUsed[i] * m;
        TotalU := TotalU + U;
        MaxU := Max(MaxU, U);
        Cl1.Items[i] := NameArray[i] + ' (' + FloatToStrF(U * 4 / (1 shl 20), ffFixed, 18, 2) + ' MB)';
      end
    else
      Cl1.Items[i] := NameArray[i];
  LabmNeeded1.Caption := 'Memory needed for executing synchronously: ' +
                         FloatToStrF(TotalU * 4 / (1 shl 20), ffFixed, 18, 2) + ' MB';
  LabmNeeded2.Caption := 'Memory needed for executing asynchronously: ' +
                         FloatToStrF(MaxU * 4 / (1 shl 20), ffFixed, 18, 2) + ' MB';
  MStatus.dwLength := SizeOf(MStatus);
  GlobalMemoryStatus(MStatus);
  LabpmTotal.Caption := 'Total: ' + FloatToStrF(MStatus.dwTotalPhys / (1 shl 20), ffFixed, 18, 2) + ' MB';
  LabpmFree.Caption := 'Free: ' + FloatToStrF(MStatus.dwAvailPhys / (1 shl 20), ffFixed, 18, 2) + ' MB';
end;

procedure TRInput.neNofKeysChange(Sender: TObject);
begin
  Recal;
end;

procedure TRInput.neMinChange(Sender: TObject);
begin
  Recal;
end;

procedure TRInput.neMaxChange(Sender: TObject);
begin
  Recal;
end;

end.
