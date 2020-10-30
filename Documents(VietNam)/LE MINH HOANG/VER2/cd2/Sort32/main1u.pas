unit Main1U;

interface

uses
  Forms, Windows, Graphics, Messages, SysUtils, SortA, MyConst, ThemeApply,
  Dialogs, FormTitleBars, ExtCtrls, Controls, StdCtrls, HSCtls, MyCtrls,
  NewBtns, NewExtCtrls, NewStdCtrls, Classes;
const
  nA = 10;
type
  TVisualDisplayFunc = function (UsingSource: Boolean): Boolean of Object;
  TMain1 = class(TForm)
    NewPanel1: TNewPanel;
    ControlPanel: TNewPanel;
    SortList: TNewListCheckBox;
    BtnLoad: TNewBtn;
    BtnRandom: TNewBtn;
    BtnSave: TNewBtn;
    BtnSynch: TNewBtn;
    BtnAsynch: TNewBtn;
    ComboBox1: TFSCombobox;
    Od1: TOpenDialog;
    Sd1: TSaveDialog;
    ThemeApply1: TThemeApply;
    FormTitleBar1: TFormTitleBar;
    DisplayPanel: TNewPanel;
    PaintBox1: TPaintBox;
    NewLabel1: TNewLabel;
    NewLabel2: TNewLabel;
    NewLabel3: TNewLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnLoadClick(Sender: TObject);
    procedure BtnRandomClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure SortListClickCheck(Sender: TObject);
    procedure BtnSynchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure BtnAsynchClick(Sender: TObject);
    procedure FormTitleBar1FormResize(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    k: TArray;
    n, MinV, SupV: Integer;
    nIndex: Integer;
    thd: array[0..9] of TSortThread;
    Index: array of Integer;
    tmp: array of Integer;
    x: array of Integer;
    VisualDisplay: TVisualDisplayFunc;
    MethodLab: array[0..nA - 1] of TStaticText;
    procedure CreateIndex;
    procedure CalculatePosition;
    function VisualDisplay1(UsingSource: Boolean): Boolean;
    function VisualDisplay2(UsingSource: Boolean): Boolean;
    function VisualDisplay3(UsingSource: Boolean): Boolean;
    function VisualDisplay4(UsingSource: Boolean): Boolean;
    procedure SetCaptionWithTimeToMethodLabs;
    procedure SetCaptionToMethodLabs;
  protected
    procedure WMNCHittest(var message: TWMNCHITTEST); message WM_NCHITTEST;
  public
    { Public declarations }
  end;

var
  Main1: TMain1;
  C0, C1, C2: TColor;

implementation
uses Hgeneral, RInputU;
{$R *.DFM}

{TMain1}

procedure TMain1.BtnAsynchClick(Sender: TObject);
var
  i: Integer;
begin
  SetCursor(WaitCursor);
  PaintBox1.Repaint;
  CalculatePosition;
  for i := 0 to nA - 1 do
    MethodLab[i].Refresh;
  Application.ProcessMessages;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Thd[i].tag := 1;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then
      begin
        Thd[i].LoadData(k, n, SupV);
        SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
        SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
        Thd[i].SortObject.Start;
        Thd[i].Stopped := True;
        Thd[i].tag := 0;
        VisualDisplay(False);
        SetCaptionWithTimeToMethodLabs;
        SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);
        SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
        Thd[i].FreeData;
      end;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Thd[i].tag := 0;
  SetCursor(ArrowCursor);
end;

procedure TMain1.BtnLoadClick(Sender: TObject);
var
  f: TextFile;
  t: Integer;
begin
  if not Od1.Execute then Exit;
  SetCursor(WaitCursor);
  n := 0; SetLength(k, 1);
  AssignFile(f, Od1.Filename); Reset(f);
  {$I-}
  while not SeekEof(f) do
    begin
      Read(f, t);
      if IOResult <> 0 then Break;
      Inc(n);
      SetLength(k, n + 1);
      k[n] := t;
      if n = 1 then
        begin
          minV := t; supV := t;
        end
      else
        if t < minV then minV := t
        else
          if t > supV then supV := t;
    end;
  {$I+}
  CloseFile(f);
  Inc(supV);
  CreateIndex;
  SetCursor(ArrowCursor);
  PaintBox1.Repaint;
  SetCaptionToMethodLabs;
