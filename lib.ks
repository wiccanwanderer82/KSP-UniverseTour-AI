core:part:getmodule("koSProcessor"):doevent("Open Terminal").
when ship:electriccharge < 100 then {
	if throttle = 0{
		set throttle to 0.01.
		}
	Preserve.
}
lock now to Time.
declare global function TimeStamp{
	Declare Parameter message to "Time Stamp.".
	Declare Parameter myAlt to 0.
	set hour to now:hour.
	set minute to now:minute.
	set second to now:second.
	if hour < 10 { set hour to "0" + hour.}
	if minute < 10 { set minute to "0" + minute.}
	if second < 10 { set second to "0" + second.}
	set pnow to hour + ":" + minute + ":" + second + " ".
	if now:hour < 10 
	if myAlt = 0{
		print pnow + message.
		LOG pnow + message to log.txt.
	} else if myAlt < 1000 {
		print pnow + message + " to " + myAlt + " meters.".
		LOG pnow + message + " to " + myAlt + " meters." to log.txt.
	} else if myAlt < 1000000 {
		print pnow + message + " to " + myAlt/1000 + " km.".
		LOG pnow + message + " to " + myAlt/1000 + " km." to log.txt.
	} else {
		print pnow + message + " to " + myAlt/1000000 + " Mm.".
		LOG pnow + message + " to " + myAlt/1000000 + " Mm." to log.txt.
	}
	copypath("1:/log.txt", "0:/log.txt").
	
}
clearscreen.
copypath("0:/mission.ks", "1:/mission.ks").
copypath("0:/launch.ks", "1:/launch.ks").
runpath("1:/launch.ks").
copypath("0:/science.ks", "1:/science.ks").
runpath("1:/science.ks").
copypath("0:/stage.ks", "1:/stage.ks").
runpath("1:/stage.ks").
copypath("0:/capture.ks", "1:/capture.ks").
runpath("1:/capture.ks").
copypath("0:/warp.ks", "1:/warp.ks").
runpath("1:/warp.ks").
copypath("0:/node.ks", "1:/node.ks").
runpath("1:/node.ks").
declare global thrott is 0.5.
