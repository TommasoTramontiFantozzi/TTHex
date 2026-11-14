unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Grids, Menus,
  ComCtrls, math, Types, StrUtils, LCLType, LCLIntf, StdCtrls, CheckLst,
  ValEdit, unit2, Unit3, Unit5,BaseUnix, unit6;

type TmodBlock=record
    bytes:tbytes;
    start:int64;
    stop:int64;
    color:TColor;
end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    UpDown1: TUpDown;
    ValueListEditor1: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1GetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure updateGrid(bb:int64);
    procedure updateTrackBar();
    procedure retrieveSelectionBlock(var modBlock:TmodBlock;copyBytes:boolean=true);
    function fromPostoOffset(aCol,aRow:integer):uint64;
    function fromPostoOffset(aCol,aRow:integer;firstByte:uint64):uint64;
    function fromOffsetToPos(address:uint64):Tpoint;
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure ValueListEditor1Click(Sender: TObject);
    procedure ValueListEditor1DblClick(Sender: TObject);
    procedure zeroFill();
    procedure insertBlankBytes();
    procedure select();
    procedure showEmptyGrid();
    procedure jump(address:uint64);
    function actualOffset():uint64;
    procedure addToBookmark(address:uint64);
    procedure removeBookmark(item:integer);
    procedure highlightBlock(xcolor:TColor);
    function openFile(xFilename:string):boolean;
    procedure startSelectionBlock;
    procedure endSelectionBlock;
    procedure copyMarkedBlock;
    procedure deleteMarkedBlock();
    function pasteCopiedBytes(msg:byte):int8;
    procedure moveSelectedBlock();
    procedure updateBookmark(refStart:int64;refStop:int64;operation:byte);
    procedure updateHighlights(refStart:int64;refStop:int64;operation:byte);
    procedure updateSelection(refStart:int64;refStop:int64;operation:byte);
  private
    aa:tbytes;
    nCol,nColTot:integer;
    selectedCells:array of TPoint;
    selectionBlockS:int64;
    selectionBlockE:int64;
    firstByteinGrid:int64;
    mouseDownPosition:TPoint;
    mouseDownPositionFirstByteInGrid:int64;
    mouseState:byte;
    clickRow,clickCol:integer;
    fileName:string;
    jumpWidth:uint64;
    bookMarkList:TList;
    highLighterList:TList;
    copyBlock:tbytes;
  public

  end;

var
  Form1: TForm1;

implementation

procedure swap(var a,b:int64);
var
  c:int64;
begin
 if (a>-1)and(b>-1) then
 begin
   c:=a;
   a:=b;
   b:=c;
 end;
end;

function ThousandSeparator(input:uint64):string;
var
  a,b:integer;
  c:string;
begin
  c:=inttostr(input);
  result:='';
  a:=length(c);
  b:=0;
  while a>=1 do
  begin
    inc(b);
    result:=c[a]+result;
    if (b mod 3=0)and(a>1) then result:=' '+result;
    dec(a);
  end;
end;

procedure SaveTByte(sOut:tbytes;FileName:string); overload;
var
  FS: TFileStream;
  Flags: Word;
begin
  Flags := fmOpenReadWrite;
//  if not FileExists(FileName) then
    Flags := Flags or fmCreate;
  FS := TFileStream.Create(FileName, Flags);
  try
    FS.Position := FS.Size;  // Will be 0 if file created, end of text if not
    FS.Write(sOut[0], Length(sOut) * SizeOf(Char));
  finally
    FS.Free;
  end;
end;

{$R *.lfm}

{ TForm1 }

function FileToBytes(const FileName: TFileName; var Bytes: TBytes): Boolean;
var F: THandle;
    Size,hh: int64;
begin
  if FileName='' then exit;
  try
    F := FileOpen(FileName,fmOpenRead);
    if PtrInt(F)>=0 then begin
  {$ifdef LINUX}
      Size := FileSeek(F,int64(0),soFromEnd);
      FileSeek(F,int64(0),soFromBeginning);
  {$else}
      Size := GetFileSize(F,nil);
  {$endif}
      SetLength(Bytes,Size);
      hh:=0;
      while hh<size do
      begin
        try
          hh+=fpRead (F,bytes[hh],min(int64(2000000000),Size-hh));
        except
          FileClose(F);
          result:=false;
          exit;
        end;
      end;
      result:=(hh=size);
      FileClose(F);
    end;
  except
    try
      FileClose(F);
    except
    end;
    result:=false;
    exit;
  end;
end;

//function FileToBytes(const AName: string; var Bytes: TBytes): Boolean;
//var
//  Ms: TMemoryStream;
//begin
//  Result := False;
//  if not FileExists(AName) then
//    Exit;
//  Ms := TMemoryStream.Create;
//  try
//    Ms.LoadFromFile(AName);
//    if Ms.Size > 0 then
//    begin
//      setLength(Bytes,Ms.Size);
//      Ms.Position := 0;
//      MS.ReadBuffer(Bytes[0], Ms.Size);
//      Result := True;
//    end;
//  finally
//    Ms.Free;
//  end;
//end;