end;

procedure TMain1.BtnRandomClick(Sender: TObject);
var
  i: Integer;
begin
  if RandomInput(n, MinV, SupV) then
    begin
      SetLength(k, n + 1);
      for i := 1 to n do k[i] := Random(supV - minV) + minV;
      CreateIndex;
      CalculatePosition;
    end;
end;

procedure TMain1.BtnSaveClick(Sender: TObject);
var
  f: TextFile;
  i: Integer;
begin
  if not Sd1.Execute then Exit;
  SetCursor(WaitCursor);
  AssignFile(f, Sd1.FileName); Rewrite(f);
  for i := 1 to n do
    begin
      Write(f, k[i]: 9, ' ');
      if i mod 8 = 0 then Writeln(f);
    end;
  CloseFile(f);
  SetCursor(ArrowCursor);
end;

procedure TMain1.BtnSynchClick(Sender: TObject);
var
  i: Integer;
begin
  SetCursor(WaitCursor);
  CalculatePosition;
  Application.ProcessMessages;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then
      Thd[i].LoadData(k, n, SupV);
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then
      Thd[i].Priority := tpTimeCritical;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then
      Thd[i].Resume;
  repeat
  until not VisualDisplay(False);
  SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then
      Thd[i].Priority := tpNormal;
  SetCaptionWithTimeToMethodLabs;
  for i := nA - 1 downto 0 do
    if Thd[i] <> nil then
      begin
        Thd[i].FreeData;
        Thd[i].tag := 0;
      end;
  SetCursor(ArrowCursor);
end;

procedure TMain1.CalculatePosition;
var
  i, count, c: Integer;
begin
  for i := 0 to 9 do
    if Thd[i] <> nil then
      begin
        Thd[i].Free;
        Thd[i] := nil;
        MethodLab[i].Visible := False;
      end;
  count := 0;
  for i := 0 to 9 do
    if SortList.Checked[i] then
      begin
        Thd[i] := TSortThread.Create(ListSortA[i]);
        Thd[i].tag := 0;  //tag = 0 means the thread is running or has done but hasn't been displayed
        Inc(Count);
      end;
  c := 0;
  for i := 0 to 9 do
    if SortList.Checked[i] then
      begin
        MethodLab[i].Top := PaintBox1.Height div Count * c + PaintBox1.Top;
        MethodLab[i].Visible := True;
        Inc(c);
      end;
  SetCaptiontoMethodLabs;
  PaintBox1.Repaint;
end;

procedure TMain1.ComboBox1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: VisualDisplay := VisualDisplay1;
    1: begin
         CreateIndex;
         VisualDisplay := VisualDisplay2;
       end;
    2: VisualDisplay := VisualDisplay3;
    3: VisualDisplay := VisualDisplay4;
  end;
  PaintBox1.Repaint;
end;

procedure TMain1.CreateIndex; //Indexes for uniform position
var
  i: Integer;
begin
  if PaintBox1.Width div 2 < n then nIndex := PaintBox1.Width div 2
  else nIndex := n;
  SetLength(Index, nIndex);
  SetLength(x, nIndex);
  SetLength(tmp, nIndex);
  Index[0] := 1;
  for i := 1 to nIndex - 1 do
    begin
      Index[i] := Round(i / (nIndex - 1) * (n - 1)) + 1;
      x[i] := i * 2;
    end;
  for i := 0 to nIndex - 2 do
    tmp[i] := Index[i] + Random(Index[i + 1] - Index[i]);
  tmp[nIndex - 1] := Index[nIndex - 1];
end;

procedure TMain1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Thd[i].Free;
  k := nil;
  Index := nil;
  x := nil;
  tmp := nil;
end;

procedure TMain1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Randomize;
  n := 20000;
  SetLength(k, n + 1); SupV := 20001; minV := 0;
  for i := 1 to n do k[i] := Random(SupV - minV) + minV;
  CreateIndex;
  ZeroMemory(@Thd, SizeOf(Thd));
  VisualDisplay := VisualDisplay2;
  for i := 0 to nA - 1 do
    begin
      MethodLab[i] := TStaticText.Create(NewPanel1);
      MethodLab[i].Parent := DisplayPanel;
      MethodLab[i].Visible := False;
      MethodLab[i].Left := PaintBox1.Left;
      MethodLab[i].Color := cWindow;
    end;
  SortList.Hint := 'You shouldn''t use bubble, selection or insertion sort if'
                   + ' you have >= 100000 keys';
