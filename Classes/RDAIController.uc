class RDAIController extends AIController;

var Vector TempDest;
var vector FinalDest;



event Possess(Pawn inPawn, bool bVehicleTransition)
{
super.Possess(inPawn, bVehicleTransition);
Pawn.SetMovementPhysics();
}

auto state PatrolNavMesh
{
// If we see a player or pawn, ignore it
ignores SeePlayer;
function bool FindNavMeshPath()
{
// Clear cache and constraints
NavigationHandle.PathConstraintList = none;
NavigationHandle.PathGoalList = none;
NavigationHandle.bDebugConstraintsAndGoalEvals = true;
/** this makes sure the bot wont wander into an area
where it will get stuck */
class'NavMeshPath_EnforceTwoWayEdges'.static.EnforceTwoWayEdges(NavigationHandle);
/** Tells the bot to set a random goal.
There are 2 optional
variables you can pass, a float or int representing
the range
to search, and an int representing how many polys
away he can
move to */
class'NavMeshGoal_Random'.static.FindRandom(NavigationHandle);
// set his goal.
// Find path
return NavigationHandle.FindPath();
}
Begin:
if(FindNavMeshPath())
{
NavigationHandle.SetFinalDestination(NavigationHandle.PathCache_GetGoalPoint());
// The random point is any area within the NavMesh
FinalDest = NavigationHandle.
FinalDestination.Position;
// Draw the line to our pawn
//DrawDebugLine(Pawn.Location, FinalDest,255,0,0,true);
/** Draw a red sphere to illustrate the next location
the bot
will stop at */
//DrawDebugSphere(FinalDest,16,20,255,0,0,true);


// While our bot hasn't reached the random point yet...
while(!pawn.ReachedPoint(FinalDest, none))
{
/** If the bot realizes it can't reach this point
directly...*/
if(!NavigationHandle.PointReachable(FinalDest))
{
// Get out of here and pick another point
break;
}
// Otherwise...
else
{
// Move to the random point
MoveTo(FinalDest);
}
// Rest for (X) seconds before picking a new point
Sleep(0.5);
}
// Start from the beginning again
goto 'Begin';
}
}

defaultproperties
{
// Pawn is a player or a player-bot
bIsPlayer = true
}