function TForm1.openFile(xFilename:string):boolean;
begin
  result:=false;
  if FileToBytes(xFilename,aa) then
  begin
    fileName:=xFilename;
    updateGrid(0);
    updateTrackBar;
    if length(aa)>0 then
    begin
      menuItem18.Enabled:=true;
      form1.Caption:=fileName;
      result:=true;
    end;
  end
  else
  begin
    setLength(aa,0);
    showEmptyGrid;
    showmessage('Error reading file!');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  valueListEditor1.ColWidths[0]:=160;
  selectionBlockS:=-1;
  selectionBlockE:=-1;
  mouseState:=0;
  setLength(aa,0);
  showEmptyGrid();
  jumpWidth:=0;
  bookMarkList:=TList.Create;
  highLighterList:=TList.Create;
  if ParamCount=1 then
  begin
    if openFile(ParamStr(1))=false then form1.Close;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  a:integer;
  x:puint64;
  z:^TmodBlock;
begin
  for a := 0 to bookMarkList.Count-1 do
  begin
    x:=bookMarkList.Items[a];
    dispose(x);
  end;
  bookMarkList.Free;
  for a := 0 to highLighterList.Count-1 do
  begin
    z:=highLighterList.Items[a];
    dispose(z);
  end;
  highLighterList.Free;
end;

procedure TForm1.updateTrackBar();
begin
  trackbar1.OnChange:=nil;
  if length(aa)>0 then trackbar1.Position:=round(firstByteinGrid/length(aa)*trackbar1.Max) else trackbar1.Position:=0;
  trackbar1.OnChange:=@TrackBar1Change;
end;

procedure TForm1.showEmptyGrid();
var
  a:integer;
  wdMin:double=28;
begin
  wdMin:=stringgrid1.Canvas.TextWidth('ZZZ');
  StringGrid1.DefaultRowHeight:=round(stringgrid1.Canvas.TextHeight('ZZZ')*1.4);
  nColTot:=round(((panel1.Width-20)/wdMin-3)/2)*2;
  stringgrid1.Clear;
  stringgrid1.ColCount:=nColTot-1;
  nCol:=nColTot div 2;
  stringgrid1.ColWidths[0]:=round(wdMin*3);
  for a:=1 to nCol-1 do
  begin
    stringgrid1.ColWidths[a]:=round(wdMin);
    stringgrid1.Cells[a,0]:=(a-1).ToHexString(1);
    stringgrid1.ColWidths[a+nCol-1]:=round(wdMin);
    stringgrid1.Cells[a+nCol-1,0]:=(a-1).ToHexString(1);
  end;
  stringGrid1.RowCount:=trunc(stringGrid1.Height/stringGrid1.RowHeights[0]);
end;

function TForm1.actualOffset():uint64;
begin
  result:=0;
  if length(aa)=0 then exit;
  result:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
end;

procedure TForm1.updateGrid(bb:int64);
var
  a:int64;
  posRow,posCol:integer;
  wdMin:double=28;
  Z:string;
  b:integer;
begin
  if (length(aa)=0) then showEmptyGrid();
  if (length(aa)<bb) or (length(aa)=0) then exit;
  wdMin:=stringgrid1.Canvas.TextWidth('ZZZ');
  StringGrid1.DefaultRowHeight:=round(stringgrid1.Canvas.TextHeight('ZZZ')*1.4);
  nColTot:=round(((panel1.Width-20)/wdMin-3)/2)*2;
  stringgrid1.Clear;
  stringgrid1.ColCount:=nColTot-1;
  nCol:=nColTot div 2;
  if bb<0 then bb:=0;
  while (bb>0)and(bb mod (nCol-1)>0) do dec(bb);
  //stringgrid1.ColWidths[0]:=round(wdMin*3);
  for a:=1 to nCol-1 do
  begin
    stringgrid1.ColWidths[a]:=round(wdMin);
    stringgrid1.Cells[a,0]:=(a-1).ToHexString(1);
    stringgrid1.ColWidths[a+nCol-1]:=round(wdMin);
    stringgrid1.Cells[a+nCol-1,0]:=(a-1).ToHexString(1);
  end;
  posRow:=0;
  posCol:=0;
  firstByteinGrid:=bb;
  stringGrid1.RowCount:=trunc(stringGrid1.Height/stringGrid1.RowHeights[0])+1;
  Z:='';
  for b:=1 to length(bb.ToHexString(6)) do
  begin
    Z:=Z+'Z';
  end;
  wdMin:=stringgrid1.Canvas.TextWidth(Z);
  for a:=bb to min(bb+(stringGrid1.RowCount-1)*(nCol-1)-1,length(aa)-1) do
  begin
    if (a mod (nCol-1))=0 then
    begin
      inc(posRow);
      stringGrid1.ColWidths[0]:=round(wdMin*1.2);
      stringGrid1.Cells[0,posRow]:=utf8encode(a.ToHexString(6));
      posCol:=0;
    end;
    inc(posCol);
    stringGrid1.Cells[posCol,posRow]:=utf8encode(aa[a].ToHexString);
    stringGrid1.Cells[posCol+nCol-1,posRow]:=utf8encode(chr(aa[a]));
  end;
end;

procedure TForm1.jump(address:uint64);
var
  a,b:uint64;
  p:TPoint;
begin
  if length(aa)=0 then exit;
  if address>=length(aa) then address:=length(aa)-1;
  if address<0 then address:=0;
  a:=address div ((nCol-1)*(stringGrid1.RowCount-1));
  b:=a*((nCol-1)*(stringGrid1.RowCount-1));
  if (firstByteinGrid>address) or (address>firstByteinGrid+((nCol-1)*(stringGrid1.RowCount-1))) then updateGrid(b) else updateGrid(firstByteinGrid);
  p:=fromOffsetToPos(address);
  stringGrid1.Col:=p.X;
  stringGrid1.Row:=p.Y;
  updateTrackBar;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  a:int64;
