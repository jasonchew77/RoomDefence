class RDHUD extends UTHUDBase;

var RDGFxHUD HUDMovie;
//var GFxUI_PauseMenu     PauseMenuMovie2;
var RDPlayerController RDPlayerOwner;

simulated function PostBeginPlay() 
{ 
 
 // Grab all the normal initialization for the HUD class. 
 super.PostBeginPlay(); 
 RDPlayerOwner = RDPlayerController(PlayerOwner);

 //Create a new instance of our custom GFX HUD class. 
 HudMovie = new class'RDGFxHUD'; 
          
 //Set it to realtime updating. 
 HudMovie.SetTimingMode(TM_Real); 
 
 //Calls an initialization function inside the custom GFX HUD class 
 HudMovie.Init(); 
} 

event PostRender() 
{ 
 //Call all the other PostRender stuff from GFxMovie 
 //local int i;
 super.PostRender(); 
 
 if (HudMovie != none) 
    {
        HudMovie.TickHud();
    }
 //As long as the HUD is enabled, we want to draw it.
 if ( bShowHud && bEnableActorOverlays ) 
 { 
 DrawHud(); 
 } 
 
}

exec function ShowMenu()
{
    // if using GFx HUD, use GFx pause menu
    TogglePauseMenu();
}


function TogglePauseMenu()
{
   /* if ( PauseMenuMovie2 != none && PauseMenuMovie2.bMovieIsOpen )
    {
        
 
            CompletePauseMenuClose();
     
    }
    
        // CloseOtherMenus();

        PlayerOwner.SetPause(True);

        if (PauseMenuMovie2 == None)
        {
            PauseMenuMovie2 = new class'GFxUI_PauseMenu';
            PauseMenuMovie2.MovieInfo =SwfMovie'RDHUD.PauseMenuMay';
            PauseMenuMovie2.bEnableGammaCorrection = FALSE;
            PauseMenuMovie2.LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocalPlayer(PlayerOwner.Player));
            PauseMenuMovie2.SetTimingMode(TM_Real);
           
        }

        SetVisible(false);
        PauseMenuMovie2.Start();
        PauseMenuMovie2.PlayOpenAnimation();

          // Do not prevent 'escape' to unpause if running in mobile previewer
        if( !WorldInfo.IsPlayInMobilePreview() )
        {
            PauseMenuMovie2.AddFocusIgnoreKey('Escape');
        }*/
    
}

/*
 * Complete necessary actions for OnPauseMenuClose.
 * Fired from Flash.
 */
 /*
function CompletePauseMenuClose()
{
    PlayerOwner.SetPause(False);
    PauseMenuMovie2.Close(false);  // Keep the Pause Menu loaded in memory for reuse.
    SetVisible(true);
}*/

defaultproperties
{
  
}