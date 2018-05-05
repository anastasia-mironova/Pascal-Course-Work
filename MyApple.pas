unit MyApple;

interface
uses MyQueue;
type
  Apple = class
    x: integer;
    y: integer;
    arrayOfEmptys: MyQueue.Queue;
    constructor Create(x: integer; y: integer);
    
    procedure SetApple(arrayOfEmptys:MyQueue.Queue);
    procedure RemoveApple();
    
    function GetApple():array of integer;
  end;


implementation

constructor Apple.Create(x: integer; y: integer);
begin
  Self.x := x;
  Self.y := y;
end;

procedure Apple.SetApple(arrayOfEmptys:MyQueue.Queue);
begin
  var arrayLength:=arrayOfEmptys.length - 1;
  var randomIndex:=random(arrayLength);
  self.x:=arrayOfEmptys.queue[randomIndex,0];
  self.y:=arrayOfEmptys.queue[randomIndex,1];
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
