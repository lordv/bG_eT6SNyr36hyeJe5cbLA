Program Demo1;

uses WinTypes, WinProcs, WObjects; 
{Tells the compiler which libraries are needed}

type
  PTheWindow = ^TTheWindow;  
{creates a pointer ready for the main window}
  TTheWindow = object(TWindow) 
{assigns the pointer to the window}
    procedure Paint(PaintDC: HDC;  
var PaintInfo: TPaintStruct); virtual;
end;

{ The procedure Paint is included because}
{ Windows frequently hides one}
{ window behind another. Paint recreates} 
{ what has been covered over}

TTheApplication = object(TApplication)
  procedure InitMainWindow; virtual;
end;

procedure TTheWindow.Paint;
begin
  {later, we'll draw certain graphics by}
{ adding to this procedure}
end;

procedure TTheApplication.InitMainWindow; 
{Here's TApplication!}
begin
  MainWindow := New(PTheWindow, Init(nil, 'A Program')); 
{Create the window}
end;

var
  TheApp: TTheApplication;

begin
  TheApp.Init('A Program');
  TheApp.Run;
  TheApp.Done;
end.

