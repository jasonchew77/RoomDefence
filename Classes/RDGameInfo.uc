class RDGameInfo extends UDKGame;
var int NoE;
var int i;

//jeremy changes
var RDAIController ENEMYPLAYER;
var array<RDAIPawn> TestSpawn;


function PostBeginPlay()
{
   
    SpawnMobs();

  //  ENEMYPLAYER.push_back(UTBot);
  //ENEMYPLAYER= Spawn(class'RDAIController');
  //ENEMYPLAYER.SpawnDefaultController();
    super.PostBeginPlay();
}

function SpawnMobs_child()
{
        
    local Vector v;

    v = Vect(1365.715088,676.012695,-400.000000); 
    
       
       //for (i=0; i<10; i++){
        //TestSpawn[i] = SpawnRDPawn();
    //   ENEMYPLAYER[i] = new UTBot();
       TestSpawn[i] = Spawn(class'RDAIPawn',,,v,,,True);
       TestSpawn[i].SpawnDefaultController();
      

       
       `log("Spawn called" @ i);
        i=i+1;
    //  }
}


    function SpawnMobs()
{
    
    `log("Begintimer");
    SetTimer(3, true, 'SpawnMobs_child' );
    
    SpawnMobs_child();
    /*
 for (i=0; i<NoE; i++){
       TestSpawn[i] = SpawnRDPawn();
       ENEMYPLAYER.possess(TestSpawn[i], false);
 `log("Spawned:" @ i);     
     
     
   }*/
}



//function RDAIPawn SpawnRDPawn()
//{
//    local RDAIPawn SpawnedPawn;
//    local Vector v;
//
//    v = Vect(1365.715088,676.012695,-446.000000);
//
//   
//    SpawnedPawn = Spawn(class'RDAIPawn',,,v,,);
//    
//    
//    return SpawnedPawn;
//} 
//

defaultproperties
{
    DefaultPawnClass = class'RoomDefence.RDPawn'
    PlayerControllerClass = class'RoomDefence.RDPlayerController'
    bDelayedStart = false
    bRestartLevel = false
    NoE = 10
    i=0
    //bCustomBots=true
    //BotClass=class'RDAIController'
}