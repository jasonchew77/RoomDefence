class RDPawn extends UDKPawn;

var DynamicLightEnvironmentComponent LightEnvironment;
var float CamOffsetDistance; //distance to offset the camera from the player in unreal units
var float CamMinDistance, CamMaxDistance;
var float CamZoomTick; //how far to zoom in/out per command
var float CamHeight; //how high cam is relative to pawn pelvis
var float MouseLookAim;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class ' UTGame.UTWeap_linkGun');
}

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetPhysics(PHYS_Flying);
    //`Log("Custom Pawn up"); //debug
    
    AddDefaultInventory();
    
    UTInventoryManager(InvManager).bInfiniteAmmo = true;

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
/*
function MouseAimUpdater(float MouseYInput) 
 
 {
 MouseLookAim += MouseYInput; 
AimNode.AngleOffset.Y -= (MouseYInput/16000) ;

if (MouseLookAim < 16000 && MouseLookAim > -16000) 
 { 
 MouseLookAim+=MouseYInput; 
 AimNode.AngleOffset.Y -= (MouseYInput/16000); 
 } 
else 
 if (MouseLookAim >= 16000 && MouseYInput <0) 
 { 
 MouseLookAim+=MouseYInput; 
 AimNode.AngleOffset.Y -= (MouseYInput/16000); 
 } 
 else 
 if (MouseLookAim <=-16000 && MouseYInput >0) 
 { 
 MouseLookAim+=MouseYInput; 
 AimNode.AngleOffset.Y -= (MouseYInput/16000); 
 } 

}*/


defaultproperties
{
    Physics = PHYS_Flying
    LandMovementState = PlayerFlying
    CamHeight = 80.0
    CamMinDistance = 40.0
    CamMaxDistance = 350.0
    CamOffsetDistance = 200.0
    CamZoomTick = 20.0    
    //MaxMultiJump = 1
     // Components.Remove(Sprite)    
   
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
      bSynthesizeSHLight=TRUE
      bIsCharacterLightEnvironment=TRUE
      bUseBooleanEnvironmentShadowing=FALSE
   End Object
   Components.Add(MyLightEnvironment)
   LightEnvironment=MyLightEnvironment

   Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
       //Your Mesh Properties
      SkeletalMesh=SkeletalMesh'charactersanim.mainchar'
      AnimTreeTemplate=AnimTree'charactersanim.mainchar_animtree'
      PhysicsAsset=PhysicsAsset'charactersanim.mainchar_Physics''
      AnimSets(0)=AnimSet'charactersanim.mainchar_anim'
      Translation=(Z=8.0)
      Scale=1.075
      //General Mesh Properties
      bCacheAnimSequenceNodes=false
      AlwaysLoadOnClient=true
      AlwaysLoadOnServer=true
      bOwnerNoSee=false
      CastShadow=true
      BlockRigidBody=TRUE
      bUpdateSkelWhenNotRendered=false
      bIgnoreControllersWhenNotRendered=TRUE
      bUpdateKinematicBonesFromAnimation=true
      bCastDynamicShadow=true
      RBChannel=RBCC_Untitled3
      RBCollideWithChannels=(Untitled3=true)
      LightEnvironment=MyLightEnvironment
      bOverrideAttachmentOwnerVisibility=true
      bAcceptsDynamicDecals=FALSE
      bHasPhysicsAssetInstance=true
      TickGroup=TG_PreAsyncWork
      MinDistFactorForKinematicUpdate=0.2
      bChartDistanceFactor=true
      RBDominanceGroup=20
      bUseOnePassLightingOnTranslucency=TRUE
      bPerBoneMotionBlur=true
  End Object
      Mesh=WPawnSkeletalMeshComponent
      Components.Add(WPawnSkeletalMeshComponent)

        CollisionType=COLLIDE_BlockAll
        Begin Object Name=CollisionCylinder
            CollisionRadius=+0021.000000
            CollisionHeight=+0048.000000
        End Object
        CylinderComponent=CollisionCylinder
        InventoryManagerClass = class 'UTInventoryManager'
}