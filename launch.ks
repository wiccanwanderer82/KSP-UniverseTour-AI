declare local function nosedown{
	TimeStamp("Beginning Gravity turn.").
	declare parameter h1 is 90.
	set turn to 0.
	lock steering to heading(h1,90-turn).
	until turn >= 45 {
		set turn to turn + 1.
		dostage().
		wait 1.
	}
}

declare local function releaseClamps{
    Declare Local plist to ship:parts.
	for part in plist{
		if part:hasmodule("LaunchClamp"){
			part:getmodule("LaunchClamp"):doevent("release clamp").
		}
	}
}

declare global function launch{
	declare parameter h1 is 90.
	declare parameter targetAlt is body:Atm:Height*1.25.
	lock steering to heading(h1,90).
	

	when ship:altitude >= (targetAlt / 3) then {
		nosedown(h1).
	}
	when ship:altitude >= (targetAlt / 2) then {
		lock throttle to 1.
	}
	lock radius to body:radius + altitude.
	lock gravity to body:mu / (radius * radius).
	lock thrust to ship:availablethrust * throttle.
	lock twr to thrust / (ship:mass * gravity).
	when twr >= 1.1 then {
		releaseClamps.
		TimeStamp("Liftoff!").
	}

	set g to body:mu / body:radius^2.
	lock accvec to ship:sensors:acc - ship:sensors:grav.
	lock gforce to accvec:mag/g.
	lock dthrott to 0.05 *(1.2 - gforce).
	
	set thrott to 1.
	TimeStamp("Launching", targetAlt).
	set throttle to 0.
	Stage.
	until throttle >= 1 {
		set throttle to throttle + 0.01.
		wait 0.1.
	}

	lock throttle to thrott.

	lock distance to ship:altitude + body:radius.

	until Ship:orbit:apoapsis >= targetAlt{
		noScience().
		dostage().
		set thrott to thrott + dthrott.
		wait 0.1.
	}
	TimeStamp("Apoapsis achieved!").
	set throttle to 0.
	lock steering to prograde.

	set ttime to (time() + ETA:apoapsis):seconds.
	set myNode to node(ttime, 0, 0, 0).
	Add myNode.
	until myNode:orbit:periapsis > Apoapsis - 5 {
		set myNode:prograde to myNode:prograde +1.
	}
	TimeStamp("Executing Orbital Burn...").
	ExecuteNode(myNode).
	TimeStamp("Orbital Burn complete.").
	lights on. 
}.