#!/bin/bash
readonly OOISVER="1.0.1"
readonly OOIS="oOWeb-WP-Migration-Script $OOISVER"

### SET WP DOCROOT ###
WPDOCROOT=/website-de.onofficeweb.com/htdocs/ # required
### /SET ###


### SET SOME DIRECTORIES AND PARAMETERS ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR
WPCLIRUNNER=$ACCOUNTDIR/_oo-web-tools/wp-cli/wp-cli.phar

PLUGINSTOKILL="hello akismet login-lockdown wp-rocket w3-total-cache"

THEMESTOKILL="twentyfifteen twentysixteen twentyseventeen twentynineteen twentytwenty"

### /SET ###

clear

cd $ACCOUNTDIR$WPDOCROOT

$WPCLIRUNNER option update admin_email wp-admin@onofficeweb.com

$WPCLIRUNNER config delete FS_METHOD
$WPCLIRUNNER config delete automatic_updater_disabled
$WPCLIRUNNER config delete WP_MAX_MEMORY_LIMIT
$WPCLIRUNNER config delete WP_MEMORY_LIMIT
$WPCLIRUNNER config delete WP_CACHE


$WPCLIRUNNER plugin deactivate $PLUGINSTOKILL
$WPCLIRUNNER plugin delete $PLUGINSTOKILL

$WPCLIRUNNER theme delete $THEMESTOKILL

rm ./wp-content/wp-rocket-config/ -r
rm ./wp-content/w3tc-config/ -r
rm ./wp-content/mu-plugins/ -r
rm ./wp-content/advanced-cache.php

cd $RUNDIR
