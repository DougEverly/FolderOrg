all:
	osacompile -o FolderOrg.app FolderOrg.applescript

clean:
	/bin/test -d ./FolderOrg.app && rm -rf ./FolderOrg.app

install: all
	cp -R ./FolderOrg.app ~/Library/Scripts/Folder\ Action\ Scripts

sysinstall: all
	cp -R ./FolderOrg.app /Library/Scripts/Folder\ Action\ Scripts
