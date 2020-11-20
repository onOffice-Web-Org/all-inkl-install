#!/bin/bash
readonly OOISVER="1.0.2"
readonly OOIS="oOWeb-WP-Migration-Script $OOISVER"

### SET WP DOCROOT ###
WPDOCROOT=/12345.onofficeweb.com/htdocs/ # required
### /SET ###


### SET SOME DIRECTORIES AND PARAMETERS ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR

PLUGINSTOKILL="hello akismet login-lockdown wp-rocket w3-total-cache patch-plugin"

THEMESTOKILL="twentyfifteen twentysixteen twentyseventeen twentynineteen twentytwenty"

### /SET ###

clear

cd $ACCOUNTDIR$WPDOCROOT

wp option update admin_email wp-admin@onofficeweb.com

wp config delete FS_METHOD
wp config delete automatic_updater_disabled
wp config delete WP_MAX_MEMORY_LIMIT
wp config delete WP_MEMORY_LIMIT
wp config delete WP_CACHE
wp config delete DISABLE_WP_CRON

wp option update timezone_string "Europe/Berlin"

wp plugin deactivate $PLUGINSTOKILL
wp plugin delete $PLUGINSTOKILL

wp theme delete $THEMESTOKILL

rm ./wp-content/wp-rocket-config/ -r
rm ./wp-content/w3tc-config/ -r
rm ./wp-content/mu-plugins/ -r
rm ./wp-content/advanced-cache.php

cd $RUNDIR
