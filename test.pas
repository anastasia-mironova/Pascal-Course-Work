uses GraphABC;
var a:integer;
key: integer;
asound:System.Media.SoundPlayer; 
procedure GameKeyDown(Key:integer);
begin
  case Key of 
    VK_p: asound.stop;
  end;
end;

begin

  var sound := new System.Media.SoundPlayer('sound/WickedGames.wav');
  sound.Play;
  
  
  writeln('Enter kek=33');
  read(a);
  if a=33 then begin
   asound := new System.Media.SoundPlayer('sound/DanceDance.wav');
  asound.PlayLooping();
  
  end;
end.