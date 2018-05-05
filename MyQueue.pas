unit MyQueue;

interface

type 
  Queue = class
  //private
    queue:array[,] of integer;
    length:integer;
  //public
    constructor Create();
    
    procedure Push(x:integer; y:integer);
    procedure Unshift(x:integer; y:integer);
    
    function Pop():array of integer;  
    function Shift():array of integer;
  end;

implementation

// Constructor
constructor Queue.Create();
begin
  SetLength(queue, 0, 2);
  
  length := 0;
end;

// Procedures
procedure Queue.Push(x:integer; y:integer);
begin
  length := length + 1;
  SetLength(queue, length, 2);
  queue[length - 1, 0] := x;
  queue[length - 1, 1] := y;
end;

procedure Queue.Unshift(x:integer; y:integer);
begin
  length := length + 1;
  SetLength(queue, length, 2);
  
  for var i := length - 1 downto 1 do begin
    queue[i, 0] := queue[i - 1, 0];
    queue[i, 1] := queue[i - 1, 1];
  end;
  
  queue[0, 0] := x;
  queue[0, 1] := y;
end;

// Functions 
function Queue.Pop():array of integer;
begin
  Result := new integer[2];
  Result[0] := queue[length - 1, 0];
  Result[1] := queue[length - 1, 1];
  
  length := length - 1;
  
  SetLength(queue, length, 2);
end;

function Queue.Shift():array of integer;
begin
  Result := new integer[2];
  Result[0] := queue[0, 0];
  Result[1] := queue[0, 1];
  
  for var i := 0 to length - 2 do begin
    queue[i, 0] := queue[i + 1, 0];
    queue[i, 1] := queue[i + 1, 1];
  end;
  
  length := length - 1;
  
  SetLength(queue, length , 2);
end;
  
initialization

end.