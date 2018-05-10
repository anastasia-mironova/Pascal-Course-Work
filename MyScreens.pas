unit MyScreens;

interface
uses MyScreen;
type 
  Screens= class 
    screens: array of screen;
  
    constructor Create();
    begin
      SetLength(screens,0)
    end;
    
    procedure AddScreen(name: string; InitializeProc:procedure; UpdateProc:procedure; KeyDown: procedure (key: integer));
    procedure Activate(name:string);
    procedure RenderActive();
    procedure InitializeActive();
    
    function GetActiveScreenIndex():integer;
    function GetActiveScreenKeyDown():procedure (Key:integer);
  end;
implementation

procedure Screens.AddScreen(name: string; InitializeProc:procedure; UpdateProc:procedure; KeyDown: procedure (key: integer));
begin
  var screen := new MyScreen.Screen(name, InitializeProc, UpdateProc, KeyDown);
  SetLength(screens, screens.Length + 1);
  screens[screens.Length - 1] := screen;
end;

procedure Screens.Activate(name:string);
begin
  var activeScreenIndex := GetActiveScreenIndex();
  screens[activeScreenIndex].active := false;

  for var i := 0 to screens.Length - 1 do begin
    if screens[i].name = name then begin
      screens[i].active := true;
    end;
  end;
end;

procedure Screens.RenderActive();
begin
  var activeScreenIndex := GetActiveScreenIndex();
  screens[activeScreenIndex].UpdateProc();
end;

procedure Screens.InitializeActive();
begin
  var activeSCreenIndex := GetActiveScreenIndex();
  screens[activeScreenIndex].InitializeProc();
end;

// Functions
function Screens.GetActiveScreenIndex():integer;
begin
  for var i := 0 to screens.Length - 1 do begin
    if screens[i].active then begin
      Result := i;
    end;
  end;
end;

function Screens.GetActiveScreenKeyDown():procedure (Key:integer);
begin
  var activeScreenIndex := GetActiveScreenIndex();
  Result := screens[activeScreenIndex].KeyDown;
end;
initialization

 

finalization

 

end. 
