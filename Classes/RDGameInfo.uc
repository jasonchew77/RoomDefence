class RDGameInfo extends UDKGame;
var RDPlayerController RDPlayerOwner;
var() const archetype RDTressureBox PawnArchetype;
var RDTressureBox MyPawn;
var WinMenu winHud;


var int winTimer;

simulated event PostBeginPlay()
{
    super.postBeginPlay();
 SetTimer(3, false, 'winGame');
 // MyPawn = RDTressureBox(owner);
}

/*function Pawn SpawnDefaultPawnFor(Controller Newplayer, NavigationPoint StartSpot)
{
    local Pawn SpawnedPawn;
    if (NewPlayer == none && StartSpot == none)
    {
        return none;
    }
    
    SpawnedPawn = Spawn(PawnArchetype.Class,,, StartSpot.Location,, PawnArchetype);
    MyPawn = RDTressureBox(SpawnedPawn);
    
    return SpawnedPawn;
}*/
   
    
function winGame()
{
    winHud = new class 'WinMenu';
     RDPlayerOwner = RDPlayerController(GetALocalPlayerController());
    `log ("run timer");
    //MyPawn.Destroy();
   RDPlayerOwner.SetPause(true);
   winHud.Advance(0);
   bCinemaDisableInputMove(true);
    winHud.Start();
}

function StartMatch(){
        super.StartMatch ();
    }
    
    function ScoreKill(Controller Killer, Controller other)
    {
        return;
    }
    
     function SetWinner(PlayerReplicationInfo RDWinner) 
    { 
     //setting the end of game time 
     //EndTime = WorldInfo.TimeSeconds + EndTimeDelay; 
     //Setting the winner in Game Replication Info 
     // GameReplicationInfo.Winner = RDWinner; 
     //Aaaand money shot of the winner! 
     // SetEndGameFocus(RDWinner); 
    }
    

defaultproperties
{
    // Acronym = "RD"
    // MapPrefixes[0] = "RD"
    DefaultPawnClass = class'RoomDefence.RDPawn'
    PlayerControllerClass = class'RoomDefence.RDPlayerController'
    PlayerReplicationInfoClass = class'RoomDefence.RDPlayerReplicationInfo'
    HUDType = class'RoomDefence.RDHUD'
    bDelayedStart = false
    bRestartLevel = false
    // bUseClassicHUD=true
    // bGivePhysicsGun = false
    
    Name="Default__RoomDefence"
    
}

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
    return default.class;
}