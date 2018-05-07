uses GraphABC,Timers,MyPlayground,MyApple,MySnake,MyQueue;
var
  x1, y1, x2, y2, cellSize: integer;
  playground: MyPlayground.Playground;
  arrayOfEmptys:MyQueue.Queue = MyQueue.Queue.Create();
  speed:integer := 500;
  iterator:integer := 0;
  timer:Timers.Timer;
  
procedure SnakeHandler();
var
  snakeHeadX:integer;
  snakeHeadY:integer;
begin
  playground.snake.Move();
  
  snakeHeadX := playground.snake.GetHead()[0];
  snakeHeadY := playground.snake.GetHead()[1];
  
  if (snakeHeadX = playground.apple.x) and (snakeHeadY = playground.apple.y) then begin
    playground.snake.snakeGrow := true;
    playground.apple.RemoveApple();
    arrayOfEmptys:=playground.GetArrayOfEmptys();
    
    playground.apple.SetApple(arrayOfEmptys);
  end;
 
  if (playground.ItShouldBeBorder(snakeHeadX, snakeHeadY)) or (playground.ItShouldBeSnake(snakeHeadX, snakeHeadY)) then begin
    timer.Stop();
    GraphABC.TextOut(0, GraphABC.Window.Height - 16, 'Game Over');
    Redraw();
  end;
end;

procedure CollisionHandler();
var
  snakeHeadX:integer := playground.snake.GetHead()[0];
  snakeHeadY:integer := playground.snake.GetHead()[1];
begin
  
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
  
  SnakeHandler(); // Обработчик движения змейки
  
  playground.Update(x1, y1, GraphABC.Window.Width - 80, GraphABC.Window.Height - 80);
  playground.Render();
  
  CollisionHandler(); // Обработчик столкновений
  
  GraphABC.TextOut(0, 0, iterator.ToString());
  GraphABC.TextOut(0, 16, 'snake head: [' + playground.snake.GetHead()[0].ToString() + '][' + playground.snake.GetHead()[1].ToString());
  GraphABC.TextOut(0,48,'Apple: ['+playground.apple.GetApple[0].ToString+']['+playground.apple.GetApple[1].ToString+']');
  Inc(iterator);
  
  Redraw();
end;

begin
  timer := Timers.Timer.Create(speed, Update);
  timer.Start();
  
  OnKeyDown := KeyDown;
  
  x1 := 80;
  y1 := 100;
  x2 := 360;
  y2 := 260;
  cellSize := 20;
  
  playground := MyPlayground.Playground.Create(x1, y1, GraphABC.Window.Width - 80, GraphABC.Window.Height - 80, cellSize);
  playground.Render();
  arrayOfEmptys := playground.GetArrayOfEmptys();
end.