begin
  if length(aa)>0 then
  begin
    a:=round((TrackBar1.Position/TrackBar1.Max)*(length(aa)-1));
    updateGrid(a);
    updateTrackBar;
  end
  else
  begin
    showEmptyGrid();
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  highlightBlock(clPurple);
end;

procedure TForm1.zeroFill;
var
  modBlock:TmodBlock;
  a:integer;
begin
  retrieveSelectionBlock(modBlock);
  for a:=modBlock.start to modBlock.stop do
  begin
    aa[a]:=0;
  end;
  updateGrid(firstByteinGrid);
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  zeroFill();
end;

function TForm1.fromPostoOffset(aCol,aRow:integer;firstByte:uint64):uint64;
begin
  if (ACol>0)and(aRow>0)and(nCol>0) then result:=ACol+(ARow-1)*(nCol-1)-1+firstByte else result:=0;
end;

function TForm1.fromPostoOffset(aCol,aRow:integer):uint64;
begin
  if (ACol>0)and(aRow>0)and(nCol>0) then result:=ACol+(ARow-1)*(nCol-1)-1+FirstByteInGrid else result:=0;
end;

function TForm1.fromOffsetToPos(address:uint64):Tpoint;
var
  a:integer;
begin
  a:=address-FirstByteInGrid;
  result.Y:=a div (nCol-1)+1;
  result.X:=a-(nCol-1)*(a div (nCol-1))+1;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
  a:uint64;
begin
  a:=actualOffset();
  if Button=btPrev then jump(a+jumpWidth);
  if (Button=btNext) then
  begin
    if (a>=jumpWidth) then jump(a-jumpWidth) else jump(0);
  end;
end;

procedure TForm1.ValueListEditor1Click(Sender: TObject);
begin

end;

procedure TForm1.ValueListEditor1DblClick(Sender: TObject);
var
  pAddress:puint64;
begin
  if bookmarkList.Count>=ValueListEditor1.Row then
  begin
    pAddress:=bookmarkList.Items[ValueListEditor1.Row-1];
    jump(pAddress^);
  end;
end;

procedure TForm1.insertBlankBytes();
var
  a:integer;
  b,c,d:int64;
  nBytes:int64;
  rl:boolean;
begin
  if length(aa)=0 then exit;
  form2.SpinEdit1.Visible:=true;
  form2.Label1.Visible:=true;
  form2.Caption:='Insert blank bytes';
  a:=form2.ShowModal;
  if a=1 then
  begin
    b:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
    nBytes:=form2.SpinEdit1.Value;
    rl:=form2.RadioButton1.Checked;
    setLength(aa,length(aa)+nBytes);
    if rl then c:=b+1 else c:=b;
    move(aa[c],aa[nBytes+c],length(aa)-c);
    for d := 1 to nBytes do
    begin
      aa[d+c-1]:=0;
    end;
    updateBookmark(b+1,b+nbytes,2);
    updateHighlights(b+1,b+nbytes,2);
    updateSelection(b+1,b+nbytes,2);
    jump(b);
  end;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  insertBlankBytes();
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  setLength(aa,0);
  showEmptyGrid;
  menuItem18.Enabled:=false;
  menuItem39.Visible:=false;
  form3.reset();
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  if length(aa)=0 then exit;
  if fileExists(fileName) then DeleteFile(fileName);
  saveTByte(aa,fileName);
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
var
  Answer:Integer = 0;
begin
  if length(aa)=0 then exit;
  if saveDialog1.Execute then
  begin
    fileName:=saveDialog1.FileName;
    try
      if fileExists(fileName) then
      begin
        Answer:=MessageDlg('File existing', 'Overwrite ?', mtConfirmation,[mbYes, mbCancel],0);
        if  Answer = mrYes then
        begin
          if DeleteFile(fileName) then
          begin
            saveTByte(aa,fileName);
          end
          else
          begin
            showmessage('Something went wrong!');
          end;
        end;
        if  Answer = mrCancel then exit;
      end
      else
      begin
        saveTByte(aa,fileName);
      end;
    except
      showmessage('Something went wrong!');
    end;
  end;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  form3.mm:=@aa;
  form3.jump:=@jump;
  form3.Show;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
    form5.Caption:='Goto address';
    if form5.ShowModal>0 then jump(form5.address);
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
    form5.Caption:='Set jump width';
    if form5.ShowModal>0 then jumpWidth:=form5.address;
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  jump(actualOffset+jumpWidth);
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
var
  a:uint64;
begin
  a:=actualOffset;
  if (a>=jumpWidth) then jump(a-jumpWidth) else jump(0);
end;

procedure TForm1.addToBookmark(address:uint64);
var
  pAddress:puint64;
begin
  if length(aa)=0 then exit;
  new(pAddress);
  pAddress^:=address;
  bookMarkList.Add(pAddress);
  if bookmarkList.Count=1 then valueListEditor1.DeleteRow(1);
  valueListEditor1.Row:=valueListEditor1.RowCount;
  valueListEditor1.InsertRow(ThousandSeparator(address)+' $'+address.ToHexString(2),'',True);
  popupMenu2.Items[0].Enabled:=true;
end;

procedure TForm1.MenuItem24Click(Sender: TObject);
var
  a:uint64;
begin
  a:=actualOffset;
  addToBookmark(a);
end;

procedure TForm1.removeBookmark(item:integer);
var
  b:puint64;
