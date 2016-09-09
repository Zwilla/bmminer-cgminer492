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
md5sum bmminer-api > bmminer-api.md5
md5sum bmminer > bmminer.md5
md5sum restoreConfig.sh > restoreConfig.md5
tar -cf AntminerS9-Update-Bmminer.tar bmminer.md5 bmminer-api.md5 restoreConfig.sh bmminer-api bmminer