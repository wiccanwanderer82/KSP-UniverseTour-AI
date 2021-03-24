declare global function warptotime {
	declare parameter target.
	if allowwarp {
		kuniverse:timewarp:warpto(time:seconds + target - 120).
		}
	}.