begin
  if (item>=0)and(item<=bookMarkList.Count) then
  begin
    b:=bookMarkList.Items[item];
    dispose(b);
    bookMarkList.Delete(item);
    valueListEditor1.DeleteRow(item+1);
  end;
  if bookMarkList.Count=0 then popupMenu2.Items[0].Enabled:=false;
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  removeBookmark(valueListEditor1.Row-1);
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
var
  a:uint64;
begin
  a:=actualOffset;
  addToBookmark(a);
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  selectionBlockS:=-1;
  selectionBlockE:=-1;
  stringGrid1.Invalidate;
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
var
  Answer:Integer = 0;
  a:integer;
  x:puint64;
begin
  Answer:=MessageDlg('Remove all bookmarks', 'Are you sure ?', mtConfirmation,[mbYes,mbCancel],0);
  if  Answer = mrYes then
  begin
    for a:=0 to bookmarkList.Count-1 do
    begin
     x:=bookMarkList.Items[0];
     dispose(x);
     bookMarkList.Delete(0);
     valueListEditor1.DeleteRow(1);
    end;
  end;
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
var
  a,b,c,d,e,f:integer;
  aCol,aRow:integer;
  x:^TmodBlock;
  p:TPoint;
begin
  aCol:=clickCol;
  aRow:=clickRow;
  a:=ACol+(ARow-1)*(nCol-1)-1+FirstByteInGrid;
  b:=0;
  while b<highlighterList.Count do
  begin
   x:=highlighterList.Items[b];
   if (a>=x^.start)and(a<=x^.stop) then
   begin
     selectionBlockS:=x^.start;
     selectionBlockE:=x^.stop;
     highlighterList.Delete(b);
     StringGrid1.Invalidate;
     dec(b);
   end;
   inc(b);
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    openFile(opendialog1.FileName);
  end;
end;

procedure TForm1.MenuItem30Click(Sender: TObject);
var
  a,b,c,d,e,f:integer;
  aCol,aRow:integer;
  x:^TmodBlock;
  p:TPoint;
begin
  aCol:=clickCol;
  aRow:=clickRow;
  a:=ACol+(ARow-1)*(nCol-1)-1+FirstByteInGrid;
  b:=0;
  while b<highlighterList.Count do
  begin
   x:=highlighterList.Items[b];
   if (a>=x^.start)and(a<=x^.stop) then
   begin
     highlighterList.Delete(b);
     StringGrid1.Invalidate;
     dec(b);
   end;
   inc(b);
  end;
end;

procedure TForm1.MenuItem32Click(Sender: TObject);
begin
  startSelectionBlock;
end;

procedure TForm1.MenuItem33Click(Sender: TObject);
begin
  endSelectionBlock;
end;

procedure TForm1.updateBookmark(refStart:int64;refStop:int64;operation:byte);
var
  a,b,c:integer;
  pAddress:puint64;
begin
  if operation=1 then //Delete
  begin
    a:=0;
    while (a<bookMarkList.Count) do
    begin
     pAddress:=bookmarkList.Items[a];
     if (pAddress^>refStop) then
     begin
       pAddress^:=pAddress^-(refStop-refStart+1);
       valueListEditor1.Rows[a+1].Strings[0]:=ThousandSeparator(pAddress^)+' $'+pAddress^.ToHexString(2);
     end
     else
     begin
       if (pAddress^>=refStart)and(pAddress^<=refStop) then
       begin
         removeBookMark(a);
         dec(a);
       end;
     end;
     inc(a);
    end;
  end;
end;

procedure TForm1.updateHighlights(refStart:int64;refStop:int64;operation:byte);
var
  a:integer;
  b:int8;
  x:^TmodBlock;
begin
  if operation=1 then b:=-1;      //Delete
  if operation=2 then b:= 1;      //Insert
  for a := 0 to highLighterList.Count -1 do
  begin
    x:=highLighterList.Items[a];
    if refStop<x^.start then
    begin
      x^.start:=x^.start+b*(refStop-refStart+1);
      x^.stop:=x^.stop+b*(refStop-refStart+1);
    end
    else
    begin
      if refStop=x^.start then
      begin
        x^.stop:=x^.stop+b*(refStop-refStart+1);
      end;
    end;
    if x^.stop<x^.start then
    begin
      dispose(x);
      highLighterList.Delete(a);
    end;
  end;
end;

procedure TForm1.updateSelection(refStart:int64;refStop:int64;operation:byte);
var
  b:int8;
begin
  if operation=1 then b:=-1;      //Delete
  if operation=2 then b:= 1;      //Insert
  if refStart<selectionBlockS then
  begin
    selectionBlockS:=selectionBlockS+b*(refStop-refStart+1);
    selectionBlockE:=selectionBlockE+b*(refStop-refStart+1);
  end
  else
  begin
    if (refStart>=selectionBlockS)and(refStop<=selectionBlockE) then
    begin
      selectionBlockE:=selectionBlockE+b*(refStop-refStart+1);
      if selectionBlockE<selectionBlockS then
      begin
        selectionBlockE:=-1;
        selectionBlockS:=-1;
      end;
    end;
  end;
end;

procedure TForm1.deleteMarkedBlock();
var
  a:integer;
  modBlock:TmodBlock;
  zz:tbytes;
  x:^TModBlock;
