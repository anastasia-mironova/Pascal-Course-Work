unit MyApple;

interface

type
  Apple = class
    x: integer;
    y: integer;
    constructor Create(x: integer; y: integer);
    
    procedure SetApple(x:integer; y:integer);
    procedure RemoveApple();
    
    function GetApple():array of integer;
  end;


implementation

constructor Apple.Create(x: integer; y: integer);
begin
  Self.x := x;
  Self.y := y;
end;

procedure Apple.SetApple(x:integer; y:integer);
begin
  Self.x := x;
  Self.y := y;
end;

procedure Apple.RemoveApple();
begin
  Self.x := 0;
  Self.y := 0;
end;

// Functions 
function Apple.GetApple():array of integer;
begin
  SetLength(Result, 2);
  Result[0] := x;
  Result[1] := y;
end;

initialization

finalization

end.
