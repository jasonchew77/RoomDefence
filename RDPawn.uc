class RDPawn extends UTPawn;

var float CamOffsetDistance; //distance to offset the camera from the player in unreal units
var float CamMinDistance, CamMaxDistance;
var float CamZoomTick; //how far to zoom in/out per command
var float CamHeight; //how high cam is relative to pawn pelvis

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetPhysics(PHYS_Flying);
    `Log("Custom Pawn up"); //debug

}

//override to make player mesh visible by default
simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != None)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != None)
      {
         //set player controller to behind view and make mesh visible
         UTPC.SetBehindView(true);
         // SetMeshVisibility(UTPC.bBehindView); 
         UTPC.bNoCrosshair = true;
      }
   }
}

/*
//only update pawn rotation while moving
simulated function FaceRotation(rotator NewRotation, float DeltaTime)
{
    // Do not update Pawn's rotation if no accel
    if (Normal(Acceleration)!=vect(0,0,0))
    {
        if ( Physics == PHYS_Ladder )
        {
            NewRotation = OnLadder.Walldir;
        }
        else if ( (Physics == PHYS_Walking) || (Physics == PHYS_Falling) || (Physics == PHYS_Flying) )
        {
            NewRotation = rotator((Location + Normal(Acceleration))-Location);
            NewRotation.Pitch = 0;
        }
        NewRotation = RLerp(Rotation,NewRotation,0.1,true);
        SetRotation(NewRotation);
    }
    
}
*/

//orbit cam, follows player controller rotation
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
    local vector HitLoc,HitNorm, End, Start, vecCamHeight;

    vecCamHeight = vect(0,0,0);
    vecCamHeight.Z = CamHeight;
    Start = Location;
    End = (Location+vecCamHeight)-(Vector(Controller.Rotation) * CamOffsetDistance);  //cam follow behind player controller
    out_CamLoc = End;

    //trace to check if cam running into wall/floor
    if(Trace(HitLoc,HitNorm,End,Start,false,vect(12,12,12))!=none)
    {
        out_CamLoc = HitLoc + vecCamHeight;
    }
    
    //camera will look slightly above player
   out_CamRot=rotator((Location + vecCamHeight) - out_CamLoc);
   return true;
}

simulated function CamZoomIn()
{
    if(CamOffsetDistance > CamMinDistance)      CamOffsetDistance-=CamZoomTick;
}

simulated function CamZoomOut()
{
    if(CamOffsetDistance < CamMaxDistance)  CamOffsetDistance+=CamZoomTick;
}


defaultproperties
{
    Physics = PHYS_Flying
    LandMovementState = PlayerFlying
    CamHeight = 90.0
    CamMinDistance = 40.0
    CamMaxDistance = 350.0
    CamOffsetDistance = 200.0
    CamZoomTick = 20.0    
    MaxMultiJump = 1
   
    
}