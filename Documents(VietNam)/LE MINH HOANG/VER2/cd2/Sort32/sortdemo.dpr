program SortDemo;

uses
  Forms,
  Main1U in 'Main1U.pas' {Main1},
  RInputU in 'RInputU.pas' {RInput};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sorting Algorithms Demo';
  Application.CreateForm(TMain1, Main1);
  Application.Run;
end.