begin
  if (selectionBlockS>-1)and(selectionBlockE>-1) then
  begin
    retrieveSelectionBlock(modBlock);
    setLength(zz,length(aa)-(modBlock.stop-modBlock.start+1));
    move(aa[0],zz[0],modBlock.start);
    if length(aa)>modBlock.stop+1 then move(aa[modBlock.stop+1],zz[modBlock.start],length(aa)-modBlock.stop-1);
    aa:=zz;
    updateBookmark(selectionBlockS,selectionBlockE,1);
    updateHighlights(selectionBlockS,selectionBlockE,1);
    a:=0;
    jump(selectionBlockS);
    selectionBlockS:=-1;
    selectionBlockE:=-1;
  end
end;

function TForm1.pasteCopiedBytes(msg:byte):int8;
var
  a:integer;
  b,c,d,nBytes:int64;
  zz:tbytes;
  rl:boolean;
begin
  nBytes:=length(copyBlock);
  if nBytes=0 then
  begin
    if msg=1 then showmessage('No block copied!');
    if msg=2 then showmessage('No selected block!');
    exit;
  end;
  form2.SpinEdit1.Visible:=false;
  form2.Label1.Visible:=false;
  if msg=1 then form2.Caption:='Paste '+inttostr(nBytes)+' bytes';
  if msg=2 then form2.Caption:='Move '+inttostr(nBytes)+' bytes';
  a:=form2.ShowModal;
  result:=a;
  if a=1 then
  begin
    b:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
    rl:=form2.RadioButton1.Checked;
    setLength(zz,length(aa)+nBytes);
    if rl then c:=b+1 else c:=b;
    move(aa[0],zz[0],c);
    move(copyBlock[0],zz[c],nBytes);
    if c<length(aa) then move(aa[c],zz[nBytes+c],length(aa)-c);
    aa:=zz;
    updateBookmark(b+1,b+nBytes,2);
    updateHighlights(b+1,b+nBytes,2);
    updateSelection(b+1,b+nBytes,2);
    updateGrid(firstByteinGrid);
  end;
end;


procedure TForm1.copyMarkedBlock;
begin
  if (selectionBlockS>-1)and(selectionBlockE>-1) then
  begin
    setLength(copyBlock,selectionBlockE-selectionBlockS+1);
    move(aa[selectionBlockS],copyBlock[0],selectionBlockE-selectionBlockS+1);
    menuItem39.Visible:=True;
  end;
end;

procedure TForm1.MenuItem34Click(Sender: TObject);
begin
  copyMarkedBlock;
end;

procedure TForm1.moveSelectedBlock();
var
  a:integer;
  b,c,d,nBytes:int64;
  zz:tbytes;
  rl:boolean;
  tmp:int64;
begin
  b:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
  tmp:=selectionBlockE;
  copyMarkedBlock;
  if pasteCopiedBytes(2)=1 then
  begin
    deleteMarkedBlock;
    nBytes:=length(copyBlock);
    if tmp<b then jump(b-nBytes) else jump(b);
  end;
end;

procedure TForm1.MenuItem35Click(Sender: TObject);
begin
  moveSelectedBlock();
end;

procedure TForm1.MenuItem36Click(Sender: TObject);
begin
  deleteMarkedBlock;
end;

procedure TForm1.MenuItem37Click(Sender: TObject);
begin
  pasteCopiedBytes(1);
end;

procedure TForm1.MenuItem38Click(Sender: TObject);
begin
  copyMarkedBlock;
end;

procedure TForm1.MenuItem39Click(Sender: TObject);
begin
  pasteCopiedBytes(1);
end;

procedure TForm1.startSelectionBlock;
begin
  if StringGrid1.Col<nCol then
  begin
    selectionBlockS:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
  end;
  if selectionBlockS>selectionBlockE then swap(selectionBlockS,selectionBlockE);
  if selectionBlockE>-1 then StringGrid1.Invalidate;
end;

procedure TForm1.endSelectionBlock;
begin
  selectionBlockE:=fromPostoOffset(StringGrid1.Col,StringGrid1.Row);
  if selectionBlockS>selectionBlockE then swap(selectionBlockS,selectionBlockE);
  if selectionBlockS>-1 then StringGrid1.Invalidate;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  startSelectionBlock;
end;

procedure TForm1.MenuItem41Click(Sender: TObject);
begin
  form6.Show;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  endSelectionBlock;
end;

procedure TForm1.highlightBlock(xcolor:TColor);
var
  a:integer;
  b:^TmodBlock;
begin
  if (selectionBlockS>-1)and(selectionBlockE>-1) then
  begin
    new(b);
    b^.start:=selectionBlockS; // selectionBlockStart.X+(selectionBlockStart.Y-1)*(nCol-1)-1+selectionBlockStartFirstByteInGrid;
    b^.stop :=selectionBlockE; // selectionBlockend.X  +(selectionBlockEnd.Y  -1)*(nCol-1)-1+selectionBlockEndFirstByteInGrid;
    b^.color:=xcolor;
    highlighterList.Add(b);
    selectionBlockS:=-1;
    selectionBlockE:=-1;
    stringGrid1.Invalidate;
  end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  highlightBlock(clAqua);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  highlightBlock(clGreen);
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  highlightBlock(clYellow);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  highlightBlock(clGray);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var
  a,b,c,d,e,f:int64;
  aCol,aRow:integer;
  x:^TmodBlock;
