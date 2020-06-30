#!/bin/sh
set -e

# where are we?
basedir=$(dirname "$(readlink -f $0)")
action=$1

if [ -z "$action" ]; then
	echo "usage: $0 [install/uninstall]"
	exit 1
fi

[ -z "$wine_bin" ] && wine_bin="wine"

wine_ver=$($wine_bin --version | grep wine)
if [ -z "$wine_ver" ]; then
	echo "$wine_bin: "'broken wine installation' >&2
	exit 1
fi

echo "$wine_ver"

windows_dir=$($wine_bin winepath -u 'C:\windows' 2>/dev/null)
windows_dir="$(echo -n "$windows_dir" | sed 's/\r//g')"

install()
{
	cp -v "$basedir/winediscordipcbridge.exe" "$windows_dir/winediscordipcbridge.exe"
	$wine_bin reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices' /v 'winediscordipcbridge' /d 'C:\windows\winediscordipcbridge.exe' /f >/dev/null 2>&1
}

uninstall()
{
	rm -v "$windows_dir/winediscordipcbridge.exe"
	$wine_bin reg delete 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices' /v 'winediscordipcbridge.exe' /f >/dev/null 2>&1
}

$action
