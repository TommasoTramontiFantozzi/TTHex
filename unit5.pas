unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin, ComCtrls,StrUtils;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    UpDown1: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    function value():uint64;
  private

  public
    address:uint64;
  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.Edit1Change(Sender: TObject);
begin

end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  modalresult:=-1;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  address:=value();
  modalresult:=1;
end;

procedure TForm5.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if key=13 then button1.click;
  if key=27 then Button2.click;
end;

procedure TForm5.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#08 then exit;
  if (key='$')then
  begin
    if(edit1.SelStart>0) then key:=#0;
    RadioButton1.OnChange:=nil;
    RadioButton2.OnChange:=nil;
    radiobutton2.Checked:=true;
    RadioButton1.OnChange:=@RadioButton1Change;
    RadioButton2.OnChange:=@RadioButton2Change;
    exit;
  end;
  if (key='x') then
  begin
    if((edit1.SelStart<>1)or(pos('0',edit1.text)<>1)) then key:=#0;
    RadioButton1.OnChange:=nil;
    RadioButton2.OnChange:=nil;
    radiobutton2.Checked:=true;
    RadioButton1.OnChange:=@RadioButton1Change;
    RadioButton2.OnChange:=@RadioButton2Change;
    exit;
  end;
  if (pos('0x',edit1.Text)=1)or(pos('$',edit1.Text)=1) then
  begin
    RadioButton1.OnChange:=nil;
    RadioButton2.OnChange:=nil;
    radiobutton2.Checked:=true;
    RadioButton1.OnChange:=@RadioButton1Change;
    RadioButton2.OnChange:=@RadioButton2Change;
    try
      Hex2Dec(key);
      key:=upperCase(key)[1];
    except
      key:=#0;
    end;
  end
  else
  begin
   RadioButton1.OnChange:=nil;
   RadioButton2.OnChange:=nil;
   radiobutton1.Checked:=true;
   RadioButton1.OnChange:=@RadioButton1Change;
   RadioButton2.OnChange:=@RadioButton2Change;
   if not(key in ['0'..'9']) then key:=#0;
  end;
end;

procedure TForm5.RadioButton1Change(Sender: TObject);
var
  a:string;
  b:uint64;
  c:boolean=false;
begin
  if RadioButton1.Checked=false then exit;
  RadioButton2.OnChange:=nil;
  a:=edit1.Text;
  if pos('$',a)=1 then
  begin
    try
      b:=hex2dec(copy(a,2,length(a)));
      c:=true;
    except
      b:=0;
    end;
  end;
  if pos('0x',a)=1 then
  begin
    try
      b:=hex2dec(copy(a,3,length(a)));
      c:=true;
    except
      b:=0;
    end;
  end;
  if c then edit1.Text:=inttostr(b);
  RadioButton2.OnChange:=@RadioButton2Change;
end;

procedure TForm5.RadioButton2Change(Sender: TObject);
var
  a:string;
  b:uint64;
begin
  a:=edit1.Text;
  if (pos('$',a)=1)or(pos('0x',a)=1) then exit;
  try
    b:=strtoint(a);
    a:=b.ToHexString(2);
  except
    a:='';
  end;
  RadioButton1.OnChange:=nil;
  edit1.Text:='$'+a;
  RadioButton1.OnChange:=@RadioButton1Change;
end;

function TForm5.value():uint64;
var
  a:string;
  c:boolean=false;
  h:boolean=false;
begin
  a:=edit1.Text;
  if pos('$',a)=1 then
  begin
    h:=true;
    try
      result:=hex2dec(copy(a,2,length(a)));
      c:=true;
    except
      result:=0;
    end;
  end;
  if pos('0x',a)=1 then
  begin
    h:=true;
    try
      result:=hex2dec(copy(a,3,length(a)));
      c:=true;
    except
      result:=0;
    end;
  end;
  if h=false then
  begin
    try
      result:=strtoint(a);
    except
      result:=0;
    end;
  end;
end;

procedure TForm5.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
  b:uint64;
begin
  b:=value;
  if (Button=btNext)and(b<18446744073709551615) then inc(b);
  if (Button=btPrev)and(b>0) then dec(b);

  edit1.OnChange:=nil;
  if (pos('$',edit1.text)=1)or(pos('0x',edit1.text)=1) then
  begin
    edit1.text:='$'+b.ToHexString(2);
  end
  else
  begin
    edit1.text:=inttostr(b);
  end;
  edit1.OnChange:=@Edit1Change;
end;

end.