begin
  aCol:=clickCol;
  aRow:=clickRow;
  a:=ACol+(ARow-1)*(nCol-1)-1+FirstByteInGrid;
  if (selectionBlockS>-1) and (selectionBlockE>-1) then
  begin
    e:=selectionBlockS;
    f:=selectionBlockE;
    c:=min(e,f);
    d:=max(e,f);
    if (aCol<nCol)and(aCol>0)and(aRow>0)and(a>=c)and(a<=d) then
    begin
      menuItem5.Enabled:=True;
      menuItem38.Enabled:=True;
      menuItem11.Enabled:=True;
    end
    else
    begin
     menuItem5.Enabled:=False;
     menuItem11.Enabled:=False;
     menuItem38.Enabled:=False;
    end;
  end
  else
  begin
   menuItem5.Enabled:=False;
   menuItem11.Enabled:=False;
  end;
  MenuItem29.Visible:=false;
  MenuItem30.Visible:=false;
  for b:=0 to highlighterList.Count-1 do
  begin
   x:=highlighterList.Items[b];
   if (a>=x^.start)and(a<=x^.stop) then
   begin
     MenuItem29.Visible:=true;
     MenuItem30.Visible:=true;
     break;
   end;
  end;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  select();
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  a:integer;
begin
  stringGrid1.Canvas.Pen.Width:=3;
  if aCol=NCol-1 then stringGrid1.Canvas.Line(aRect.right-3,aRect.Top,aRect.right-3,aRect.Bottom);
  if aCol=NCol then stringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Left,aRect.Bottom);
  for a:= 0 to length(selectedCells)-1 do
  begin
    if (selectedCells[a].X=aCol)and(selectedCells[a].Y=aRow) then
    begin
      stringGrid1.Canvas.Pen.Color:=clBlue;
      stringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Left,aRect.Bottom);
      stringGrid1.Canvas.Line(aRect.Left,aRect.Bottom-3,aRect.Right,aRect.Bottom-3);
      stringGrid1.Canvas.Line(aRect.Right-3,aRect.Top,aRect.Right-3,aRect.Bottom);
      stringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Right,aRect.Top);
    end;
    if (selectedCells[a].X+nCol-1=aCol)and(selectedCells[a].Y=aRow) then
    begin
      stringGrid1.Canvas.Pen.Color:=clYellow;
      stringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Left,aRect.Bottom);
      stringGrid1.Canvas.Line(aRect.Left,aRect.Bottom-3,aRect.Right,aRect.Bottom-3);
      stringGrid1.Canvas.Line(aRect.Right-3,aRect.Top,aRect.Right-3,aRect.Bottom);
      stringGrid1.Canvas.Line(aRect.Left,aRect.Top,aRect.Right,aRect.Top);
    end;
  end;
end;

procedure TForm1.StringGrid1EditingDone(Sender: TObject);
begin

end;

procedure TForm1.StringGrid1GetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin

end;


procedure TForm1.retrieveSelectionBlock(var modBlock:TmodBlock;copyBytes:boolean=true);
var
  a,b,c,d,e,f:int64;
begin
  if length(aa)=0 then exit;
  if (selectionBlockS>-1) and (selectionBlockE>-1) then
  begin
    e:=selectionBlockS;
    f:=selectionBlockE;
    c:=min(e,f);
    d:=max(e,f);
    if c>length(aa)-1 then
    begin
      modBlock.start:=-1;
      modBlock.stop:=-1;
      exit;
    end;
    d:=min(length(aa)-1,d);
    modBlock.start:=c;
    modBlock.stop:=d;
    if copyBytes then
    begin
      setLength(modBlock.bytes,d-c+1);
      move(aa[c],modBlock.bytes[0],d-c+1);
    end;
  end
  else
  begin
   modBlock.start:=-1;
   modBlock.stop:=-1;
  end;
end;

procedure TForm1.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  a:int64;
  modBlock:TmodBlock;
begin
  if (Key=33) then
  begin
    a:=(StringGrid1.RowCount-1)*nCol;
    updateGrid(FirstByteInGrid-a);
  end;
  if (Key=34) then
  begin
    a:=(StringGrid1.RowCount-1)*nCol;
    updateGrid(FirstByteInGrid+a);
  end;
  if (Key=46) then
  begin
    a:=fromPostoOffset(StringGrid1.Col,Stringgrid1.Row);
    if length(aa)>0 then
    begin
      if length(aa)>1 then
      begin
        move(aa[a+1],aa[a],length(aa)-a);
        setLength(aa,length(aa)-1);
      end;
      updateBookmark(a,a,1);
      updateHighlights(a,a,1);
      updateSelection(a,a,1);
      jump(a);
    end;
    key:=0;
    if length(aa)=0 then
    if length(aa)=0 then menuItem18.Enabled:=false;
  end;
  if (Key=40)and(StringGrid1.Row=StringGrid1.RowCount-1) then
  begin
     a:=stringgrid1.Row;
     updateGrid(firstByteinGrid+nCol);
     stringgrid1.Row:=a-1;
  end;
  if (Key=38)and(StringGrid1.Row=1) then
  begin
     a:=stringgrid1.Row;
     updateGrid(firstByteinGrid-nCol);
     stringgrid1.Row:=a;
  end;
  updateTrackBar;
end;

procedure TForm1.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StringGrid1.MouseToCell(X,Y,clickCol,clickRow);
  if Button=mbLeft then
  begin
    mouseState:=1; //Down
    if clickCol<nCol then mouseDownPosition.X:=clickCol else mouseDownPosition.X:=clickCol-nCol+1;
    mouseDownPosition.Y:=clickRow;
    mouseDownPositionFirstByteInGrid:=FirstByteInGrid;
  end;
end;

