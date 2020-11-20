#!/bin/bash
readonly OOISVER="1.0.1"
readonly OOIS="oOWeb-WP-Plugins-Install-Script $OOISVER"

### SET WP DOCROOT ###
WPDOCROOT=/12345.onofficeweb.com/htdocs/ # required
### /SET WP DOCROOT ###


### SET SOME DIRECTORIES ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR

PLUGINSTOINSTALL="iwp-client all-in-one-wp-security-and-firewall head-footer-code wps-hide-login"
PLUGINSTOINSTALLANDACTIVATE="duplicate-post updraftplus"

### /SET SOME DIRECTORIES ###

clear

cd $ACCOUNTDIR$WPDOCROOT

wp plugin install $PLUGINSTOINSTALL
wp plugin install $PLUGINSTOINSTALLANDACTIVATE --activate

### CONFIG Updraft Plus ###
wp option update updraft_interval weekly
wp option update updraft_retain 4
wp option update updraft_interval_database daily
wp option update updraft_retain_db 30

cd $RUNDIR
