class RDGFxHUD extends GFxMoviePlayer;



function Init( optional LocalPlayer LocPlay ) 
{ 
 //Gets all the other intialization stuff we need. 
 super.Init (LocPlay); 
 
 //Starts the GFx Movie that's attached to this script (IE: our HUD). 
 Start(); 
 
 //Advances the frame to the first one. 
 Advance(0.f); 
} 

function TickHUD()
{
   // local RDPlayerReplicationInfo RDRep;
   // local float thisScore;
    
   // RDRep = RDPlayerReplicationInfo(GetPC().Pawn.PlayerReplicationInfo);
}



Defaultproperties
{
    MovieInfo=SwfMovie'RDHUD.CrossHairAS2'
    bDisplayWithHudOff=false 
    bIgnoreMouseInput=true 
    bAutoPlay=true 
}