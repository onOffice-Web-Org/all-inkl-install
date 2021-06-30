#!/bin/bash
readonly OOISVER="1.0.2"
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
### /SET SOME DIRECTORIES ###

clear
if [ "$CONFIRM" == "yes" ]; then

cd $ACCOUNTDIR$WPDOCROOT
WPPW=$(openssl rand -base64 64 | base64 | head -c 14)

wp core download --locale=de_DE
wp config create --dbname=$WPDB --dbuser=$WPDB --dbpass=$WPDBPW --dbhost=localhost
wp db create
wp core install --url="$WPURL" --title="$WPTITLE" --admin_user="onoffice-web" --admin_password="$WPPW" --admin_email="wp-admin@onofficeweb.com"
wp option set blog_public 0
wp option set blogdescription "$WPSUBTITLE"
wp plugin delete hello akismet
wp theme delete twentyseventeen twentynineteen twentytwenty

cd $RUNDIR

cat << "EOF"
#
#
#  _       ______     ____                                          __
# | |     / / __ \   / __ \____ ____________      ______  _________/ /
# | | /| / / /_/ /  / /_/ / __ `/ ___/ ___/ | /| / / __ \/ ___/ __  /
# | |/ |/ / ____/  / ____/ /_/ (__  |__  )| |/ |/ / /_/ / /  / /_/ /
# |__/|__/_/      /_/    \__,_/____/____/ |__/|__/\____/_/   \__,_/
#
#
EOF
printf "\n\n\n +++ Temporary (please change) +++\n\n\n$WPPW\n\n\n"

exit

else 

printf "\n\n\n+++ Please edit all configuration data in script wp-install.sh (lines 6-14) +++\n\n\n"

fi
