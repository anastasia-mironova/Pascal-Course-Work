uses GraphABC,Timers,MyPlayground,MyApple,MySnake,MyQueue,MyScreens,MyMenu;
var
  x1:integer := 100;
  y1:integer := 80;
  cellSize: integer := 20;
  
  menuSoundtrack:System.Media.SoundPlayer;
  gameSoundtrack:System.Media.SoundPlayer;
  
  screens: MyScreens.Screens;
  mainMenu: MyMenu.Menu;
  pauseMenu :MyMenu.Menu;
  playground: MyPlayground.Playground;
  arrayOfEmptys: MyQueue.Queue = MyQueue.Queue.Create();
  speed: integer := 500;
  iterator: integer := 0;
  timer: Timers.Timer;

procedure EmptyProc();
begin
end;

procedure SnakeHandler();
var
  snakeHeadX: integer;
  snakeHeadY: integer;
begin
  playground.snake.Move();
  
  snakeHeadX := playground.snake.GetHead()[0];
  snakeHeadY := playground.snake.GetHead()[1];
  
  if (snakeHeadX = playground.apple.x) and (snakeHeadY = playground.apple.y) then begin
    playground.snake.snakeGrow := true;
    playground.apple.RemoveApple();
    score := score + 1;
    arrayOfEmptys := playground.GetArrayOfEmptys();
    
    playground.apple.SetApple(arrayOfEmptys);
  end;
  
  if (playground.ItShouldBeBorder(snakeHeadX, snakeHeadY)) or (playground.ItShouldBeSnake(snakeHeadX, snakeHeadY)) then begin
    screens.Activate('Game over');
  end;
end;

procedure CollisionHandler();
var
  snakeHeadX: integer := playground.snake.GetHead()[0];
  snakeHeadY: integer := playground.snake.GetHead()[1];
begin
  
end;

procedure Update();
begin
  LockDrawing();
  
  GraphABC.ClearWindow();
  
  screens.RenderActive();
  OnKeyDown := screens.GetActiveScreenKeyDown;
  
  CollisionHandler(); // Обработчик столкновений
  
  GraphABC.TextOut(2, 24, 'Time: ' + iterator.ToString());
 
  Inc(iterator);
  
  Redraw();
end;

// Game
procedure GameInitialize();
begin
  playground := MyPlayground.Playground.Create(x1, y1, GraphAbc.WindowWidth - 40, GraphABC.WindowHeight - 40, cellSize);
end;

procedure GameProc();
begin
  SnakeHandler(); // Обработчик движения змейки
  
  playground.Update(x1, y1, GraphAbc.WindowWidth - 40, GraphABC.WindowHeight - 40);
  playground.Render();
end;

procedure GameKeyDown(Key:integer);
begin
  case Key of 
    VK_Up: playground.snake.direction := 'up';
    VK_Right: playground.snake.direction := 'right';
    VK_Down: playground.snake.direction := 'down';
    VK_Left: playground.snake.direction := 'left';
    27: screens.Activate('Pause menu');
  end;
end;

// Menu
procedure MainMenuProc();
begin
  mainMenu.Update((GraphABC.Window.Width - mainMenu.Width()) div 2, (GraphABC.Window.Height - mainMenu.Heigth()) div 2);
  mainMenu.Render();
end;

procedure MainMenuKeyDown(Key:integer);
begin
  case Key of
    VK_Up:mainMenu.MoveFocusUp();
    VK_Down:mainMenu.MoveFocusDown();
    VK_Enter:mainMenu.ActionActiveButton();
  end;
end;

procedure btnNewGame();
begin
  screens.Activate('Game');
  screens.InitializeActive();
end;

procedure btnExit();
begin
  Halt();
end;

procedure btnContinue();
begin
  screens.Activate('Game');
end;

// Game over
procedure GameOverProc();
begin
  var gameOverImage := new GraphABC.Picture('game_over/game_over.jpg');
  gameOverImage.Draw((GraphABC.Window.Width - gameOverImage.Width) div 2, (GraphABC.Window.Height - gameOverImage.Height) div 2);
end;

procedure GameOverKeyDown(Key:integer);
begin
  case Key of
    VK_Enter:screens.Activate('Main menu');
    27:screens.Activate('Main menu');
  end;
end;
// Pause menu
procedure PauseMenuProc();
begin
pauseMenu.Update((GraphABC.Window.Width - pauseMenu.Width()) div 2, (GraphABC.Window.Height - pauseMenu.Heigth()) div 2);
pauseMenu.Render();
end;

procedure PauseMenuKeyDown(key:integer);
begin
  case key of 
    VK_Up:pauseMenu.MoveFocusUp();
    VK_Down:pauseMenu.MoveFocusDown();
    VK_Enter:pauseMenu.ActionActiveButton();
  end;
end;

// Main function

begin
  timer := Timers.Timer.Create(speed, Update);
  timer.Start();
  
//  menuSoundtrack := System.Media.SoundPlayer.Create('sound/DanceDance.wav');
 // menuSoundtrack.PlayLooping();
  //gameSoundtrack := System.Media.SoundPlayer.Create('sound/game.wav');
  
  mainMenu := new MyMenu.Menu();
  
  mainMenu.AddButton(btnNewGame, 'new_game/new_game.png', 'new_game/new_game_focus.png');
  //mainMenu.AddButton(kek, 'options/options.png', 'options/options_focus.png');
  mainMenu.AddButton(btnExit, 'exit/exit.png', 'exit/exit_focus.png');
  
    pauseMenu := new MyMenu.Menu();
    
    pauseMenu.AddButton(btnContinue, 'continue/continue.png', 'continue/button_focus.png');
    pauseMenu.AddButton(btnNewGame, 'new_game/new_game.png', 'new_game/new_game_focus.png');
    pauseMenu.AddButton(btnExit, 'exit/exit.png', 'exit/exit_focus.png');
  
  screens := new MyScreens.Screens();
  screens.AddScreen('Main menu', EmptyProc, MainMenuProc, MainMenuKeyDown,'sound/WickedGames.wav');
  screens.AddScreen('Game', GameInitialize, GameProc, GameKeyDown,'sound/DanceDance.wav');
  screens.AddScreen('Game over', EmptyProc, GameOverProc, GameOverKeyDown,'sound/DanceDance.wav');
  screens.AddScreen('Pause menu',EmptyProc, PauseMenuProc, PauseMenuKeyDown,'sound/WikedGames.wav');
  screens.Activate('Main menu');
  
  GameInitialize();
end.