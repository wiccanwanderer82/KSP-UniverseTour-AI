declare global function dostage {
	if stage:liquidfuel < 0.01 and stage:solidfuel < 0.01 {
		set thrott to throttle.
		set throttle to 0.
		if stage:number > 0	{
		    if velocity:orbit:mag > 1 {
			TimeStamp("Ejecting Stage:" + stage:number +".").
		    }
		    stage.
			wait 3.
		    until throttle >= thrott{
				set throttle to throttle + .1.
				wait 0.2.
				}
		    }
		lock throttle to thrott.
	          }
	wait 0.1.
    }.