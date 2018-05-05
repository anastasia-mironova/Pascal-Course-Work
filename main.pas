uses GraphABC,Timers,MyPlayground,MyApple,MySnake;
var
  x1, y1, x2, y2, cellSize: integer;
  playground: MyPlayground.Playground;
  speed:integer := 500;
  iterator:integer := 0;
  
procedure SnakeHandler();
begin
  playground.snake.Move();
  
  if (playground.snake.GetHead()[0] = playground.apple.x) and (playground.snake.GetHead()[1] = playground.apple.y) then begin
    playground.snake.snakeGrow := true;
  end;
end;
  
procedure KeyDown(Key:integer);
begin
  case Key of 
    VK_Up: playground.snake.direction := 'up';
    VK_Right: playground.snake.direction := 'right';
    VK_Down: playground.snake.direction := 'down';
    VK_Left: playground.snake.direction := 'left';
  end;
end;
  
procedure Update();
begin
  LockDrawing();
  
  GraphABC.ClearWindow();
  SnakeHandler();
  
  playground.Update();
  playground.Render();
  
  GraphABC.TextOut(0, 0, iterator.ToString());
  GraphABC.TextOut(0, 16, 'snake head: [' + playground.snake.GetHead()[0].ToString() + '][' + playground.snake.GetHead()[1].ToString());
  Inc(iterator);
  
  Redraw();
end;

begin
  var timer := Timers.Timer.Create(speed, Update);
  timer.Start();
  
  OnKeyDown := KeyDown;
  
  x1 := 80;
  y1 := 100;
  x2 := 360;
  y2 := 260;
  cellSize := 20;
  
  playground := MyPlayground.Playground.Create(x1, y1, x2, y2, cellSize);
end.