function fp32(aa,bb,cc,dd:byte):single;
var
  oo:array [0..3] of byte;
begin
    oo[3]:=aa;
    oo[2]:=bb;
    oo[1]:=cc;
    oo[0]:=dd;
    move(oo,result,4);
end;

function fp64(aa,bb,cc,dd,ee,ff,gg,hh:byte):double;
var
  oo:array [0..7] of byte;
begin
    oo[7]:=aa;
    oo[6]:=bb;
    oo[5]:=cc;
    oo[4]:=dd;
    oo[3]:=ee;
    oo[2]:=ff;
    oo[2]:=gg;
    oo[0]:=hh;
    move(oo,result,8);
end;

procedure TForm1.select();
var
  modBlock:TmodBlock;
  q,p:integer;
  x:single;
  y:double;
  u:uint8;
  uu:uint16;
  uuu:uint32;
  uuuu:uint64;
  k:int8;
  kk:int16;
  kkk:int32;
  kkkk:int64;
  vv:array of byte;
begin
  if length(aa)=0 then exit;
  retrieveSelectionBlock(modBlock,false);
  if modBlock.stop=-1 then exit;
  q:=modBlock.stop-modBlock.start+1;
  if q<=8 then
  begin
    retrieveSelectionBlock(modBlock,true);
    if radioButton2.Checked then
    begin
      setLength(vv,q);
      for p := 0 to q-1 do
      begin
        vv[p]:=modBlock.bytes[q-1-p];
      end;
      modBlock.bytes:=vv;
    end;
    if q=1 then
    begin
      u:=uint8((@modBlock.bytes[0])^);
      k:=int8((@modBlock.bytes[0])^);
      edit3.Text:=inttostr(u);
      edit4.Text:='';
      edit5.Text:=inttostr(k);
      label1.Caption:='uINT8';
      label3.Caption:='sINT8';
    end;
    if q=2 then
    begin
      uu:=uint16((@modBlock.bytes[0])^);
      kk:=int16((@modBlock.bytes[0])^);
      edit3.Text:=inttostr(uu);
      edit4.Text:='';
      edit5.Text:=inttostr(kk);
      label1.Caption:='uINT16';
      label3.Caption:='sINT16';
    end;
    if q=4 then
    begin
      x:=single((@modBlock.bytes[0])^);
      edit4.Text:=floattostr(x);
      uuu:=uint32((@modBlock.bytes[0])^);
      kkk:=int32((@modBlock.bytes[0])^);
      edit3.Text:=inttostr(uuu);
      edit5.Text:=inttostr(kkk);
      Label2.Caption:='FP32';
      label1.Caption:='uINT32';
      label3.Caption:='sINT32';
    end;
    if q=8 then
    begin
      y:=double((@modBlock.bytes[0])^);
      edit4.Text:=floattostr(y);
      uuuu:=uint64((@modBlock.bytes[0])^);
      kkkk:=int64((@modBlock.bytes[0])^);
      edit3.Text:=inttostr(uuuu);
      edit5.Text:=inttostr(kkkk);
      Label2.Caption:='FP64';
      label1.Caption:='uINT64';
      label3.Caption:='sINT64';
    end;
  end
  else
  begin
    edit3.Text:='';
    edit4.Text:='';
    edit5.Text:='';
  end;
end;

procedure TForm1.StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  a:int64;
  b:integer;
  pos:TPoint;
begin
   if mouseState=1 then
   begin
     StringGrid1.Options:=StringGrid1.Options-[goEditing];
     pos.X:=StringGrid1.Col;
     pos.Y:=StringGrid1.Row;
     if (pos.X<nCol) then
     begin
       a:=fromPostoOffset(mouseDownPosition.X,mouseDownPosition.Y,mouseDownPositionFirstByteInGrid);
       if a<=length(aa)-1 then selectionBlockS:=fromPostoOffset(mouseDownPosition.X,mouseDownPosition.Y,mouseDownPositionFirstByteInGrid) else selectionBlockS:=-1;
       selectionBlockE:=fromPostoOffset(pos.X,pos.Y,FirstByteInGrid);
       selectionBlockE:=min(selectionBlockE,length(aa)-1);
       if selectionBlockS>selectionBlockE then swap(selectionBlockS,selectionBlockE);
       select();
     end;
     if (pos.X>=nCol) then
     begin
       b:=pos.X-nCol+1;
       a:=fromPostoOffset(mouseDownPosition.X,mouseDownPosition.Y,mouseDownPositionFirstByteInGrid);
       if a<=length(aa)-1 then selectionBlockS:=fromPostoOffset(mouseDownPosition.X,mouseDownPosition.Y,mouseDownPositionFirstByteInGrid) else selectionBlockS:=-1;
       selectionBlockE:=fromPostoOffset(b,pos.Y,FirstByteInGrid);
       selectionBlockE:=min(selectionBlockE,length(aa)-1);
       if selectionBlockS>selectionBlockE then swap(selectionBlockS,selectionBlockE);
       select();
     end;
     if(StringGrid1.Row=1)and(Y<0) then
     begin
        a:=stringgrid1.Row;
        updateGrid(firstByteinGrid-nCol);
        stringgrid1.Row:=a;
        updateTrackBar;
     end;
     if (StringGrid1.Row=StringGrid1.RowCount-1)and(Y>StringGrid1.Height) then
     begin
        a:=stringgrid1.Row;
        updateGrid(firstByteinGrid+nCol);
        stringgrid1.Row:=a-1;
        updateTrackBar;
     end;
   end;
