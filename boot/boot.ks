set orbitHeight to body:Atm:Height * 1.2.
if ship:altitude < orbitHeight 
{
	switch to 1.
	runpath("0:/lib.ks").
}
runpath("1:/mission.ks").