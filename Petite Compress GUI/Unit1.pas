unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.IniFiles;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
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
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  app: String;
  TIF : TIniFile;

implementation

{$R *.dfm}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'FileInformation',CheckBox1.Checked);
    WriteBool(OPT,'4kBoundary',CheckBox2.Checked);
    WriteBool(OPT,'OverwriteFiles',CheckBox3.Checked);
    WriteBool(OPT,'RegisterShellExtension',CheckBox4.Checked);
    WriteBool(OPT,'UnregisterShellExtension',CheckBox5.Checked);
    WriteBool(OPT,'UltraBruteCompress',CheckBox8.Checked);
    WriteBool(OPT,'ActivateCompressLevel',CheckBox9.Checked);
    WriteInteger(OPT,'Level',ScrollBar1.Position);
    WriteInteger(OPT,'ImportTables',ComboBox1.ItemIndex);
    WriteInteger(OPT,'MangleImport',ComboBox2.ItemIndex);
    WriteInteger(OPT,'StripReloc',ComboBox3.ItemIndex);
    WriteInteger(OPT,'VirusChecking',ComboBox4.ItemIndex);
    WriteInteger(OPT,'DisplayCompressionProgress',ComboBox5.ItemIndex);
    WriteInteger(OPT,'Icons',ComboBox7.ItemIndex);
    WriteInteger(OPT,'Exports',ComboBox6.ItemIndex);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      CheckBox1.Checked:=ReadBool(OPT,'FileInformation',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'4kBoundary',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'OverwriteFiles',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'RegisterShellExtension',CheckBox4.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'UnregisterShellExtension',CheckBox5.Checked);
      CheckBox8.Checked:=ReadBool(OPT,'UltraBruteCompress',CheckBox8.Checked);
      CheckBox9.Checked:=ReadBool(OPT,'ActivateCompressLevel',CheckBox9.Checked);
      ScrollBar1.Position:=ReadInteger(OPT,'Level',ScrollBar1.Position);
      Combobox1.ItemIndex:=ReadInteger(OPT,'ImportTables',comboBox1.ItemIndex);
      Combobox2.ItemIndex:=ReadInteger(OPT,'MangleImport',ComboBox2.ItemIndex);
      Combobox3.ItemIndex:=ReadInteger(OPT,'StripReloc',ComboBox3.ItemIndex);
      Combobox4.ItemIndex:=ReadInteger(OPT,'VirusChecking',ComboBox4.ItemIndex);
      Combobox5.ItemIndex:=ReadInteger(OPT,'DisplayCompressionProgress',ComboBox5.ItemIndex);
      Combobox7.ItemIndex:=ReadInteger(OPT,'Icons',ComboBox7.ItemIndex);
      Combobox6.ItemIndex:=ReadInteger(OPT,'Exports',ComboBox6.ItemIndex);
      Free;
    end;
  end;
end;

procedure ExecuteAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;
begin
  // Assemble command line
  CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  if Form1.CheckBox6.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,
    PChar(CmdLine),
    nil,
    nil,
    False,
    NORMAL_PRIORITY_CLASS,
    nil,
    nil,
    StartupInfo,
    ProcessInfo) then
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    RaiseLastOSError;
end;

