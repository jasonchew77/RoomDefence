class RDAIPawn extends UDKPawn;

var DynamicLightEnvironmentComponent LightEnvironment;
//var ActorComponent NavigationHandle;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetPhysics(PHYS_Walking);
    AddDefaultInventory();
    
   // NavigationHandle = new(self) class'NavigationHandle';

}



function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UTGame.UTWeap_LinkGun');
}


/*

state Follow {
    function bool FindNavMeshPath()
    {
        // Clear cache and constraints (ignore recycling for the moment)
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
 
        // Create constraints
        class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle,target );
        class'NavMeshGoal_At'.static.AtActor( NavigationHandle, target,32 );
 
        // Find path
        return NavigationHandle.FindPath();
    }
Begin:
    if( FindNavMeshPath() )
    {
        NavigationHandle.SetFinalDestination(target.Location);
        FlushPersistentDebugLines();
        NavigationHandle.DrawPathCache(,TRUE);
 
        // move to the first node on the path
        if( NavigationHandle.GetNextMoveLocation( TempDest, Pawn.GetCollisionRadius()) )
        {
            DrawDebugLine(Pawn.Location,TempDest,255,0,0,true);
            DrawDebugSphere(TempDest,16,20,255,0,0,true);
 
            MoveTo( TempDest, target );
        }
        
    }
    
    goto 'Begin';

}

*/

defaultproperties
{
   WalkingPct=+0.4
   CrouchedPct=+0.4
   BaseEyeHeight=38.0
   EyeHeight=38.0
   GroundSpeed=240.0
   AirSpeed=440.0
   WaterSpeed=220.0
   AccelRate=2048.0
   JumpZ=322.0
   CrouchHeight=29.0
   CrouchRadius=21.0
   WalkableFloorZ=0.78
   
   Components.Remove(Sprite)

   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
      bSynthesizeSHLight=TRUE
      bIsCharacterLightEnvironment=TRUE
      bUseBooleanEnvironmentShadowing=FALSE
   End Object
   Components.Add(MyLightEnvironment)
   LightEnvironment=MyLightEnvironment

   Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
       //Your Mesh Properties
      SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
      AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
      PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      Translation=(Z=8.0)
      Scale=1.075
      //General Mesh Properties
      bCacheAnimSequenceNodes=FALSE
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

   Begin Object Name=CollisionCylinder
      CollisionRadius=+0021.000000
      CollisionHeight=+0044.000000
   End Object
  CylinderComponent=CollisionCylinder
   
    ControllerClass=class'RoomDefence.RDAIController'
    InventoryManagerClass=class'UTInventoryManager'
    
}