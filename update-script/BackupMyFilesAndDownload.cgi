#!/bin/sh
#set -e
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
# CGI output must start with at least empty line (or headers)

ip=$(echo `ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`);

printf "Content-type: text/html\r\n\r\n";

cat <<-EOH
    <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="cache-control" content="no-cache" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/cascade.css" />

<script type="text/javascript" src="/js/xhr.js"></script>
<title>Ant Miner</title>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="7; url=/index.html">

</head>

    <body class="lang_en">
<p class="skiplink">
<span id="skiplink1"><a href="#navigation">Skip to navigation</a></span>
        <span id="skiplink2"><a href="#content">Skip to content</a></span>
            </p>
<div id="menubar">
<h2 class="navigation"><a id="navigation" name="navigation">Navigation</a></h2>
    <div class="clear"></div>
</div>
<div id="menubar" style="background-color: #0a2b40;">
<div class="hostinfo" style="float:left;with:500px;">
<img src="/images/antminer_logo.png" width="92" height="50" alt="" title="" border="0" />
</div>
<div class="clear"></div>
</div>
<div id="maincontainer">
<div id="tabmenu">
<div class="tabmenu1">
<ul class="tabmenu l1">
<li class="tabmenu-item-status active"><a href="/index.html">System</a></li>
    <li class="tabmenu-item-system"><a href="/cgi-bin/minerConfiguration.cgi">Miner Configuration</a></li>
        <li class="tabmenu-item-network"><a href="/cgi-bin/minerStatus.cgi">Miner Status</a></li>
        <li class="tabmenu-item-system"><a href="/network.html">Network</a></li>
    </ul>
<br style="clear:both" />
<div class="tabmenu2">
<ul class="tabmenu l2">
<li class="tabmenu-item-system"><a href="/index.html">Overview</a></li>
    <li class="tabmenu-item-system"><a href="/administration.html">Administration</a></li>
    <li class="tabmenu-item-admin"><a href="/monitor.html">Monitor</a></li>
    <li class="tabmenu-item-packages"><a href="/kernelLog.html">Kernel Log</a></li>
        <li class="tabmenu-item-startup active"><a href="/upgrade.html">Upgrade</a></li>
    <li class="tabmenu-item-crontab"><a href="/reboot.html">Reboot</a></li>
    </ul>
<br style="clear:both" />
</div>
</div>
</div>
<div id="maincontent">
<noscript>
<div class="errorbox">
<strong>Java Script required!</strong><br /> You must enable Java Script in your browser or LuCI will not work properly.
                </div>
</noscript>
<h2><a id="content" name="content">Backup</a></h2>
    <a href="/zwilla_backup_all.tar">Click here to download the Backup I made before updating Bmminer Cgminer</a>
			<fieldset class="cbi-section">
EOH

# exec 2>&1

#iplocal=$(cat `ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`)
iplocal=`ifconfig|xargs|awk '{print $7}'|sed -e 's/[a-z]*:/''/'`
file1="zwilla_flashback_all_of_"
file2=$iplocal
filetype=".tar"
#file=$file1$iplocal$filetype
file=zwilla_backup_all.tar
dir=/config/backup
bkup_files="advanced.conf dropbear dropbear_rsa_host_key led-blink.conf lighttpd-htdigest.user network.conf shadow shadow.factory bmminer.conf bmminer.conf.factory";

trap atexit 0;

atexit() {
    rm -rf $dir;
    sync;

    if [ ! $ok ] ; then
        echo '<h1>Create backup failed</h1>';
    fi;

    if [ $ok ] ; then
        echo '<h1>Backup OK</h1>';

    echo '<br><br>';

    echo '<p>Click on Menu -Upgrade- to download it later </p>';

    echo '<br /><br />';

    echo '<h2>Wait,please! Starting your Cgminer 4.9.2 Software will take about 25 seconds</h2><br /><br />';
    fi;
};




mkdir -p $dir
cd $dir

    for f in $bkup_files ; do
if [ -f /config/$f ] ; then
    cp /config/$f .
        fi
            done;


cp -p /config/downgrade/bmminer-orig $dir;
cp -p /config/downgrade/bmminer-api-orig $dir;
cp -p /config/downgrade/upgrade.html-orig $dir;





> ./restoreConfig.sh
echo "#!/bin/sh -e"                                                        >> ./restoreConfig.sh
echo "touch /config/restoreConfig.sh" >> ./restoreConfig.sh
echo "mkdir -p /config/old_config"                                         >> ./restoreConfig.sh
echo "rm -rf /config/old_config/*"                                         >> ./restoreConfig.sh
echo "cd /config/"                                                         >> ./restoreConfig.sh
echo 'cd /config/'                                       >> ./restoreConfig.sh
echo "for f in $bkup_files ; do"                         >> ./restoreConfig.sh
echo '    if [ -f $f ] ; then'                           >> ./restoreConfig.sh
echo '	    cp $f /config/old_config/'                  >> ./restoreConfig.sh
echo '    fi'                                            >> ./restoreConfig.sh
echo 'done'                                              >> ./restoreConfig.sh
echo "cd /config/old_config"                                               >> ./restoreConfig.sh
echo "chmod 777 -R /config/old_config/"                                    >> ./restoreConfig.sh
echo "mv /usr/bin/bmminer /usr/bin/bmminer-old"                            >> ./restoreConfig.sh
echo "# we always use only the files from downgrade folder"                >> ./restoreConfig.sh
echo "mv /usr/bin/bmminer-api /usr/bin/bmminer-api-old"                    >> ./restoreConfig.sh
echo "cp -p /config/downgrade/upgrade.html-orig /www/pages/upgrade.html"   >> ./restoreConfig.sh
echo "cp -p /config/downgrade/bmminer-orig /usr/bin/bmminer"               >> ./restoreConfig.sh
echo "cp -p /config/downgrade/bmminer-api-orig /usr/bin/bmminer-api"       >> ./restoreConfig.sh
echo "cp -p * /config/"                                                    >> ./restoreConfig.sh
echo "chmod 755 /usr/bin/bmminer"                                          >> ./restoreConfig.sh
echo "chmod 755 /usr/bin/bmminer-api"                                      >> ./restoreConfig.sh
echo "sync" >> ./restoreConfig.sh
echo "if pgrep "bmminer" > /dev/null" >> ./restoreConfig.sh
echo "then" >> ./restoreConfig.sh
echo "su root /etc/init.d/bmminer.sh restart;" >> ./restoreConfig.sh
echo "else" >> ./restoreConfig.sh
echo "su root /etc/init.d/bmminer.sh start;" >> ./restoreConfig.sh
echo "fi;" >> ./restoreConfig.sh

echo 'printf "Content-type: text/html\r\n\r\n"' >> ./restoreConfig.sh
echo "cat <<-EOH" >> ./restoreConfig.sh
echo "<head>" >> ./restoreConfig.sh
echo "<meta http-equiv='refresh' content='0; url=/index.html'>" >> ./restoreConfig.sh
echo "</head>" >> ./restoreConfig.sh
echo "EOH" >> ./restoreConfig.sh



tar cf /www/pages/$file *

ok=1;
