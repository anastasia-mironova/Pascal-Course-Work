unit MyPlayground;

interface

uses GraphABC, MySnake, MyApple;
type
  Playground = class
    x1: integer;
    y1: integer;
    x2: integer;
    y2: integer;
    cellSize: integer;
    field: array [,] of integer;
    
    emptyId :integer := 0;
    borderId: integer := 1;
    snakeId: integer := 2;
    appleId: integer := 3;
    
    snake: MySnake.Snake;
    apple: MyApple.Apple;
    
    constructor Create(iX1: integer; iY1: integer; iX2: integer; iY2: integer; iCellSize: integer);
    
    procedure Render();
    procedure Update();
    procedure SetPlaygroundObjects();
    procedure SetBorder;
    
    function GetArrayOfEmptys():MyQueue.Queue;
    function ItShouldBe(x:integer; y:integer):string;
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
begin
  GraphABC.SetPenColor(clDarkBlue);
  GraphABC.DrawRectangle(x1, y1, x2 + 1, y2 + 1);
  
  for var i := 1 to Columns() - 1 do 
  begin
    GraphABC.SetPenColor(clFirebrick);
    GraphABC.Line(x1 + i * cellSize, y1, x1 + i * cellSize, y2);
  end;
  
  for var i := 1 to Rows() - 1 do 
  begin
    GraphABC.SetPenColor(clFirebrick);
    GraphABC.Line(x1, y1 + i * cellSize, x2, y1 + i * cellSize);
  end;
  
  for var j := 0 to rows() - 1 do 
    for var i := 0 to columns() - 1 do
    begin
      if field[i, j] = borderId then begin
        GraphABC.SetBrushColor(clRed);
        GraphABC.FillRect(x1 + i * cellsize + 1, y1 + j * cellsize + 1, x1 + i * cellsize + cellsize, y1 + j * cellsize + cellsize);
      end;
      if field[i, j] = snakeId then begin
        GraphABC.SetBrushColor(clBlue);
        GraphABC.FillRect(x1 + i * cellsize + 1, y1 + j * cellsize + 1, x1 + i * cellsize + cellsize, y1 + j * cellsize + cellsize);
      end;
      if field[i, j] = appleId then begin
        GraphABC.SetBrushColor(clGreen);
        GraphABC.FillRect(x1 + i * cellsize + 1, y1 + j * cellsize + 1, x1 + i * cellsize + cellsize, y1 + j * cellsize + cellsize);
      end;
      {case field[i,j] of 
      1:SetBrushColor(clRed);
      2:SetBrushColor(clBlue);
      3:SetBrushColor(clGreen);
      end;
      GraphABC.FillRect(x1+i*cellsize+1,y1+j*cellsize+1,x1+i*cellsize+cellsize,y1+j*cellsize+cellsize);}
    end;
end;

procedure Playground.Update();
begin
  SetPlaygroundObjects();
end;

// function
function Playground.ItShouldBe(x:integer; y:integer):string;
begin
  Result := 'Empty';

  if (apple.x = x) and (apple.y = y) then begin
    Result := 'Apple';
  end;
  
  if (y = 0) or (y = (rows() - 1)) or (x = 0) or (x = columns() - 1) then begin
    Result := 'Border';
  end;
  
  for var i := 0 to snake.queue.length - 1 do begin
    if (snake.queue.queue[i, 0] = x) and (snake.queue.queue[i, 1] = y) then begin
      Result := 'Snake';
      break;
    end;
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