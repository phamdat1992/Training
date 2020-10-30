unit MyConst;

interface
uses Messages, Graphics;

const
  WM_ACTIVATEOLDINSTANCE = WM_USER + 1;
  WM_SCRSAVE             = WM_USER + 2;
  WM_NOTIFYICON          = WM_USER + 3;
  WM_EXIT                = WM_USER + 4;
  WM_SAFEPLAY            = WM_USER + 5;
  WM_SAFESTOP            = WM_USER + 6;
  CM_APPLYSTYLE          = WM_USER + 7;
  CM_UNDOSTYLE           = WM_USER + 8;

  cWindow                = $0060E0E0;
  cWindowText            = $00000000;
  cLight                 = $0080FFFF;
  cShadow                = $000097C0;
  cFace                  = $0040CBDF;
  cText                  = $00000000;
  cShortCut              = $000000FF;

  cTitleLight            = $00FFFF00;
  cTitleShadow           = $00800000;
  cTitleText             = $00FFFFFF;
  cTitleTextBackGround   = $00000080;
  cTitleTextInactive     = $00000000;
  cTitleTextBgrInactive  = $00C0C0C0;

  cSelectedLight         = $0080FF00;
  cSelectedShadow        = $00408000;
  cSelectedFace          = $0060C000;
  cSelectedText          = $00FFFFFF;
  cSelectedShortCut      = $0000FFFF;

  cDisableLight          = $00FFFFFF;
  cDisableShadow         = $00808080;
  cDisableFace           = $00C0C0C0;
  cDisableText           = $00808080;
  cDisableShortCut       = $00808080;

  cFocusArea             = $00FFFF00;

var
  DefaultFont: TFont;
implementation
initialization
  DefaultFont := TFont.Create;
  DefaultFont.Name := 'Microsoft Sans Serif';
  DefaultFont.Size := 8;
  DefaultFont.Style := [];
  DefaultFont.Color := cText;
{  DefaultFontEdit := TFont.Create;
  DefaultFontEdit.Name := 'Microsoft Sans Serif';
  DefaultFontEdit.Size := 8;
  DefaultFontEdit.Style := [];
  DefaultFontEdit.Color := cWindowText;}
finalization
  DefaultFont.Free;

end.
 