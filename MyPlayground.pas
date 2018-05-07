unit MyPlayground;

interface

uses GraphABC, MySnake, MyApple, MyQueue;
type
  Playground = class
    x1: integer;
    y1: integer;
    x2: integer;
    y2: integer;
    cellSize: integer;
    field: array [,] of integer;
    
    const emptyId :integer = 0;
    const borderId: integer = 1;
    const snakeId: integer = 2;
    const snakeHeadId :integer = 4;
    const appleId: integer = 3;
    
    snake: MySnake.Snake;
    apple: MyApple.Apple;
    
    constructor Create(iX1: integer; iY1: integer; iX2: integer; iY2: integer; iCellSize: integer);
    
    procedure Render();
    procedure Update(x1:integer; y1:integer; x2:integer; y2:integer);
    procedure SetPlaygroundObjects();
    procedure SetBorder;
    
    function GetArrayOfEmptys():MyQueue.Queue;
    function ItShouldBe(x:integer; y:integer):string;
    function ItShouldBeBorder(x:integer; y:integer):boolean;
    function ItShouldBeApple(x:integer; y:integer):boolean;
    function ItShouldBeSnake(x:integer; y:integer):boolean;
    function ItShouldBeSnakeHead(x:integer; y:integer):boolean;
    function Width(): integer;
    function Heigth(): integer;
    function Columns(): integer;
    function Rows(): integer;
  
  end;

implementation

constructor Playground.Create(iX1: integer; iY1: integer; iX2: integer; iY2: integer; iCellSize: integer);
begin
  x1 := iX1;
  y1 := iY1;
  x2 := iX2;
  y2 := iY2;
  cellSize := iCellSize;
  SetLength(field, Columns(), Rows());
  
  snake := MySnake.Snake.Create(3, 3);
  apple := MyApple.Apple.Create(1, 1);
  
  SetPlaygroundObjects();
end;
// procedure
procedure Playground.SetPlaygroundObjects();
begin
  for var j := 0 to rows() - 1 do 
    for var i := 0 to columns() - 1 do
    begin
      case ItShouldBe(i ,j) of 
        'Border': field[i, j] := borderId;
        'Apple': field[i, j] := appleId;
        'Snake': field[i, j] := snakeId;
        'Snake Head': field[i, j] :=snakeHeadId;
        'Empty': field[i, j] := emptyId;
      end;
    end;
end;

procedure Playground.SetBorder();
begin
  for var i := 0 to rows() - 1 do 
    for var j := 0 to columns() - 1 do
    begin
      if (i = 0) or (i = (rows() - 1)) or (j = 0) or (j = columns() - 1) then
        field[i, j] := borderId;
    end;
end;

procedure Playground.Render();
var
  currentColor:GraphABC.Color;
begin
  GraphABC.SetPenColor(clDarkBlue);
  GraphABC.DrawRectangle(x1, y1, x1 + cellSize * Columns() + 1, y1 + cellSize * Rows() + 1);
  
  for var i := 1 to Columns() - 1 do 
  begin
    GraphABC.SetPenColor(rgb(211, 211, 211));
    GraphABC.Line(x1 + i * cellSize, y1, x1 + i * cellSize, y1 + cellSize * Rows());
  end;
  
  for var i := 1 to Rows() - 1 do 
  begin
    GraphABC.SetPenColor(rgb(211, 211, 211));
    GraphABC.Line(x1, y1 + i * cellSize, x1 + cellSize * Columns(), y1 + i * cellSize);
  end;
  
  for var j := 0 to rows() - 1 do 
    for var i := 0 to columns() - 1 do
    begin
      case field[i, j] of
        borderId : currentColor := rgb(32, 178, 170);
        snakeId : currentColor := rgb(70, 130, 180);
        snakeHeadId: currentColor := rgb(238, 130, 238);
        appleId: currentColor := rgb(144, 238, 144);
        emptyId: currentColor := rgb(240, 248, 255);
      end;
      
      GraphABC.SetBrushColor(currentColor);
      GraphABC.FillRect(x1 + i * cellsize + 1, y1 + j * cellsize + 1, x1 + i * cellsize + cellsize, y1 + j * cellsize + cellsize);
    end;
end;

procedure Playground.Update(x1:integer; y1:integer; x2:integer; y2:integer);
begin
  Self.x1 := x1;
  Self.y1 := y1;
  Self.x2 := x2;
  Self.y2 := y2;
  
  SetLength(field, Columns(), Rows());
  
  SetPlaygroundObjects();
end;

// function
function Playground.GetArrayOfEmptys():MyQueue.Queue;
begin
  Result := MyQueue.Queue.Create();
  
  for var j:=0 to Rows()-1 do 
  begin
     for var i:=0 to Columns()-1 do
     begin
       if (field[i,j]=emptyId)then begin
        Result.Push(i,j);
       end;
     end;
  end;
end;

function Playground.ItShouldBeBorder(x:integer; y:integer):boolean;
begin
  if (y = 0) or (y = (rows() - 1)) or (x = 0) or (x = columns() - 1) then begin
    Result := true;
  end;
end;

function Playground.ItShouldBeApple(x:integer; y:integer):boolean;
begin
  if (apple.x = x) and (apple.y = y) then begin
    Result := True;
  end;
end;

function Playground.ItShouldBeSnake(x:integer; y:integer):boolean;
begin
  for var i := 1 to snake.queue.length - 1 do begin
    if (snake.queue.queue[i, 0] = x) and (snake.queue.queue[i, 1] = y) then begin
      Result := True;
      exit;
    end;
  end;
end;

function Playground.ItShouldBeSnakeHead(x:integer; y:integer):boolean;
begin
  if (snake.GetHead()[0] = x) and (snake.GetHead()[1] = y) then begin
    Result := True;
  end;
end;

function Playground.ItShouldBe(x:integer; y:integer):string;
begin
  Result := 'Empty';
  
  if ItShouldBeSnakeHead(x, y) then begin
    Result := 'Snake Head';
    exit;
  end;
  
  if ItShouldBeSnake(x, y) then begin
    Result := 'Snake';
    exit;
  end;
  
  if ItShouldBeBorder(x, y) then begin
    Result := 'Border';
    exit;
  end;
  
  if ItShouldBeApple(x, y) then begin
    Result := 'Apple';
    exit;
  end;
end;

function Playground.Width(): integer;
begin
  Result := x2 - x1;
end;


function Playground.Heigth(): integer;
begin
  Result := y2 - y1;
end;

function Playground.Columns(): integer;
begin
  Result := Width() div cellSize;
end;

function Playground.Rows(): integer;
begin
  Result := Heigth() div cellSize;
end;

initialization

finalization

end. 