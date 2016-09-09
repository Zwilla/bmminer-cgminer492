
git clone https://github.com/Zwilla/bmminer-cgminer492

cd bmminer-cgminer492

chmod -R 777 *

./autogen.sh CC=/usr/bin/arm-angstrom-linux-gnueabi-gcc NM=/usr/bin/arm-angstrom-linux-gnueabi-gcc-nm AR=/usr/bin/arm-angstrom-linux-gnueabi-ar -host arm-angstrom-linux-gnueabi --enable-bitmain-c5 --with-system-jansson

make

now copy the file to your miner

/usr/bin

do this:

cp /usr/bin/bmminer-perceft /usr/bin/bmminer

strip cgminer

mv /usr/bin/bmminer /usr/bin/bmminer-old

cp cgminer /usr/bin/bmminer

chmod 755 /usr/bin/bmminer

sync

sleep 1

/etc/init.d/bmminer.sh restart

sleep 3

screen -r


If you want to use your old bmminer, just run this

mv /usr/bin/bmminer-old /usr/bin/bmminer

/etc/init.d/bmminer.sh restart


debugging: (do not strip before)
gdb --args /usr/bin/bmminer --api-listen --default-config /config/bmminer.conf --version-file /usr/bin/compile_time -T