end;

procedure TMain1.FormResize(Sender: TObject);
begin
  CreateIndex;
end;

procedure TMain1.FormTitleBar1FormResize(Sender: TObject);
begin
  FormTitleBar1.AlignFormControl(NewPanel1, alClient);
  CalculatePosition;
  CreateIndex;
end;

procedure TMain1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintBox1.Repaint;
  SetCaptionToMethodLabs;
end;
procedure TMain1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Brush.Color := c0;
  PaintBox1.Canvas.FillRect(Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
  VisualDisplay(True);
end;

procedure TMain1.SetCaptionToMethodLabs;
var
  i: Integer;
begin
  for i := 0 to nA - 1 do
    if MethodLab[i].Visible then
      begin
        MethodLab[i].Caption := ' ' + SortList.Items[i] + ' ';
        MethodLab[i].Refresh;
      end;
end;

procedure TMain1.SetCaptionWithTimeToMethodLabs;
var
  i: Integer;
  s: string;
begin
  for i := 0 to nA - 1 do
    if (Thd[i] <> nil) and MethodLab[i].Visible and Thd[i].Stopped and Assigned(Thd[i].SortObject) then
      begin
        s := Thd[i].SortObject.DStr;
        MethodLab[i].Caption := ' ' + SortList.Items[i] + ': ' + s;
        MethodLab[i].Repaint;
      end;
end;

procedure TMain1.SortListClickCheck(Sender: TObject);
begin
  CalculatePosition;
end;

function TMain1.VisualDisplay1(UsingSource: Boolean): Boolean;  (*Random position*)
var
  i, j, Count: Integer;
  Done: Boolean;
  Ratio: Extended;
  H, Y: Integer;
  tmparr: TArray;
begin
  tmparr := nil;
  Result := False;
  Count := 0;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Inc(Count);
  if Count <> 0 then H := PaintBox1.Height div Count - 1
  else H := 0;
  if SupV <> 0 then Ratio := (H - 1) / SupV
  else Ratio := 1;
  Y := 0;
  tmp[0] := Index[0];
  for j := 1 to nIndex - 1 do
    tmp[j] := Random(Index[j] - Index[j - 1]) + Index[j - 1] + 1;
  with PaintBox1.Canvas do
    for i := 0 to 9 do
      if Thd[i] <> nil then
        begin
          if UsingSource or (Thd[i].tag = 0) then //tag = 0 means the thread is running or has done but hasn't been displayed
            begin
              Done := Thd[i].Stopped;
              if UsingSource then tmparr := k
              else tmparr := Thd[i].SortObject.Active;
              if Done and not UsingSource then Pen.Color := C2
              else Pen.Color := C1;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H);
                  LineTo(X[j], Y + H - Round(tmparr[tmp[j]] * Ratio));
                end;
              Pen.Color := C0;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H - Round(tmparr[tmp[j]] * Ratio));
                  LineTo(X[j], Y + 1);
                end;
              Result := Result or not Done;
              if Done then Thd[i].tag := 1; //the thread has done and been displayed
            end;
          Y := Y + H + 1;
        end;
end;

function TMain1.VisualDisplay2(UsingSource: Boolean): Boolean;  (*Predefined position*)
var
  i, j, Count: Integer;
  Done: Boolean;
  Ratio: Extended;
  H, Y: Integer;
  tmparr: TArray;
