unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls;

type TS=record
   adrs:TList;
   aa:tbytes;
   bb:tbytes;
   z:boolean;
   progress:longword;
   stop:longint;
end;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    finished:boolean;
  public
    S:pointer;
    tot:int64;
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  InterLockedIncrement(TS(S^).stop);
  modalresult:=-1;
end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if finished=false then InterLockedIncrement(TS(S^).stop);
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  progressBar1.Position:=0;
  finished:=false;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
var
  a:single;
  b:integer;
begin
  a:=TS(S^).progress;
  a:=a/tot*100;
  label1.Caption:=FloatToStrF(a, ffFixed, 8, 2)+' %';
  b:=round(a);
  progressBar1.Position:=b;
  if (TS(S^).stop>0) then
  begin
    finished:=true;
    form4.Close;
  end;
end;

end.

