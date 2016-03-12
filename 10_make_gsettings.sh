#!/bin/bash

#-----------------------------
# Discover Session Bus Address necessary for some commands like gsettings
function discover_session_bus_address()
{

# Set DBUS_SESSION_BUS_ADDRESS necessary for some commands like gsetting
# Search these processes for the session variable 
# (they are run as the current user and have the DBUS session variable set)
compatiblePrograms=( nautilus gnome-session kdeinit kded4 pulseaudio trackerd )

# Attempt to get a program pid
for index in ${compatiblePrograms[@]}; do
    PID=$(pidof -s ${index})
    if [[ "${PID}" != "" ]]; then
        break
    fi
done
if [[ "${PID}" == "" ]]; then
    echo "Could not detect active login session"
    exit 1
fi

QUERY_ENVIRON="$(tr '\0' '\n' < /proc/${PID}/environ | grep "DBUS_SESSION_BUS_ADDRESS" | cut -d "=" -f 2-)"
if [[ "${QUERY_ENVIRON}" != "" ]]; then
    export DBUS_SESSION_BUS_ADDRESS="${QUERY_ENVIRON}"
    echo "Connected to session:"
    echo "DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS}"
else
    echo "Could not find dbus session ID in user environment."
    exit 1
fi

}

#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------

# Discover Session Bus Address necessary for some commands like gsettings
discover_session_bus_address

#------------------------
# Show "Trash" on desktop 
gsettings set org.gnome.nautilus.desktop trash-icon-visible true

#------------------------
# Enable recursive search in Nautilus File Manager
gsettings set org.gnome.nautilus.preferences enable-interactive-search false

exit 0