begin
  tmparr := nil;
  Result := False;
  Count := 0;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Inc(Count);
  if Count <> 0 then H := PaintBox1.Height div Count - 1
  else H := 0;
  if SupV <> 0 then Ratio := (H - 1) / SupV
  else Ratio := 1;
  Y := 0;
  with PaintBox1.Canvas do
    for i := 0 to 9 do
      if Thd[i] <> nil then
        begin
          if UsingSource or (Thd[i].tag = 0) then
            begin
              Done := Thd[i].Stopped;
              if UsingSource then tmparr := k
              else tmparr := Thd[i].SortObject.Active;
              if Done and not UsingSource then Pen.Color := C2
              else Pen.Color := C1;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H);
                  LineTo(X[j], Y + H - Round(tmparr[tmp[j]] * Ratio));
                end;
              Pen.Color := C0;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H - Round(tmparr[tmp[j]] * Ratio));
                  LineTo(X[j], Y);
                end;
              Result := Result or not Done;
              if Done then Thd[i].tag := 1;
            end;
          Y := Y + H + 1;
        end;
end;

function TMain1.VisualDisplay3(UsingSource: Boolean): Boolean;  (*Average of Neighborhood*)
var
  i, j, Count, t: Integer;
  i64: Int64;
  Done: Boolean;
  Ratio: Extended;
  H, Y: Integer;
  tmparr: TArray;
begin
  tmparr := nil;
  Result := False;
  Count := 0;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Inc(Count);
  if Count <> 0 then H := PaintBox1.Height div Count - 1
  else H := 0;
  if SupV <> 0 then Ratio := (H - 1) / SupV
  else Ratio := 1;
  Y := 0;
  with PaintBox1.Canvas do
    for i := 0 to 9 do
      if Thd[i] <> nil then
        begin
          if UsingSource or (Thd[i].tag = 0) then
            begin
              Done := Thd[i].Stopped;
              if UsingSource then tmparr := k
              else tmparr := Thd[i].SortObject.Active;
              for j := 0 to nIndex - 2 do
                begin
                  i64 := 0;
                  for t := Index[j] to Index[j + 1] - 1 do
                    i64 := i64 + tmparr[t];
                  tmp[j] := i64 div (Index[j + 1] - Index[j]);
                end;
              if Done and not UsingSource then Pen.Color := C2
              else Pen.Color := C1;
              for j := 0 to nIndex - 2 do
                begin
                  MoveTo(X[j], Y + H);
                  LineTo(X[j], Y + H - Round(tmp[j] * Ratio));
                end;
              Pen.Color := C0;
              for j := 0 to nIndex - 2 do
                begin
                  MoveTo(X[j], Y + H - Round(tmp[j] * Ratio));
                  LineTo(X[j], Y);
                end;
              Result := Result or not Done;
              if Done then Thd[i].tag := 1;
            end;
          Y := Y + H + 1;
        end;
end;

function TMain1.VisualDisplay4(UsingSource: Boolean): Boolean;  (*Uniform position*)
var
  i, j, Count: Integer;
  Done: Boolean;
  Ratio: Extended;
  H, Y: Integer;
  tmparr: TArray;
begin
  Result := False;
  tmparr := nil;
  Count := 0;
  for i := 0 to nA - 1 do
    if Thd[i] <> nil then Inc(Count);
  if Count <> 0 then H := PaintBox1.Height div Count - 1
  else H := 0;
  if SupV <> 0 then Ratio := (H - 1) / SupV
  else Ratio := 1;
  Y := 0;
  with PaintBox1.Canvas do
    for i := 0 to 9 do
      if Thd[i] <> nil then
        begin
          if UsingSource or (Thd[i].tag = 0) then
            begin
              Done := Thd[i].Stopped;
              if UsingSource then tmparr := k
              else tmparr := Thd[i].SortObject.Active;
              if Done and not UsingSource then Pen.Color := C2
              else Pen.Color := C1;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H);
                  LineTo(X[j], Y + H - Round(tmparr[Index[j]] * Ratio));
                end;
              Pen.Color := C0;
              for j := 0 to nIndex - 1 do
                begin
                  MoveTo(X[j], Y + H - Round(tmparr[Index[j]] * Ratio));
                  LineTo(X[j], Y);
                end;
              Result := Result or not Done;
              if Done then Thd[i].tag := 1;
            end;
          Y := Y + H + 1;
        end;
end;

procedure TMain1.WMNCHittest(var message: TWMNCHITTEST);
var
  r: LResult;
begin
  inherited;
  r := FormTitleBar1.WMNCHITTESTHandle(message);
  if r <> 0 then message.Result := r;
end;

initialization
  C0 := $00000000;
  C1 := $0080FF00;
  C2 := $0000FFFF;
end.
