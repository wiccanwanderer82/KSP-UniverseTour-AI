declare global function Science {
    Declare Local SensorList to list().
    Declare Local plist to ship:parts.
    
    for item in plist{
        if item:hasmodule("ModuleScienceExperiment"){
            SensorList:add(item).
        }
    }
    for item in SensorList{
	set experiment to item:getmodule("ModuleScienceExperiment").
	if experiment:inoperable = false {
	    if experiment:hasdata = false {
	        experiment:deploy().
	    }
	    wait 3.
	    if experiment:hasdata = true {
		for data in experiment:data {
			if data:transmitvalue > 0 {
				experiment:transmit().
				}
			}
			experiment:dump().
		
	    }
	}
    }
}.

declare global function NoScience{
	Declare Local plist to ship:parts.
	for item in plist{
		if item:hasmodule("ModuleScienceExperiment"){
			item:getmodule("ModuleScienceExperiment"):dump().
		}
	}
}

declare global function SciOrb {
	if eta:periapsis > eta:apoapsis {
		until eta:periapsis < 60 {
			Science().
			wait 3.
			}
		until eta:apoapsis < 60 {
			Science().
			wait 3.
			}
		}
	else {
		until eta:apoapsis < 60 {
			Science().
			wait 3.
			}
		until eta:periapsis < 60 {
			Science().
			wait 3.
			}
		}
}.