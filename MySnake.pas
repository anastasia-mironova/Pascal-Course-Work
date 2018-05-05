unit MySnake;

interface

uses MyQueue;

type
  Snake = class
    queue: MyQueue.Queue;
    direction: string := 'up';
    snakeGrow: boolean := false;
    constructor Create(x: integer; y: integer);
    procedure MoveUp();
    procedure MoveDown();
    procedure MoveRight();
    procedure MoveLeft();
    procedure Move();
    function GetHead(): array of integer;
  end;

implementation

constructor Snake.Create(x: integer; y: integer);
begin
  queue := MyQueue.Queue.Create(x, y);
end;

function Snake.GetHead(): array of integer;
begin
  setlength(result, 2);
  Result[0] := queue.queue[0, 0];
  Result[1] := queue.queue[0, 1];
end;

procedure Snake.MoveUp();
var
  snakeHead: array of integer;
  x, y: integer;
begin
  snakeHead := GetHead();
  x := snakeHead[0];
  y := snakeHead[1];
  queue.Unshift(x, y - 1);
  if snakeGrow then
    snakeGrow := false
  else queue.Pop();
end;

procedure Snake.MoveDown();
var
  snakeHead: array of integer;
  x, y: integer;
begin
  snakeHead := GetHead();
  x := snakeHead[0];
  y := snakeHead[1];
  queue.Unshift(x, y + 1);
  if snakeGrow then
    snakeGrow := false
  else queue.Pop();
end;

procedure Snake.MoveRight();
var
  snakeHead: array of integer;
  x, y: integer;
begin
  snakeHead := GetHead();
  x := snakeHead[0];
  y := snakeHead[1];
  queue.Unshift(x + 1, y);
  if snakeGrow then
    snakeGrow := false
  else queue.Pop();
end;

procedure Snake.MoveLeft();
var
  snakeHead: array of integer;
  x, y: integer;
begin
  snakeHead := GetHead();
  x := snakeHead[0];
  y := snakeHead[1];
  queue.Unshift(x - 1, y);
  if snakeGrow then
    snakeGrow := false
  else queue.Pop();
end;

procedure Snake.Move();
begin
  case direction of
    'up': MoveUp();
    'down': MoveDown();
    'right': MoveRight();
    'left': MoveLeft();
  end;
end;

initialization

finalization

end. 