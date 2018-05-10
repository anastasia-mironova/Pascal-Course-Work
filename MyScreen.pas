unit MyScreen;

interface
type 
  Screen = class
    name: string;
    InitializeProc:procedure; 
    UpdateProc: procedure;
    KeyDown: procedure (key: integer);
    active: boolean:= false; 
    
    constructor Create(name: string; InitializeProc:procedure; UpdateProc:procedure; KeyDown: procedure (key: integer));
  end;
implementation

constructor Screen.Create(name: string; InitializeProc:procedure; UpdateProc:procedure; KeyDown: procedure(key: integer));
begin
  Self.name:=name;
  Self.InitializeProc := InitializeProc;
  Self.UpdateProc:=UpdateProc;
  Self.KeyDown:=KeyDown;
end;
initialization

 

finalization

 

end. 

