#!/bin/bash
readonly OOISVER="1.0.0"
readonly OOIS="oOWeb-WP-Plugins-Install-Script $OOISVER"

### SET WP DOCROOT ###
WPDOCROOT=/website-de.onofficeweb.com/htdocs/ # required
### /SET WP DOCROOT ###


### SET SOME DIRECTORIES ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR
WPCLIRUNNER=$ACCOUNTDIR/_oo-web-tools/wp-cli/wp-cli.phar

PLUGINSTOINSTALL="iwp-client all-in-one-wp-security-and-firewall head-footer-code wps-hide-login"
PLUGINSTOINSTALLANDACTIVATE="duplicate-post updraftplus"

### /SET SOME DIRECTORIES ###

clear

cd $ACCOUNTDIR$WPDOCROOT

$WPCLIRUNNER plugin install $PLUGINSTOINSTALL
$WPCLIRUNNER plugin install $PLUGINSTOINSTALLANDACTIVATE --activate

### CONFIG Updraft Plus ###
$WPCLIRUNNER option update updraft_interval weekly
$WPCLIRUNNER option update updraft_retain 4

$WPCLIRUNNER option update updraft_interval_database daily
$WPCLIRUNNER option update updraft_retain_db 30


cd $RUNDIR
