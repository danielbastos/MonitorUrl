unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw, ActiveX, Vcl.Menus;

type
  TfrmMain = class(TForm)
    Browser: TWebBrowser;
    Panel1: TPanel;
    edtURL: TEdit;
    edtTimeReload: TSpinEdit;
    TimerReload: TTimer;
    lbxMudancas: TListBox;
    Tray: TTrayIcon;
    PopupMenu1: TPopupMenu;
    procedure edtURLKeyPress(Sender: TObject; var Key: Char);
    procedure TimerReloadTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTimeReloadChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BrowserDownloadComplete(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    config : TStringList;
    lastPage : TStringStream;
    procedure changeTime;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  root : string;

implementation

{$R *.dfm}

procedure WebSaveToFile(WebBrowser: TWebBrowser; const Filename: String);
var
  StrInit: IPersistStreamInit;
  f : TFileStream;
begin
  f := TFileStream.Create(Filename, fmCreate);
  if Succeeded(WebBrowser.Document.QueryInterface(IPersistStreamInit, StrInit)) then
    StrInit.Save(TStreamAdapter.Create(f, soOwned), False);
  f.Free;
end;

procedure TfrmMain.edtURLKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Browser.Navigate(edtURL.Text);
    changeTime;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  config.Clear;
  config.Add('url='+edtURL.Text);
  config.Add('time='+IntToStr(edtTimeReload.Value));
  config.SaveToFile(root+'config.txt');
  tray.Visible := false;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  root := ExtractFilePath(Application.ExeName);
  config := TStringList.Create;
  lastPage := TStringStream.Create;

  if FileExists(root+'current.html') then
    lastPage.LoadFromFile(root+'current.html');

  if FileExists(root+'config.txt') then
  begin
    config.LoadFromFile(root+'config.txt');
    edtURL.Text :=config.Values['url'];
    edtTimeReload.Text :=config.Values['time'];
    changeTime;
    Browser.Navigate(edtURL.Text);
  end;
  ForceDirectories(root+'history\');
//  Browser.OnPropertyChange
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  config.Free;
  lastPage.Free;
end;

procedure TfrmMain.BrowserDownloadComplete(Sender: TObject);
var
  StrInit: IPersistStreamInit;
  stream : TStringStream;

begin
  //WebSaveToFile(Browser, root+'current.html');
  edtURL.Text := Browser.LocationURL;
  stream := TStringStream.Create;
  if Succeeded(browser.Document.QueryInterface(IPersistStreamInit, StrInit)) then
  begin
    StrInit.Save(TStreamAdapter.Create(stream, soOwned), False);
    if stream.DataString <> lastPage.DataString then
    begin
      lastPage.LoadFromStream(stream);
      stream.SaveToFile(root+'current.html');
      stream.SaveToFile(root+'history\'+ FormatDateTime('yyyymmddhhnnss', now())+'.html');
      tray.BalloonHint := 'Existe uma modificação no seu monitoramento';
      lbxMudancas.Items.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', now()));
      tray.ShowBalloonHint();
    end;

  end;
  stream.Free;
end;

procedure TfrmMain.changeTime;
begin
  TimerReload.Enabled := false;
  TimerReload.Interval := edtTimeReload.Value * 60000;
  TimerReload.Enabled := true;
end;

procedure TfrmMain.edtTimeReloadChange(Sender: TObject);
begin
  changeTime;
end;

procedure TfrmMain.TimerReloadTimer(Sender: TObject);
begin
  Browser.Refresh;
end;

end.
