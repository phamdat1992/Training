unit HGeneral;

interface
uses Windows, Sysutils, Forms;
const
  crHand = 1;
var
  MyDir, TempDir, MyApp, MyParams: string;
  WinNT: Boolean;
  HandCursor, NoneCursor, WaitCursor, ArrowCursor, HandFreeCursor, HandReadyCursor: HCURSOR;

function MyName: string;
procedure WinExecAndWait(FileName, Parameter: string);
procedure WinExecNoWait(FileName, Parameter: string); overload;
procedure WinExecNoWait(Handle: HWND; FileName, Parameter: string); overload;
procedure WinExecNoWait(Handle: HWND; opt, FileName, Parameter: string); overload;
procedure WinExecNoWait(Handle: HWND; opt, FileName, Parameter: string; mode: Integer); overload;

implementation
uses ShellApi;
{$R HandCur.Res}

function MyName: string;
begin
  Result := 'Le Minh Hoang';
end;

procedure Init;
var
  i: Integer;
  vInfo: TOSVersionInfo;
  a: array[0..MAX_PATH] of Char;
begin
  Randomize;
  MyApp := Application.ExeName;
  MyDir := MyApp;
  i := Length(MyDir);
  while MyDir[i] <> '\' do dec(i);
  Delete(MyDir, i, Length(MyDir) - i + 1);
  WaitCursor := LoadCursor(0, IDC_WAIT);
  ArrowCursor := LoadCursor(0, IDC_ARROW);
  HandCursor := LoadCursor(HInstance, 'HANDCUR');
  NoneCursor := LoadCursor(HInstance, 'NONECUR');
  HandFreeCursor := LoadCursor(HInstance, 'HANDFREE');
  HandReadyCursor := LoadCursor(HInstance, 'HANDREADY');
  Screen.Cursors[1] := HandCursor;
  Screen.Cursors[2] := NoneCursor;
  Screen.Cursors[3] := HandFreeCursor;
  Screen.Cursors[4] := HandReadyCursor;
  vInfo.dwOSVersionInfoSize := SizeOf(vInfo);
  GetVersionEx(vInfo);
  WinNT := vInfo.dwPlatformId = VER_PLATFORM_WIN32_NT;
  MyParams := '';
  for i := 1 to ParamCount - 1 do MyParams := MyParams + ParamStr(i) + ' ';
  MyParams := MyParams + ParamStr(ParamCount);
  GetTempPath(MAX_PATH, a);
  TempDir := String(a);
  if TempDir[Length(TempDir)] = '\' then Delete(TempDir, Length(TempDir), 1);
end;

procedure Destroy;
begin
  DeleteObject(WaitCursor);
  DeleteObject(ArrowCursor);
  DeleteObject(HandCursor);
  DeleteObject(NoneCursor);
end;

procedure WinExecAndWait(FileName: string; Parameter: string);
var
  proc_info: TProcessInformation;
  startinfo: TStartupInfo;
begin
  FillChar(proc_info, sizeof(TProcessInformation), 0);
  FillChar(startinfo, sizeof(TStartupInfo), 0);
  startinfo.cb := sizeof(TStartupInfo);
  if CreateProcess(PChar(FileName), PChar('"' + FileName + '" ' + Parameter), nil,
      nil, false, NORMAL_PRIORITY_CLASS, nil, nil,
       startinfo, proc_info) <> False then
    begin
      WaitForSingleObject(proc_info.hProcess, INFINITE);
      CloseHandle(proc_info.hThread);
      CloseHandle(proc_info.hProcess);
    end;
end;

procedure WinExecNoWait(FileName: string; parameter: string); overload
begin
  ShellExecute(Application.Handle, 'open', PChar(FileName), PChar(parameter), '', 0);
end;

procedure WinExecNoWait(Handle: HWND; FileName: string; parameter: string); overload
begin
  ShellExecute(Handle, nil, PChar(FileName), PChar(parameter), '', 0);
end;

procedure WinExecNoWait(Handle: HWND; opt, FileName, Parameter: string); overload;
begin
  ShellExecute(Handle, PChar(opt), PChar(FileName), PChar(parameter), '', 0);
end;

procedure WinExecNoWait(Handle: HWND; opt, FileName, Parameter: string; mode: Integer); overload;
begin
  ShellExecute(Handle, PChar(opt), PChar(FileName), PChar(parameter), '', mode);
end;

initialization
  Init;
finalization
  Destroy;
end.
