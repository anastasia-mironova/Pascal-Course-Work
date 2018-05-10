unit MyMenu;

interface
uses GraphABC,MyButton;
type
  Menu = class
    x: integer := 0;
    y: integer := 0;
    
    padding: integer := 35;
    
    buttons: array of MyButton.button;
    constructor Create();
    
    procedure AddButton(actionProc: procedure; texturePath: string; textureFocusPath: string);
    procedure Render();
    procedure Update(x: integer; y: integer);
    procedure MoveFocusUp();
    procedure MoveFocusDown();
    procedure ActionActiveButton();
    
    function Width(): integer;
    function Heigth(): integer;
    function GetFocusedButtonIndex():integer;
  end;

implementation

constructor Menu.Create();
begin
  SetLength(buttons, 0);
end;

  //Procedure

procedure Menu.AddButton(actionProc: procedure; texturePath: string; textureFocusPath: string);
begin
  var button := new MyButton.button(actionProc, texturePath, textureFocusPath);
  
  if buttons.Length = 0 then begin
    button.focus := true;
  end;
  
  SetLength(buttons, buttons.Length + 1);
  buttons[buttons.Length - 1] := button;
end;

procedure Menu.Render();
begin
  for var i := 0 to buttons.Length - 1 do 
  begin
    buttons[i].Render(Self.x, Self.y + i * (buttons[i].height + Self.padding));
  end;
end;

procedure Menu.Update(x: integer; y: integer);
begin
  Self.x := Trunc(x);
  Self.y := Trunc(y);
end;

procedure Menu.MoveFocusUp();
begin
 var buttonIndex:=GetFocusedButtonIndex();
 buttons[buttonIndex].focus := false;
 
  if buttonIndex=0 then begin
    buttons[buttons.Length-1].focus:=true
  end
  else begin
    buttons[buttonIndex-1].focus:=true
  end;
end;

procedure Menu.MoveFocusDown();
begin
  var buttonIndex:=GetFocusedButtonIndex();
  buttons[buttonIndex].focus := false;
  
    if buttonIndex=buttons.Length-1 then begin
      buttons[0].focus:=true
    end
    else begin
      buttons[buttonIndex+1].focus:=true
    end;
end;

procedure Menu.ActionActiveButton();
begin
  var buttonIndex := GetFocusedButtonIndex();
  buttons[buttonIndex].actionProc();
end;

  //Function

function Menu.Width(): integer;
begin
  for var i := 0 to Self.buttons.Length - 1 do 
  begin
    if Result < buttons[i].width then begin
      Result := buttons[i].width;
    end;
  end;
end;

function Menu.Heigth(): integer;
begin
  for var i := 0 to Self.buttons.Length - 1 do 
  begin
    Result += buttons[i].height;
    if i > 0 then begin
      Result += Self.padding;
    end;
  end;
end;

function Menu.GetFocusedButtonIndex():integer;
begin
  for var i:=0 to buttons.Length -1 do 
  begin
    if buttons[i].focus then begin
      Result:=i;
      exit;
    end;
  end;
end;

initialization


finalization


end. 

