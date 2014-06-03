class RDTressureBox extends UDKPawn
 placeable;
 
 // var() StaticMeshComponent StaticMesh;
 //var float Health;
 var float MaxHealth;
     var int StartHealth;
    var int HealthMin;
    var int DamageOverTime;
    var float ExplDamage;
    var float DmgRadius;
    
 
 
simulated function PostBeginPlay()
{
    /*local Actor T;
    super.PostBeginPlay();
    if (T == none)
    {
        t = Spawn(class'RDTressureBox', self,,self.Location );   
    }*/
}
 
/*event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, 
class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(DamageAmount,EventInstigator, HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
    Health = FMax(Health-DamageAmount,0);
    WorldInfo.Game.Broadcast(self,Name$": Health:"@Health);
   

 
    
}*/
 

simulated event PreBeginPlay()
{
    // super.Tick(DeltaTime);
}

defaultproperties

{

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
 
}
