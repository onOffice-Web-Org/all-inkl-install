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

PLUGINSTOINSTALL="head-footer-code wps-hide-login"
PLUGINSTOINSTALLANDACTIVATE="duplicate-post updraftplus iwp-client acf-extended all-in-one-wp-security-and-firewall"

### /SET SOME DIRECTORIES ###

### DOWNLOAD ACF PRO ###
ACFFILE="${PLUGINPATH}advanced-custom-fields-pro.zip"

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

### Rewrite Permalinks to Postname to enable wps-hide-login
wp option update aio_wp_security_configs {"aiowps_enable_debug":"","aiowps_remove_wp_generator_meta_info":"1","aiowps_prevent_hotlinking":"","aiowps_enable_login_lockdown":"1","aiowps_allow_unlock_requests":"1","aiowps_max_login_attempts":5,"aiowps_retry_time_period":5,"aiowps_lockout_time_length":30,"aiowps_set_generic_login_msg":"1","aiowps_enable_email_notify":"1","aiowps_email_address":"wp-security@onofficeweb.com","aiowps_enable_forced_logout":"","aiowps_logout_time_period":"60","aiowps_enable_invalid_username_lockdown":"","aiowps_instantly_lockout_specific_usernames":["admin"],"aiowps_unlock_request_secret_key":"0jw05c64istj9kvl7j21","aiowps_lockdown_enable_whitelisting":"","aiowps_lockdown_allowed_ip_addresses":"","aiowps_enable_whitelisting":"","aiowps_allowed_ip_addresses":"","aiowps_enable_login_captcha":"","aiowps_enable_custom_login_captcha":"","aiowps_enable_woo_login_captcha":"","aiowps_enable_woo_register_captcha":"","aiowps_enable_woo_lostpassword_captcha":"","aiowps_captcha_secret_key":"bpvpngdqtfx5tx983yjk","aiowps_enable_manual_registration_approval":"1","aiowps_enable_registration_page_captcha":"1","aiowps_enable_registration_honeypot":"","aiowps_enable_random_prefix":"","aiowps_enable_automated_backups":"","aiowps_db_backup_frequency":"4","aiowps_db_backup_interval":"2","aiowps_backup_files_stored":"2","aiowps_send_backup_email_address":"","aiowps_backup_email_address":"wp-admin@onofficeweb.com","aiowps_disable_file_editing":"1","aiowps_prevent_default_wp_file_access":"1","aiowps_system_log_file":"error_log","aiowps_enable_blacklisting":"","aiowps_banned_ip_addresses":"","aiowps_enable_basic_firewall":"1","aiowps_max_file_upload_size":20,"aiowps_enable_pingback_firewall":"1","aiowps_disable_xmlrpc_pingback_methods":"1","aiowps_block_debug_log_file_access":"1","aiowps_disable_index_views":"1","aiowps_disable_trace_and_track":"1","aiowps_forbid_proxy_comments":"1","aiowps_deny_bad_query_strings":"1","aiowps_advanced_char_string_filter":"1","aiowps_enable_5g_firewall":"1","aiowps_enable_6g_firewall":"1","aiowps_enable_custom_rules":"","aiowps_place_custom_rules_at_top":"","aiowps_custom_rules":"","aiowps_enable_404_logging":"1","aiowps_enable_404_IP_lockout":"1","aiowps_404_lockout_time_length":60,"aiowps_404_lock_redirect_url":"http:\/\/127.0.0.1","aiowps_enable_rename_login_page":"1","aiowps_enable_login_honeypot":"1","aiowps_enable_brute_force_attack_prevention":"","aiowps_brute_force_secret_word":"huremuxi","aiowps_cookie_brute_test":"aiowps_cookie_test_ogkzf0tku7","aiowps_cookie_based_brute_force_redirect_url":"http:\/\/127.0.0.1","aiowps_brute_force_attack_prevention_pw_protected_exception":"1","aiowps_brute_force_attack_prevention_ajax_exception":"1","aiowps_site_lockout":"","aiowps_site_lockout_msg":"Es findet gerade eine Wartung der Website statt. Bitte besuchen Sie uns in einigen Minuten wieder.\r\n\r\n&lt;hr \/&gt;\r\n\r\nWebsite maintenance in progress.&nbsp; Please visit again in a couple of minutes.","aiowps_enable_spambot_blocking":"1","aiowps_enable_comment_captcha":"1","aiowps_enable_autoblock_spam_ip":"1","aiowps_spam_ip_min_comments_block":5,"aiowps_enable_bp_register_captcha":"","aiowps_enable_bbp_new_topic_captcha":"","aiowps_enable_automated_fcd_scan":"1","aiowps_fcd_scan_frequency":1,"aiowps_fcd_scan_interval":"1","aiowps_fcd_exclude_filetypes":"jpg\r\npng\r\nbmp\r\ngif\r\nzip\r\ngz\r\ntar\r\nrar\r\ndoc\r\ndocx\r\npdf\r\ntxt","aiowps_fcd_exclude_files":"aiowps_backups\r\nupdraft","aiowps_send_fcd_scan_email":"1","aiowps_fcd_scan_email_address":"wp-security@onofficeweb.com","aiowps_fcds_change_detected":false,"aiowps_copy_protection":"","aiowps_prevent_site_display_inside_frame":"","aiowps_prevent_users_enumeration":"","aiowps_disallow_unauthorized_rest_requests":"","aiowps_ip_retrieve_method":"0","aiowps_recaptcha_site_key":"","aiowps_recaptcha_secret_key":"","aiowps_default_recaptcha":"","aiowps_block_fake_googlebots":"1","aiowps_login_page_slug":"onoffice-admin","aiowps_cookie_test_success":"1","aiowps_fcd_filename":"aiowps_fcd_data_f2m775bk10","aiowps_last_fcd_scan_time":"2020-08-11 00:40:09","installed-at":1658172994}
wp rewrite structure /%postname%/
wp rewrite flush

cd $RUNDIR
