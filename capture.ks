declare global function capture {
	declare parameter target.
	lock steering to retrograde.
	until body:name = target { 
		noScience().
		wait 1. 
	}
	set throttle to 1.
	until ship:apoapsis < body:soiradius { 
		noScience().
		wait 0.1. 
	}
	set throttle to 0.
}.