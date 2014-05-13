class RDGameInfo extends UTGame;

var RDAIController ENEMYPLAYER;

function PostBeginPlay()
{
   local Pawn TestSpawn;
   
   TestSpawn = SpawnRDPawn();
   //SpawnDefaultPawnFor(NewPlayer, StartSpot)
   ENEMYPLAYER.possess(TestSpawn, false);

    super.PostBeginPlay();
}


function Pawn SpawnRDPawn()
{
    local Pawn SpawnedPawn;
    local Vector v;

    v = Vect(1365.715088,676.012695,-446.000000);

   
    SpawnedPawn = Spawn(class'RDAIPawn',,,v,,);
    
    
    return SpawnedPawn;
} 


defaultproperties
{
    DefaultPawnClass = class'RoomDefence.RDPawn'
    PlayerControllerClass = class'RoomDefence.RDPlayerController'
    bDelayedStart = false
    bRestartLevel = false
}