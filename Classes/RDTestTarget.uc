class RDTestTarget extends DynamicSMActor
HideCategories(Movement, Attachment, Debug, Advanced, Mobile, Physics)
placeable;
 

var() bool bDestroyOnDmg;

var() bool bDestroyOnPlayerTouch;

var() bool bDestroyOnVehicleTouch;

var() StaticMesh MeshOnDestroy;

var() float SpawnPhysMeshLifeSpan;

var() vector SpawnPhysMeshLinearVel;

var() vector SpawnPhysMeshAngVel;

var() SoundCue SoundOnDestroy;

var() ParticleSystem ParticlesOnDestroy;

var() ParticleSystemComponent PSC;

var() StaticMesh SpawnPhysMesh;

var() float RespawnTime;

var StaticMesh RespawnSM;

var bool bDestroyed;

var float TimeToRespawn;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    // Uses this mesh when respawning
    RespawnSM = StaticMeshComponent.StaticMesh;
}

simulated function RespawnDestructible()
{
    // Turns off fire/smoke particles
    PSC.DeactivateSystem();
    // Reset static mesh & re-attach SM component.
    StaticMeshComponent.SetStaticMesh(RespawnSM);
    if(!StaticMeshComponent.bAttached)
    {
        AttachComponent(StaticMeshComponent);
    }
    bDestroyed = FALSE;

}

simulated function Explode()
{
    local UTSD_SpawnedKActor PhysMesh;
    HurtRadius(30.0, 200.0, class'UTDamageType', 300.0, Location,,, True);
    // Swap or hide mesh when destroyed
    if(MeshOnDestroy != None)
    {
        StaticMeshComponent.SetStaticMesh(MeshOnDestroy);
    }
    else
    {
        StaticMeshComponent.SetStaticMesh(None);
        DetachComponent(StaticMeshComponent);
    }
    
// Play sfx after object is destroyed
if(SoundOnDestroy != None)
{
PlaySound(SoundOnDestroy, TRUE);
}
//Generate fire particle after object destruction
if(ParticlesOnDestroy != None)
{
PSC = WorldInfo.MyEmitterPool.SpawnEmitter(ParticlesOnDestroy, Location, Rotation);
}
// Spawn physics mesh
if(SpawnPhysMesh != None)
{
PhysMesh = spawn(class'UTSD_SpawnedKActor',,,Location,Rotation);
PhysMesh.StaticMeshComponent.SetStaticMesh(SpawnPhysMesh);
PhysMesh.StaticMeshComponent.SetRBLinearVelocity(SpawnPhysMeshLinearVel, FALSE);
PhysMesh.StaticMeshComponent.SetRBAngularVelocity(SpawnPhysMeshAngVel, FALSE);
PhysMesh.StaticMeshComponent.WakeRigidBody();
// Collides with the world but, not players or vehicles
PhysMesh.SetCollision(FALSE, FALSE);
PhysMesh.StaticMeshComponent.SetRBChannel(RBCC_Default);
PhysMesh.StaticMeshComponent.SetRBCollidesWithChannel(RBCC_Default, TRUE);
// Set lifespan
PhysMesh.LifeSpan = SpawnPhysMeshLifeSpan;
}
bDestroyed = TRUE;
TimeToRespawn = RespawnTime;
// It will respawn after (X) seconds
SetTimer(RespawnTime, FALSE, 'RespawnDestructible');
}

simulated function TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    if(!bDestroyed && bDestroyOnDmg)
    {
     Explode();
    }
}

simulated function Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
// Ignore if destroyed.
if(bDestroyed)
{
return;
}

if( Vehicle(Other) != None )
{
// If a vehicle touches it...
if(bDestroyOnVehicleTouch)
{
// Explode
Explode();
}
}
else
{
// If a player touches it...
if(bDestroyOnPlayerTouch && Pawn(other) !=None)
{
// Explode
Explode();
}
}
}

defaultproperties
{
   
   bCollideActors=TRUE
bProjTarget=TRUE
bPathColliding=FALSE
bNoDelete=TRUE
Begin Object Name=MyLightEnvironment
bEnabled=TRUE
bDynamic=FALSE
End Object
// Mesh for the object
Begin Object Name=StaticMeshComponent0
StaticMesh=StaticMesh'E3_Demo.Meshes.SM_Barrel_01'
End Object
ParticlesOnDestroy[0]=ParticleSystem'Castle_Assets.FX.P_FX_Fire_SubUV_01'
SoundOnDestroy=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_BodyExplosion_Cue'
MeshOnDestroy=StaticMesh'Envy_Effects.VH_Deaths.S_Envy_Rocks'
RespawnTime=30.0
// How long the spawned physics object should last
SpawnPhysMeshLifeSpan=500.0
// Destroyed when damaged
bDestroyOnDmg=FALSE
// Destroyed when touched by player
bDestroyOnPlayerTouch=FALSE
// Destroyed when touched by vehicle
bDestroyOnVehicleTouch=TRUE
// Blocks other nonplayer actors
bBlockActors=TRUE;
}


