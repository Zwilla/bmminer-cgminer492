#!/bin/sh
set -v
# local ##### upload this file on "restore config" Menu only !!!
##############################################################################
 #
 # @category "Cgminer 4.9.2 for Bitmain Antminer S9"
 # @package "Mintorro-S9 Firmware"
 # @author Miguel Padilla <miguel.padilla@zwilla.de>
 # @copyright (c) 2016 - Miguel Padilla
 # @link "https://www.mintorro.com"
 #
 # According to our dual licensing model, this program can be used either
 # under the terms of the GNU Affero General Public License, version 3,
 # or under a proprietary license.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Affero General Public License for more details.
 #
##############################################################################
#
# vi restoreConfig-sh
# paste this code into
# press "esc" "w" "q"
#
# create the md5 sum at the folder where you compiled the source
#
#  cp cgminer bmminer
#  cp cgminer-api bmminer-api
#  md5sum bmminer-api > bmminer-api.md5
#  md5sum bmminer > bmminer.md5
#
#  review this script, test it on ssh terminal and then save it again with your changes and
#
#  md5sum restoreConfig.sh > restoreConfig.md5
#
#  cp restoreConfig.sh and restoreConfig.md5 to your build root
#
# create the tar
# tar -cf AntminerS9-Update-Bmminer.tar restoreConfig.md5 bmminer.md5 bmminer-api.md5 restoreConfig.sh bmminer-api bmminer
#
# now copy AntminerS9-Update-Bmminer.tar to your computer from where you have access to the frontend of your Antminer S9
#
#  * click on Menu System
#  * click on Menu Upgrade
#  * click on menu "Restore backup"
#  * choose the AntminerS9-Update-Bmminer.tar
#  * click on "upload Archive..."
#
# now the following process will start:
#
#   * uploading AntminerS9-Update-Bmminer.tar
#   * check for old version and delete them
#   * check the md5sum of the files
# 
mkdir -p /config/upgrade
mkdir -p /config/downgrade
touch /config/restoreConfig.sh
chmod 777 /config/upgrade
chmod 777 /config/downgrade

rm -rf /config/upgrade/bmminer
rm -rf /config/upgrade/bmminer-api
rm -rf /config/upgrade/bmminer.md5
rm -rf /config/upgrade/bmminer-api.md5



for f in bmminer.md5 bmminer-api.md5 bmminer-api bmminer; do
    if [ -f $f ] ; then
	    cp $f /config/upgrade/
    fi;
done

chmod -R 777 /config/upgrade
chmod -R 777 /config/downgrade

md5ok1=$(md5sum -c /config/upgrade/bmminer.md5);
md5ok2=$(md5sum -c /config/upgrade/bmminer-api.md5);


if [ "$md5ok1"="bmminer: OK" ] && [ "$md5ok2"="bmminer-api: OK" ] ; then
cp /usr/bin/bmminer /config/downgrade/bmminer-backup
cp /usr/bin/bmminer-api /config/downgrade/bmminer-api-backup
rm -- /usr/bin/bmminer
rm -- /usr/bin/bmminer-api
cp /config/upgrade/bmminer /usr/bin/bmminer
cp /config/upgrade/bmminer-api /usr/bin/bmminer-api
sync

/etc/init.d/bmminer.sh restart
fi;

# CGI output must start with at least empty line (or headers)
printf "Content-type: text/html\r\n\r\n"

cat <<-EOH
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="cache-control" content="no-cache" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/cascade.css" />
<!--[if IE 6]><link rel="stylesheet" type="text/css" media="screen" href="/css/ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="/css/ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" media="screen" href="/css/ie8.css" /><![endif]-->
<script type="text/javascript" src="/js/xhr.js"></script>
<script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/js/json2.min.js"></script>
<script>

function f_submit_goback() {
	window.location.href="/index.html";
}
</script>
<title>Ant Miner</title>
</head>
EOH
# CGI output must start with at least empty line (or headers)
printf "Content-type: text/html\r\n\r\n"

cat <<-EOH
<!DOCTYPE HTML>
<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="5; url=index.html;">
        <script type="text/javascript">
            window.location.href="/index.html";
        </script>
        
        
<script>
function goBack() {
    window.history.go(-2);
}
</script>

        <title>Upgrade complete!</title>
    </head>
     <H1>Upgrade complete!</H1>
    <body>
       
        If you are not redirected automatically, follow the <a href='f_submit_goback()'>link</a>
    </body>
</html>
EOH




# NOTE!!! Not yet tested !!!
