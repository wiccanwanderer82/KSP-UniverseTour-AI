set allowWarp to true.
declare global function CreateCircularizationNode{
	set mapView to true.
	TimeStamp("Circularize", Apoapsis).
	set ttime to (time() + ETA:apoapsis):seconds.
	set myNode to node(ttime, 0, 0, 0).
	Add myNode.
	until myNode:orbit:Apoapsis > Apoapsis - 9{
		set myNode:prograde to myNode:prograde + 1.
		wait 0.01.
	}
	set mapView to false.
	ExecuteNode(myNode).
}
declare global function CreateAscensionNode{
	Declare Parameter TargetAltitude.
	set mapView to true.
	TimeStamp("Ascend", TargetAltitude).
	set ttime to (time() + ETA:apoapsis):seconds.
	set myNode to node(ttime, 0, 0, 0).
	Add myNode.
	until myNode:orbit:apoapsis >= TargetAltitude{
		set myNode:prograde to myNode:prograde + 1.
		wait 0.01.
	}
	set mapView to false.
	ExecuteNode(myNode).
	CreateCircularizationNode().
}
declare global function DescensionNode{
	Declare Parameter Altitude to Ship:Altitude.
}
declare global function ExecuteNode{
	Declare Parameter MyNode to node(time():seconds, 0, 0, 0).
	
	set max_acc to ship:maxthrust/ship:mass.
	set burn_duration to myNode:deltav:mag/max_acc.

	if allowwarp {
		set nodebuffer to burn_duration + 60.
		if myNode:eta > nodebuffer + 60 {
			set warpbuffer to nodebuffer +30.
			set jump to time:seconds + myNode:eta - warpbuffer.
			TimeStamp("Encountered Time/Space distortion.").
			wait 10.
			warpto(jump).
		}
	}
	
	
	until myNode:eta <= (burn_duration / 2 + 60){
		dostage().
		wait 0.1.
	}

	lock steering to myNode:deltav.
	lock throttle to 1.

	set done to false.
	until done{
		if myNode:deltav:mag < 100
		{
			lock throttle to 0.5.
		}
		if myNode:deltav:mag < 10
		{
			set done to true.
		}
		dostage().
	}.
	lock throttle to 0.
	lock steering to prograde.
	remove myNode.
}
