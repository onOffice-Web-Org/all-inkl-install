#!/bin/bash
readonly OOISVER="1.0.1"
readonly OOIS="oOWeb-WP-Plugins-Install-Script $OOISVER"

### SET WP DOCROOT ###
WPDOCROOT=/12345.onofficeweb.com/htdocs/ # required
ACF_KEY=12345 #required
### /SET WP DOCROOT ###


### SET SOME DIRECTORIES ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR
PLUGINPATH="${ACCOUNTDIR}${WPDOCROOT}wp-content/plugins/"

PLUGINSTOINSTALL="iwp-client all-in-one-wp-security-and-firewall acf-extended head-footer-code wps-hide-login"
PLUGINSTOINSTALLANDACTIVATE="duplicate-post updraftplus"

### /SET SOME DIRECTORIES ###

### DOWNLOAD ACF PRO ###
ACFFILE="$PLUGINPATH/advanced-custom-fields-pro.zip"

wget -O ${ACFFILE} "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=$ACF_KEY"


clear

cd $ACCOUNTDIR$WPDOCROOT

wp plugin install $PLUGINSTOINSTALL
wp plugin install $PLUGINSTOINSTALLANDACTIVATE --activate
wp plugin install ${ACFFILE} --activate

rm ${ACFFILE}

### CONFIG Updraft Plus ###
wp option update updraft_interval weekly
wp option update updraft_retain 4
wp option update updraft_interval_database daily
wp option update updraft_retain_db 30

cd $RUNDIR
