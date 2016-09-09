#!/bin/sh
# set -v
set -e
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
#Make a backup now at first
cp BackupMyFilesAndDownload.cgi /www/pages/cgi-bin/BackupMyFilesAndDownload.cgi

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
	    cp -p $f /config/upgrade/
    fi;
done

chmod -R 777 /config/upgrade
chmod -R 777 /config/downgrade

md5sum -c /config/upgrade/bmminer.md5
md5sum -c /config/upgrade/bmminer-api.md5

# Backup original, but do not overwirte
cp -p -n /usr/bin/bmminer /config/downgrade/bmminer-orig;
cp -p -n /usr/bin/bmminer-api /config/downgrade/bmminer-api-orig;
cp -p -n /www/pages/upgrade.html /config/downgrade/upgrade.html-orig;

# with this you can access the miner hard from outside just call http://minerip/cgi-bin/StartMinerSoftware.cgi
cp -p StartMinerSoftware.cgi /www/pages/cgi-bin/StartMinerSoftware.cgi;
rm -- /usr/bin/bmminer
rm -- /usr/bin/bmminer-api
cp -p /config/upgrade/bmminer /usr/bin/bmminer
cp -p /config/upgrade/bmminer-api /usr/bin/bmminer-api
cp -p upgrade.html /www/pages/upgrade.html;

cd /usr/bin;

echo $(date) > /config/upgrade/update.date
sync;
su root -- /etc/init.d/bmminer.sh stop;
sleep 2
su root -- /etc/init.d/bmminer.sh restart;




# CGI output must start with at least empty line (or headers)
printf "Content-type: text/html\r\n\r\n"

cat <<-EOH
<!DOCTYPE HTML>
<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="5; url=/cgi-bin/BackupMyFilesAndDownload.cgi;">
        <script type="text/javascript">
            window.location.href="/cgi-bin/BackupMyFilesAndDownload.cgi";
        </script>


<script>

function f_submit_goback() {
	window.location.href="/cgi-bin/BackupMyFilesAndDownload.cgi";
}
</script>

        <title>Backup complete!</title>
    </head>
     <H1>Backup complete!</H1>
    <body>

        If you are not redirected automatically, follow the <a href='f_submit_goback()'>link</a>
    </body>
</html>
EOH

exit;


# NOTE!!! Not yet tested !!!
