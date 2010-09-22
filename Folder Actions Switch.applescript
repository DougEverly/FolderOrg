

tell application "System Events"
	
	-- show dialog box
	if (folder actions enabled is true) then
		set theResult to display dialog "Folder Actions is on." buttons {"Turn Off", "OK"} default button 2
	else
		set theResult to display dialog "Folder Actions is off." buttons {"OK", "Turn On"} default button 2
	end if
	
	-- enable or disable
	if the button returned of theResult is "Turn Off" then
		set folder actions enabled to false
		display dialog "Folder Actions is off." buttons {"OK"}
	else if the button returned of theResult is "Turn On" then
		set folder actions enabled to true
		display dialog "Folder Actions is on." buttons {"OK"}
	end if
	
	
end tell