(*

FolderOrg 1.2

   Copyright 2010 Doug Everly Doug@Everly.org
   
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

property open_folder : true
property touch_file : false
property time_fmt : 1
property bring_to_front : true
property organized_folder : ""
property ignore_kinds : {"Safari download", "Finder Document"}
property date_fmt : "+%Y-%m-%d" -- BE VERY CAREFUL HERE! This string is execute in the UNIX shell. The wrong command string could be bad.


on run
	
	display dialog "Do you want to show the folder when new items are added?" buttons {"Don't Show", "Show"} default button 2
	if the button returned of the result is "Don't Show" then
		set open_folder to false
	else
		set open_folder to true
	end if
	
	display dialog "Do you want to bring active the Finder when new items are added?" buttons {"Don't Activate", "Activate"} default button 2
	if the button returned of the result is "Don't Activate" then
		set bring_to_front to false
	else
		set bring_to_front to true
	end if
	
	display dialog "Do you want to set the modification date to the time the items were added?" buttons {"Change Modification Date", "Don't Change Modification Date"} default button 2
	if the button returned of the result is "Don't Change Modification Date" then
		set touch_file to false
	else
		set touch_file to true
	end if
	
end run

on open of the_files
	if (organized_folder is equal to "") then
		set_organized_folder()
	end if
	
	tell application "Finder" to move the_files to organized_folder
end open

on set_organized_folder()
	set organized_folder to (choose folder)
	
end set_organized_folder



on adding folder items to this_folder after receiving added_items
	set the_path to POSIX path of this_folder
	set date_cmd to "date '" & date_fmt & "'"
	set todays_folder to do shell script of date_cmd
	
	--	display dialog ((the number of added_items) as string) & " items added" --
	repeat with i from 1 to number of items in added_items
		set this_item to item i of added_items
		--display dialog the kind of (info for this_item) as string
		set item_kind to the kind of (info for this_item) as string
		if (item_kind is in ignore_kinds) then
			-- display dialog item_kind & " is being ignored"
		else
			
			set item_name to the name of (info for this_item)
			if (item_name is not equal to todays_folder) then
				--		display dialog "Name: " & item_name
				set make_folder_cmd to "/bin/test -d " & quoted form of (the_path & todays_folder) & " || /bin/mkdir  " & quoted form of (the_path & todays_folder)
				--display dialog make_folder_cmd
				do shell script make_folder_cmd
				set move_file_cmd to "/bin/test -d " & quoted form of (the_path & todays_folder) & " &&  /bin/mv -n " & quoted form of (the_path & item_name) & " " & quoted form of (the_path & todays_folder) & "/"
				--display dialog "Running: " & move_file_cmd
				do shell script move_file_cmd
				if (touch_file is true) then
					set touch_file_cmd to "/usr/bin/touch " & quoted form of (the_path & todays_folder & "/" & item_name)
					--display dialog "Running: " & touch_file_cmd
					do shell script touch_file_cmd
					
				end if
			else
				-- display dialog "Dated folder.. not running"
			end if
		end if
	end repeat
	if (open_folder is true) then
		if (bring_to_front is true) then
			tell application "Finder" to activate
		end if
		set the_folder to the_path & todays_folder
		set the_folder to POSIX file the_folder
		tell application "Finder" to open folder the_folder
	end if
	
end adding folder items to