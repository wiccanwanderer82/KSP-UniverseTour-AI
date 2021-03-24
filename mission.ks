set targetheight to body:Atm:Height * 1.2.
if ship:altitude < targetheight{
	if ship:name = "Science Probe" {
		launch(45, 70000).
	} else {
		launch(90, 70000).
	}

	CreateAscensionNode(500000).

	TimeStamp("Parking orbit achieved.").
	lock steering to prograde.
	wait 10.
	lights on.
}
CreateAscensionNode(5000000).
until false {
	Science().
	wait 10.
}
Shutdown.