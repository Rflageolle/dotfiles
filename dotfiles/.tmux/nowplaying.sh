#!/usr/bin/env bash
command -v osascript > /dev/null 2>&1  && osascript -e 'set track_str to ""
if application "iTunes" is running then
	tell application "iTunes" to if player state is playing then set track_str to "♫ " & name of current track & " ♪ " & artist of current track & " ♫"
end if

if application "Spotify" is running then
	tell application "Spotify" to if player state is playing then set track_str to "♫ " & name of current track & " ♪ " & artist of current track & " ♫"
end if

track_str'
