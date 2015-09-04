object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Monitoramento de p'#225'ginas'
  ClientHeight = 510
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Browser: TWebBrowser
    Left = 0
    Top = 27
    Width = 760
    Height = 397
    Align = alClient
    TabOrder = 0
    OnDownloadComplete = BrowserDownloadComplete
    ExplicitLeft = 212
    ExplicitTop = 30
    ExplicitWidth = 554
    ExplicitHeight = 483
    ControlData = {
      4C0000008C4E0000082900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      760
      27)
    object edtURL: TEdit
      Left = 2
      Top = 2
      Width = 688
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = edtURLKeyPress
    end
    object edtTimeReload: TSpinEdit
      Left = 696
      Top = 2
      Width = 62
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 5
      OnChange = edtTimeReloadChange
    end
  end
  object lbxMudancas: TListBox
    Left = 0
    Top = 424
    Width = 760
    Height = 86
    Align = alBottom
    ItemHeight = 13
    TabOrder = 2
  end
  object TimerReload: TTimer
    Enabled = False
    Interval = 50000
    OnTimer = TimerReloadTimer
    Left = 568
    Top = 192
  end
  object Tray: TTrayIcon
    BalloonHint = 'Nenhuma novidade'
    BalloonTitle = 'Status da sua p'#225'gina'
    BalloonTimeout = 120000
    BalloonFlags = bfWarning
    Visible = True
    Left = 568
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    Left = 568
    Top = 80
  end
end
