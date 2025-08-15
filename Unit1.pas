unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, XPMan, ComCtrls, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    Label3: TLabel;
    Image1: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    GroupBox3: TGroupBox;
    ComboBox3: TComboBox;
    GroupBox4: TGroupBox;
    ComboBox4: TComboBox;
    GroupBox5: TGroupBox;
    ComboBox5: TComboBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    ComboBox7: TComboBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    ScrollBar1: TScrollBar;
    ComboBox6: TComboBox;
    Label1: TLabel;
    CheckBox6: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  app: String;

implementation

{$R *.dfm}
function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Button2.Enabled := True;
    end;
    StatusBar1.Panels[1].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
    StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Label3.Caption := '';

  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' -i';
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -a';
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' -y';
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' -shell';
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' -shellx';

  case ComboBox1.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -t1';
  1 : Label3.Caption := Label3.Caption + ' -t0';
  end;

  case ComboBox2.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -m1';
  1 : Label3.Caption := Label3.Caption + ' -m0';
  end;

  case ComboBox3.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -s1';
  1 : Label3.Caption := Label3.Caption + ' -s0';
  2 : Label3.Caption := Label3.Caption + ' -s2';
  end;

  case ComboBox4.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -v1';
  1 : Label3.Caption := Label3.Caption + ' -v0';
  end;

  case ComboBox5.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -p1';
  1 : Label3.Caption := Label3.Caption + ' -p0';
  end;

  case ComboBox7.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -rres1';
  1 : Label3.Caption := Label3.Caption + ' -rres1,res2';
  2 : Label3.Caption := Label3.Caption + ' -rres1,res2,res3';
  3 : Label3.Caption := Label3.Caption + '';
  end;

  case ComboBox6.ItemIndex of
  0 : Label3.Caption := Label3.Caption + ' -e1';
  1 : Label3.Caption := Label3.Caption + ' -e0';
  2 : Label3.Caption := Label3.Caption + ' -e2';
  end;

  if CheckBox9.Checked = true then begin
  Label3.Caption := Label3.Caption + ' -' + IntToStr(ScrollBar1.Position); end;

  if CheckBox8.Checked = true then begin
  Label3.Caption := Label3.Caption + ' -9'; end;


  app := ExtractFilePath(Application.ExeName)+'Petite\petite.exe';
  try
  if CheckBox6.Checked = true then begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_SHOWNORMAL);
    end else begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_HIDE);
    end;
  finally
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[3].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
  StatusBar1.SetFocus;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  GroupBox6.Caption := ' Compress Level : ' + IntToStr(ScrollBar1.Position) + ' ';
end;

end.