// get file size
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Label3.Caption := '';

  { Displays a list of the sections in the file and a list of the
       resource types used. Also displays information on how much of
       the file is compressable. }
  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' -i';

  { This improves loading speed in Windows, but it also increases
       the size... not recommended for use with small files. }
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -a';

  // Overwrite existing files
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' -y';

  { This allows you to compress an EXE/DLL file by simply right-clicking
       on it in Windows Explorer. You may also choose the options to be used,
       by specifying them at the same time as this option... For example,
       "Petite -shell -b0" will register the shell extension, and when used,
       Petite will not create backups.´}
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' -shell';

  // Unregister shell extension
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' -shellx';

  { switch: Compress import tables
       If files don't work after compression, try switching this OFF.
       0=OFF, 1=ON (default: ON) }
  case ComboBox1.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -t1';
    1 : Label3.Caption := Label3.Caption + ' -t0';
  end;

  { switch: Mangle import tables
       Messes up the import tables during run-time. This may not work with
       files that import data items. 0=OFF, 1=ON (default: ON) }
  case ComboBox2.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -m1';
    1 : Label3.Caption := Label3.Caption + ' -m0';
  end;

  { switch: Strip relocations
       0=OFF, 1=EXE ONLY, 2=ALWAYS (default: EXE ONLY)
         OFF: The relocation information is retained.
         EXE ONLY: Any relocation information is stripped from EXEs,
                   but retained in DLLs.
         ALWAYS: The relocation information is always stripped. Only
                 use this when you are sure that a DLL will never need
                 to be relocated. }
  case ComboBox3.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -s1';
    1 : Label3.Caption := Label3.Caption + ' -s0';
    2 : Label3.Caption := Label3.Caption + ' -s2';
  end;

  { switch: Virus checking
       Makes the compressed files check themselves for virus infection
       every time they are executed. 0=OFF, 1=ON (default: ON) }
  case ComboBox4.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -v1';
    1 : Label3.Caption := Label3.Caption + ' -v0';
  end;

  { switch: Display compression progress:
       Disables/enables the displaying of the compression progress
       counter. 0=OFF, 1=ON (default: ON) }
  case ComboBox5.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -p1';
    1 : Label3.Caption := Label3.Caption + ' -p0';
  end;

  { Select resource types for compression:
       (default: NONE) ... SEE BELOW FOR DETAILS }
  case ComboBox7.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -r2';
    1 : Label3.Caption := Label3.Caption + ' -r2,10';
    2 : Label3.Caption := Label3.Caption + ' -rmytype';
    3 : Label3.Caption := Label3.Caption + ' -r2,mytype';
    4 : Label3.Caption := Label3.Caption + ' -r*';
    5 : Label3.Caption := Label3.Caption + '';
  end;

  { switch: Compress exports
       If files don't work after compression, then try switching this.
       0=OFF, 1=ON, 2=ON+EXE TABLES (default: ON)
         ON: The exports are compressed, but not the export table.
         ON+EXE TABLES: The exports AND export table are compressed when
                        compressing EXEs. The table is never compressed
                        in DLLs as the DLLs would then not be importable. }
  case ComboBox6.ItemIndex of
    0 : Label3.Caption := Label3.Caption + ' -e1';
    1 : Label3.Caption := Label3.Caption + ' -e0';
    2 : Label3.Caption := Label3.Caption + ' -e2';
  end;

  { Set the compression level
       As the level gets higher the compression gets better, but you'll
       need a fast computer (or a lot of time) when using the highest
       levels! (default: 0) NOTE: The compression level has no effect
                                  on the decompression speed. }
  if CheckBox9.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' -' + IntToStr(ScrollBar1.Position);
  end;

  // MAX Compression
  if CheckBox8.Checked = true then
  begin
    Label3.Caption := Label3.Caption + ' -9';
  end;

  // get "Petite.exe" main path
  app := ExtractFilePath(Application.ExeName)+'Petite\petite.exe';
  // execute compress process and wait for finish
  ExecuteAndWait(PChar(app), PChar(Edit1.Text));

  StatusBar1.Panels[3].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
  Screen.Cursor := crDefault;
  StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Button2.Enabled := True;
    end;
    StatusBar1.Panels[1].Text := IntToStr( Get_File_Size4(Edit1.Text)) + ' Kb';
    StatusBar1.SetFocus;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  CheckBox1.Hint := 'Displays a list of the sections in the file and a list of the' +#13#10+
                    'resource types used. Also displays information on how much of';
  CheckBox2.Hint := 'This improves loading speed in Windows 98, but it also increases' +#13#10+
                    'the size... not recommended for use with small files.';
  CheckBox3.Hint := 'This improves loading speed in Windows 98, but it also increases' +#13#10+
                    'the size... not recommended for use with small files.';
  CheckBox3.Hint := 'This improves loading speed in Windows 98, but it also increases' +#13#10+
                    'the size... not recommended for use with small files.';
  CheckBox4.Hint := 'This allows you to compress an EXE/DLL file by simply right-clicking' +#13#10+
                    'on it in Windows Explorer. You may also choose the options to be used,'+#13#10+
                    'by specifying them at the same time as this option... For example,'+#13#10+
                    '"Petite -shell -b0" will register the shell extension, and when used,'+#13#10+
                    'Petite will not create backups.';
  CheckBox5.Hint := 'Unregister shell extension.';
  CheckBox8.Hint := 'Set the compression level'+#13#10+
                    'As the level gets higher the compression gets better, but you´ll'+#13#10+
                    'need a fast computer (or a lot of time) when using the highest'+#13#10+
                    'levels! (default: 0) NOTE: The compression level has no effect'+#13#10+
                    'on the decompression speed.';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  GroupBox6.Caption := ' Compress Level : ' + IntToStr(ScrollBar1.Position) + ' ';
end;

end.