end;

procedure TForm1.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  timer1.Enabled:=true;
   mouseState:=0; //Up
end;

procedure TForm1.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  a:integer;
begin
  if (StringGrid1.Row=StringGrid1.RowCount-1) then
  begin
     a:=stringgrid1.Row;
     updateGrid(firstByteinGrid+nCol);
     stringgrid1.Row:=a-1;
     updateTrackBar;
  end;
end;

procedure TForm1.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  a:integer;
begin
  if(StringGrid1.Row=1) then
  begin
     a:=stringgrid1.Row;
     updateGrid(firstByteinGrid-nCol);
     stringgrid1.Row:=a;
     updateTrackBar;
  end;
end;

procedure TForm1.StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);
var
  xColor:TColor;
  a:int64;
  c,d,e,f:int64;
  b:array [0..2] of integer;
  N:integer;
  ts: TTextStyle;
  z:^TmodBlock;
begin
  ts:=StringGrid1.Canvas.TextStyle;
  ts.Alignment:=taCenter;
  StringGrid1.Canvas.TextStyle:=ts;
  a:=ACol+(ARow-1)*(nCol-1)-1+FirstByteInGrid;
  if ACol>=nCol then a:=ACol-nCol+(ARow-1)*(nCol-1)+FirstByteInGrid;
  if (aCol>0)and(aRow>0) then
  begin
    for c:=0 to highlighterList.Count-1 do
    begin
      z:=highlighterList.Items[c];
      if (a>=z^.start)and(a<=z^.stop) then
      begin
        StringGrid1.Canvas.Brush.Color:=z^.color;
        if z^.color=clAqua   then StringGrid1.Canvas.Font.Color:=clBlack;
        if z^.color=clyellow then StringGrid1.Canvas.Font.Color:=clBlack;
        if z^.color=clGreen  then StringGrid1.Canvas.Font.Color:=clBlack;
        if z^.color=clGray   then StringGrid1.Canvas.Font.Color:=clBlack;
        if z^.color=clPurple then StringGrid1.Canvas.Font.Color:=clWhite;
      end;
    end;
  end;
  if (selectionBlockS>-1) and (selectionBlockE>-1) then
  begin
    e:=selectionBlockS;
    f:=selectionBlockE;
    c:=min(e,f);
    d:=max(e,f);
    if (aCol>0)and(aRow>0)and(a>=c)and(a<=d) then StringGrid1.Canvas.Brush.Color:=clRed;
  end;
  if (aRow>0)and(aRow mod 2 =0) then
  begin
    xColor:=stringGrid1.Canvas.Brush.Color;
    N:=ColorToRGB(xColor);
    b[0]:=red(N);
    b[1]:=green(N);
    b[2]:=blue(N);
    for a:=0 to 2 do
    begin
      if b[a]+10<=255 then b[a]:=b[a]+10 else b[a]:=b[a]-10;
    end;
    xColor:=RGBToColor(b[0],b[1],b[2]);
    stringGrid1.Canvas.Brush.Color:=xColor;
  end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
var
  stringGrid:TStringGrid;
  a:int64;
  arect:Trect;
  cc:TGridRect;
  b:string;
begin
  a:=fromPostoOffset(aCol,aRow);
  b:='Offset: $'+a.ToHexString(2)+' ('+inttostr(a)+')';
  Edit1.Text:=b;
  if (length(aa)>0)and(length(aa)>a) then
  begin
    b:=' Value: $'+aa[a].ToHexString(2)+' ('+inttostr(aa[a])+' / b'+aa[a].ToBinString+')';
    Edit2.Text:=b;
  end;

  if aRow>0 then
  begin
    setLength(selectedCells,1);
    if aCol<nCol then selectedCells[0].X:=aCol else selectedCells[0].X:=aCol-nCol+1;
    selectedCells[0].Y:=aRow;
    stringGrid1.Invalidate;
    cc:=stringGrid1.Selection;
  end;
end;


procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  strinGrid:TStringGrid;
  a:integer;
  b:integer;
  ok:boolean;
begin
  if length(aa)=0 then exit;
  strinGrid:=TStringGrid(sender);
  if aCol<=nCol then
  begin
    a:=ACol+(ARow-1)*(nCol-1)-1;
    ok:=false;
    try
      b:=Hex2Dec(Value);
      ok:=true;
    except
    end;
    if length(Value)>2 then ok:=false;
    if ok then
    begin
      aa[a]:=b;
      strinGrid.Cells[aCol+nCol-1,aRow]:=chr(b);
    end
    else
    begin
      strinGrid.Cells[aCol,aRow]:=aa[a].ToHexString(2);
    end;
  end;
  if aCol>nCol then
  begin
    a:=ACol-nCol+(ARow-1)*(nCol-1);
    if (length(Value)>1)or(length(Value)=0) then
    begin
      strinGrid.Cells[aCol,aRow]:=chr(aa[a]);
    end
    else
    begin
     aa[a]:=ord(Value[1]);
     strinGrid.Cells[aCol-nCol+1,aRow]:=ord(Value[1]).ToHexString(2);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  StringGrid1.Options:=StringGrid1.Options+[goEditing];
  timer1.Enabled:=false;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  a:int64;
begin
  a:=round((TrackBar1.Position/TrackBar1.Max)*(length(aa)-1));
  updateGrid(a);
end;

procedure TForm1.TrackBar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key<>38)and(key<>40)and(key<>33)and(key<>34) then stringgrid1.SetFocus;
end;


end.

