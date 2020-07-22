#!/bin/bash
readonly OOISVER="1.0.0"
readonly OOIS="oOWeb-WP-Setup-Script $OOISVER"

### SET WP PARAMS ###
WPURL=https://subdomain.domain.com # required
WPDOCROOT=/subdomain.domain.com/htdocs/ # required
WPDB=dbXXX  # required
WPDBPW=pwXXX  # required
WPTITLE='Website title goes here' # required
WPSUBTITLE='Website subtitle goes here' # required

### Have entered all required parameters correctly?
CONFIRM='no' # Change to "yes" after filling out lines 
### SET WP PARAMS ###


### SET SOME DIRECTORIES ###
RUNDIR=$(pwd)
ACCOUNTNR=${USER##*\-} # # ACCOUNTNR=${LOGNAME:4}
ACCOUNTDIR=/www/htdocs/$ACCOUNTNR
WPCLIRUNNER=$ACCOUNTDIR/_oo-web-tools/wp-cli/wp-cli.phar
### /SET SOME DIRECTORIES ###

clear
if [ "$CONFIRM" == "yes" ]; then

cd $ACCOUNTDIR$WPDOCROOT
WPPW=$(openssl rand -base64 12)

$WPCLIRUNNER core download --locale=de_DE
$WPCLIRUNNER config create --dbname=$WPDB --dbuser=$WPDB --dbpass=$WPDBPW --dbhost=localhost
$WPCLIRUNNER db create
$WPCLIRUNNER core install --url="$WPURL" --title="$WPTITLE" --admin_user="onoffice-web" --admin_password="$WPPW" --admin_email="wp-admin@onofficeweb.com"
$WPCLIRUNNER option set blog_public 0
$WPCLIRUNNER option set blogdescription "$WPSUBTITLE"
$WPCLIRUNNER plugin delete hello akismet
$WPCLIRUNNER theme delete twentyseventeen twentynineteen

# TODO: Add standard plugins

cd $RUNDIR
printf "\n\n\n +++ Temporary (please change) +++\n\n\n$WPPW\n\n\n"
exit

else 

printf "\n\n\n+++ Please edit all configuration data in script wp-install.sh (lines 6-14) +++\n\n\n"

fi
