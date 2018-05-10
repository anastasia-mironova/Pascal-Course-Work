unit MyButton;

interface
uses GraphABC;
type
  button = class
    x: integer := 0;
    y: integer := 0;
    width: integer;
    height: integer;
    focus: boolean := false;
    texture: Picture;
    textureFocus: Picture;
    actionProc: procedure;
    
    constructor Create(actionProc: procedure; texturePath: string; textureFocusPath: string);
    procedure Render(x: integer; y: integer);
  end;


implementation

constructor Button.Create(actionProc: procedure; texturePath: string; textureFocusPath: string);
begin
  Self.texture := new Picture(texturePath);
  Self.textureFocus := new Picture(textureFocusPath);
  Self.width := Self.texture.Width;
  Self.height := Self.texture.Height;
  Self.actionProc := actionProc;
end;
//Procedure

procedure Button.Render(x: integer; y: integer);
begin
  if focus then begin
    textureFocus.Draw(x, y);
  end
  else begin
    texture.Draw(x, y);
  end;
end;

initialization


finalization


end. 

