(*

FolderOrg 1.2

   Copyright 2002-2010 Doug Everly Doug@Everly.org
   
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
   limitations under the License.


*)


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
