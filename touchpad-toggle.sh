#!/usr/bin/env bash

#
# Turn touchpad on and off
#

declare -r TOUCHPAD_NAME="SynPS/2 Synaptics TouchPad"

declare -i touchpad_id
declare -i prop_id
declare -i prop_status

function get_toggle_prop {
	local get_line

	get_line=$(xinput --list-props 10 \
		| grep 'Device Enabled' \
		| sed -E 's:.*?\(([0-9]+)\)\:.*?([0-1]):\1 \2:g')

	read prop_id prop_status <<< "$get_line"
}

get_toggle_prop
touchpad_id="$(xinput --list --id-only "$TOUCHPAD_NAME")"

if (( prop_status == 0 )) ; then
	xinput --set-prop $touchpad_id $prop_id 1
elif (( prop_status == 1 )) ; then
	xinput --set-prop $touchpad_id $prop_id 0
fi
