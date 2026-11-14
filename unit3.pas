unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  FileCtrl, ComboEx, ComCtrls, ExtCtrls, laz.VirtualTrees,
  StrUtils, Types, math, fgl,Unit4,linux,valEdit,Grids;


type PPSearchResult=^PSearchResult;
     PSearchResult=^TSearchResult;
     TSearchResult=record
       comment:string;
       offset:uint64;
       id:integer;
       next:pointer;
       prev:pointer;
end;

type
  tJump = procedure(address:uint64) of object;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2EditingDone(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ValueListEditor1PrepareCanvas(Sender: TObject; aCol,
      aRow: Integer; aState: TGridDrawState);
    procedure ValueListEditor1MouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure ValueListEditor1MouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure ValueListEditor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ValueListEditor1SetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure TrackBarChange(Sender: TObject);
    procedure updateResults(start:integer;c:integer);
    procedure ValueListEditor1DblClick(Sender: TObject);
    procedure reset();
  private
    tabs:array of TTabsheet;
    ValueListEditors:array of TValueListEditor;
    edits:array of TEdit;
    labels:array of TLabel;
    trackBars:array of TTrackBar;
    adrs:array of TList;
    startRes:array of integer;
  public
    mm:pointer;
    aa:tbytes;
    jump:tJump;
  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

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

function string2bytes(input:string):tbytes;
var
  a,b,c:integer;
begin
  b:=length(input);
  setLength(result,b);
  c:=0;
  a:=2;
  while (a<=b) do
  begin
    result[c]:=hex2dec(input[a])+hex2dec(input[a-1])*16;
    inc(c);
    a+=3;
  end;
  setLength(result,c);
end;

function text2bytes(input:string):tbytes;
var
  a,b,c:integer;
begin
  b:=length(input);
  setLength(result,b);
  a:=1;
  for a:= 1 to b do
  begin
    result[a-1]:=ord(input[a]);
  end;
end;

function text2bytesUnicodeLatin(input:string):tbytes;
var
  a,b,c:integer;
begin
  b:=length(input);
  setLength(result,b*2);
  fillChar(result[0],b*2,0);
  a:=1;
  for a:= 1 to b do
  begin
    result[(a-1)*2]:=ord(input[a]);
  end;
end;

procedure TForm3.reset();
var
  a,b:integer;
begin
  for a:=0 to length(tabs)-1 do
  begin
    ValueListEditors[a].Free;
    edits[a].Free;
    labels[a].Free;
    trackBars[a].Free;
    for b:= 0 to adrs[a].Count-1 do
    begin
      dispose(PSearchResult(adrs[a].Items[b]));
    end;
    adrs[a].Free;
    tabs[a].Free;
    tabs[a]:=nil;
  end;
  setLength(tabs,0);
  setLength(adrs,0);
  setLength(ValueListEditors,0);
  setLength(edits,0);
  setLength(labels,0);
  setLength(trackBars,0);
  setLength(startRes,0);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  form3.Close;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
    radioButton1.Checked:=true;
end;

procedure TForm3.ComboBox1Click(Sender: TObject);
begin
    radioButton1.Checked:=true;
end;

procedure TForm3.ComboBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

function search(S:pointer):ptrint;
type TS=record
   adrs:TList;
   aa:tbytes;
   bb:tbytes;
   z:boolean;
   progress:longword;
   stop:longint;
end;
var
  a:int64;
  b,c,d:integer;
  res:PSearchResult;
  adrs:TList;
  aa,bb:TBytes;
  z:boolean;
begin
  adrs:=TS(S^).adrs;
  aa:=TS(S^).aa;
  bb:=TS(S^).bb;
  z:=TS(S^).z;
  if length(bb)>0 then
  begin
    a:=0;
    while a<length(aa)-length(bb) do
    begin
      c:=0;
      if z or (bb[0]=aa[a]) then
      begin
        for b:=0 to length(bb)-1 do
        begin
          d:=c;
          if bb[b]=aa[a+b] then
          begin
            inc(c);
          end
          else
          begin
            if z then
            begin
              if char(bb[b]) in ['a'..'z'] then
                if char(aa[a+b]) in ['A'..'Z'] then
                  if bb[b]=aa[a+b]+32 then inc(c);
              if char(bb[b]) in ['A'..'Z'] then
                if char(aa[a+b]) in ['a'..'z'] then
                  if bb[b]=aa[a+b]-32 then inc(c);
            end;
          end;
          if d=c then break;
        end;
      end;
      if c=length(bb) then
      begin
        new(res);
        res^.offset:=a;
        res^.comment:='';
        adrs.Add(res);
        inc(a,length(bb)-1);
        InterlockedExchangeAdd(TS(S^).progress,length(bb)-1);
      end;
      inc(a);
      InterLockedIncrement(TS(S^).progress);
      if TS(S^).stop>0 then
      begin
        break;
      end;
    end;
  end;
  InterLockedIncrement(TS(S^).stop);
  InterlockedExchangeAdd(TS(S^).progress,length(bb));
end;

procedure TForm3.updateResults(start:integer;c:integer);
var
  a:integer;
  visibleRows:integer;
begin
  start:=max(start,0);
  visibleRows:=min(adrs[c].Count,floor((ValueListEditors[c].Height)/ValueListEditors[c].RowHeights[0])-2);
  start:=min(start,adrs[c].Count-visibleRows);
  ValueListEditors[c].RowCount:=visibleRows+1;
  startRes[c]:=start;
  for a := start to start+visibleRows-1 do
  begin
    if a<adrs[c].Count then
    begin
      ValueListEditors[c].Rows[a-start+1].Strings[0]:=ThousandSeparator(PSearchResult(adrs[c].Items[a])^.offset);
      ValueListEditors[c].Rows[a-start+1].Strings[1]:=PSearchResult(adrs[c].Items[a])^.comment;
    end
    else ValueListEditors[c].Rows[a-start+1].Strings[0]:='';
  end;
  trackBars[c].Max:=adrs[c].Count-visibleRows;
end;

procedure TForm3.ValueListEditor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ValueListEditor:TValueListEditor;
  b,c:integer;
begin
  ValueListEditor:=TValueListEditor(Sender);
  c:=ValueListEditor.Tag;
  if key=38 then b:=-1;
  if key=40 then b:=+1;
  if key=33 then b:=-ValueListEditor.VisibleRowCount;
  if key=34 then b:=+ValueListEditor.VisibleRowCount;
  if (Key=38) then
  begin
    if ValueListEditor.Row=1 then updateResults(startRes[c]+b,c);
  end;
  if (Key=40) then
  begin
    if ValueListEditor.Row=ValueListEditor.RowCount-1 then updateResults(startRes[c]+b,c);;
  end;
  if (Key=33)or(key=34) then
  begin
    updateResults(startRes[c]+b,c);
  end;
  if (key=33)or(key=34)or(key=38)or(key=40)then
  begin
    trackBars[c].OnChange:=nil;
    trackBars[c].Position:=round((adrs[c].Count-ValueListEditor.VisibleRowCount+1)/trackBars[c].Max*startRes[c]);
    trackBars[c].OnChange:=@TrackBarChange;
  end;
end;

procedure TForm3.ValueListEditor1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  ValueListEditor:TValueListEditor;
  c:integer;
begin
  ValueListEditor:=TValueListEditor(Sender);
  c:=ValueListEditor.Tag;
  if ValueListEditor.Row=1 then updateResults(startRes[c]-1,c);
  trackBars[c].OnChange:=nil;
  if trackBars[c].Max>0 then trackBars[c].Position:=round((adrs[c].Count-ValueListEditor.VisibleRowCount+1)/trackBars[c].Max*startRes[c]);
  trackBars[c].OnChange:=@TrackBarChange;
end;

procedure TForm3.ValueListEditor1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  ValueListEditor:TValueListEditor;
  c:integer;
  a,b,d:integer;
begin
  ValueListEditor:=TValueListEditor(Sender);
  c:=ValueListEditor.Tag;
  if ValueListEditor.Row=ValueListEditor.RowCount-1 then updateResults(startRes[c]+1,c);
  trackBars[c].OnChange:=nil;
  if trackBars[c].Max>0 then trackBars[c].Position:=round((adrs[c].Count-ValueListEditor.VisibleRowCount+1)/trackBars[c].Max*startRes[c]);
  trackBars[c].OnChange:=@TrackBarChange;
end;

procedure TForm3.ValueListEditor1PrepareCanvas(Sender: TObject; aCol,
  aRow: Integer; aState: TGridDrawState);
var
  ValueListEditor:TValueListEditor;
  trackBar:TTrackbar;
begin
  ValueListEditor:=TValueListEditor(Sender);
  trackBar:=trackbars[ValueListEditor.tag];
  updateResults(startRes[trackBar.Tag],trackBar.Tag);
end;

procedure TForm3.TrackBarChange(Sender: TObject);
var
  trackBar:TTrackBar;
begin
  trackBar:=TTrackBar(Sender);
  startRes[trackBar.Tag]:=trackBar.Position;
  updateResults(startRes[trackBar.Tag],trackBar.Tag);
end;


procedure TForm3.ValueListEditor1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var
  c:integer;
  res:PSearchResult;
  ValueListEditor:TValueListEditor;
begin
  ValueListEditor:=TValueListEditor(Sender);
  c:=ValueListEditor.Tag;
  if ARow+startRes[c]-1<adrs[c].Count then
  begin
    PSearchResult(adrs[c].Items[ARow+startRes[c]-1])^.comment:=Value;
  end;
end;

procedure TForm3.ValueListEditor1DblClick(Sender: TObject);
var
  c:integer;
  res:PSearchResult;
  ValueListEditor:TValueListEditor;
begin
  ValueListEditor:=TValueListEditor(Sender);
  c:=ValueListEditor.Tag;
  if ValueListEditor.Row+startRes[c]-1<adrs[c].Count then
  begin
    jump(PSearchResult(adrs[c].Items[ValueListEditor.Row+startRes[c]-1])^.offset);
  end
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  a,b,c,d:integer;
  bb:tbytes;
  res:PSearchResult;
  tt:string;
  z:boolean;
  S:TS;
  Thread:TThreadID;
  t1:qword;
  visibleRows:integer;
begin
  aa:=tbytes(mm^);
  c:=length(adrs);
  setLength(adrs,c+1);
  adrs[c]:=TList.Create;
  if radioButton1.Checked then
  begin
    if checkBox1.Checked then
    begin
      bb:=text2bytesUnicodeLatin(comboBox1.Text);
    end
    else
    begin
      bb:=text2bytes(comboBox1.Text);
    end;
  end;
  if radioButton2.Checked then bb:=string2bytes(edit1.Text);
  z:=checkBox2.Checked;
  S.adrs:=adrs[c];
  S.aa:=aa;
  S.bb:=bb;
  S.z:=z;
  S.progress:=0;
  S.stop:=0;
  b:=0;
  form4.S:=@S;
  form4.tot:=length(aa)-length(bb);
  Thread:=BeginThread(@search,@S);
  form4.Timer1.Enabled:=True;
  form4.Left:=form3.Left+(form3.Width-form4.Width) div 2;
  form4.Top:=form3.Top+form3.Height div 3;
  form4.ShowModal;
  form4.Timer1.Enabled:=False;
  if radioButton1.Checked and (comboBox1.Items.IndexOf(comboBox1.Text)=-1) then comboBox1.items.insert(0,comboBox1.Text);
  if radioButton2.Checked and (comboBox2.Items.IndexOf(edit1.Text)=-1) then comboBox2.items.insert(0,edit1.Text);
  if adrs[c].Count>0 then
  begin
    if radioButton1.Checked then tt:=comboBox1.Text else tt:=edit1.Text;
    c:=length(tabs);
    setLength(tabs,c+1);
    setLength(edits,c+1);
    setLength(labels,c+1);
    setLength(ValueListEditors,c+1);
    setlength(trackBars,c+1);
    setlength(startRes,c+1);
    startRes[c]:=0;
    tabs[c] := TTabsheet.Create(PageControl1);
    if length(tt)<10 then tabs[c].Caption:=tt else tabs[c].Caption:=leftStr(tt,7)+'...';
    tabs[c].Parent := PageControl1;
    tabs[c].PageControl:= PageControl1;
    edits[c]:=TEdit.Create(tabs[c]);
    edits[c].Parent:=tabs[c];
    edits[c].Top:=0;
    edits[c].Align:=alTop;
    edits[c].ReadOnly:=true;
    edits[c].Text:=tt;
    labels[c]:=TLabel.Create(tabs[c]);
    labels[c].Parent:=tabs[c];
    labels[c].Top:=edits[c].Height;
    labels[c].Align:=alTop;
    trackBars[c]:=TTrackBar.Create(tabs[c]);
    trackBars[c].Parent:=tabs[c];
    trackBars[c].Orientation:=trVertical;
    trackBars[c].Align:=alRight;
    trackBars[c].Min:=0;
    trackBars[c].Tag:=c;
    trackBars[c].TickStyle:=tsNone;
    trackBars[c].DoubleBuffered:=true;
    trackBars[c].Position:=0;
    trackBars[c].OnChange:=@TrackBarChange;
    labels[c].Caption:=inttostr(adrs[c].Count)+' results out of '+ThousandSeparator(S.progress)+' bytes';
    if S.stop>1 then labels[c].Caption:=labels[c].Caption+' (interrupted by user)';
    ValueListEditors[c]:=TValueListEditor.Create(tabs[c]);
    ValueListEditors[c].Tag:=c;
    ValueListEditors[c].ScrollBars:=ssNone;
    ValueListEditors[c].Parent:=tabs[c];
    ValueListEditors[c].Top:=edits[c].Height+labels[c].Height;
    ValueListEditors[c].Align:=alClient;
    ValueListEditors[c].TitleCaptions.Add('Offset');
    ValueListEditors[c].TitleCaptions.Add('Comment');
    ValueListEditors[c].ColWidths[0]:=160;
    ValueListEditors[c].UseXORFeatures:=true;
    ValueListEditors[c].DoubleBuffered:=true;
    visibleRows:=min(adrs[c].Count-1,floor((ValueListEditors[c].Height)/ValueListEditors[c].RowHeights[0]))-2;
    trackBars[c].Max:=adrs[c].Count-visibleRows;
    ValueListEditors[c].OnPrepareCanvas:=@ValueListEditor1PrepareCanvas;
    ValueListEditors[c].OnMouseWheelDown:=@ValueListEditor1MouseWheelDown;
    ValueListEditors[c].OnMouseWheelUp:=@ValueListEditor1MouseWheelUp;
    ValueListEditors[c].OnKeyDown:=@ValueListEditor1KeyDown;
    ValueListEditors[c].OnSetEditText:=@ValueListEditor1SetEditText;
    ValueListEditors[c].OnDblClick:=@ValueListEditor1DblClick;
    tabs[c].Show;
  end
  else
  begin
    setLength(adrs,length(adrs)-1);
  end;
end;

function text2hexString(input:string;unicodeLatin:boolean=false):string;
var
  a,b,c:integer;
  d:string;
begin
  result:='';
  b:=length(input);
  for a:=1 to b do
  begin
    c:=ord(input[a]);
    result:=result+c.ToHexString(2);
    if unicodeLatin then result:=result+' 00';
    if a<b then result:=result+' ';
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if length(comboBox1.Text)>0 then
  begin
    if checkBox1.Checked then
    begin
      edit1.Text:=text2hexString(comboBox1.Text,true);
    end
    else
    begin
      edit1.Text:=text2hexString(comboBox1.Text);
    end;
    radioButton2.Checked:=true;
  end;
end;

procedure TForm3.ComboBox2EditingDone(Sender: TObject);
var
  a,b,c,d,e:integer;
  s:string;
  s2:string='';
begin
  s:=trim(ComboBox2.Text);
  a:=length(s);
  for b:= 1 to a do
  begin
    s2+=s[b];
    if (s[b]<>#32)and(b mod 2=0) then s2+=#32;
  end;
  ComboBox2.Text:=s2;
end;

procedure TForm3.ComboBox2Select(Sender: TObject);
begin
  edit1.Text:=comboBox2.Text;
end;

function removeInitialSpaces(a:string):string;
var
  b,c:integer;
begin
  c:=length(a);
  if c=0 then
  begin
    result:='';
    exit;
  end;
  b:=1;
  while (b<=c)and(a[b]=#32)do inc(b);
  exit(copy(a,b,c));
end;

procedure TForm3.Edit1Change(Sender: TObject);
var
  a,b,c,d:integer;
  e:single;
  s:string;
  s2:string='';
begin
  radioButton2.Checked:=true;
  Edit1.OnChange:=nil;
  s:=Edit1.Text;
  e:=Edit1.Selstart/length(s);
  s:=trim(s);
  s:=stringReplace(s,' ','',[rfReplaceAll]);
  a:=length(s);
  for b:= 1 to a do
  begin
    c:=length(s2);
    if ((c+1) mod 3=0)and(s[b]<>#32) then s2+=#32;
    s2+=s[b];
  end;
  Edit1.Text:=s2;
  Edit1.SelStart:=ceil(e*length(s2));
  Edit1.OnChange:=@Edit1Change;
end;

procedure TForm3.Edit1Click(Sender: TObject);
begin
    radioButton2.Checked:=true;
end;

procedure TForm3.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if key=13 then button2.Click;
end;

procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (key<>#08)and(key<>#32) then
  begin
    try
      hex2dec(key);
    except
      key:=#0;
    end;
  end;
  key:=uppercase(key)[1];
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  setLength(tabs,0);
  setLength(adrs,0);
  setLength(ValueListEditors,0);
  setLength(edits,0);
  setLength(labels,0);
  setLength(trackBars,0);
  setLength(startRes,0);
    Self.ShowInTaskbar := stNever;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  reset;
end;

procedure TForm3.FormResize(Sender: TObject);
var
  trackBar:TTrackBar;
  a:integer;
begin
  for a:=0 to length(adrs)-1 do
  begin
    updateResults(trackBars[a].Position,trackBars[a].Tag);
  end;
end;

end.

