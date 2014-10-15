IFS='
'

./install_deb_deps.pl

rm -rf libcouchbase
rm -rf lcbpackage
rm -rf *.tar.gz
rm -rf ubuntu-archive-keyring.gpg*

CURRENT_DIR=`pwd`

wget http://archive.ubuntu.com/ubuntu/project/ubuntu-archive-keyring.gpg
cp ubuntu-archive-keyring.gpg /usr/share/keyrings/

echo debian http://ftp.debian.org/debian >> /etc/approx/approx.conf
echo ubuntu http://ftp.ubuntu.com/ubuntu >> /etc/approx/approx.conf


git clone git://github.com/couchbaselabs/lcbpackage
cd lcbpackage
git submodule init
git submodule update
deb/setup-cowbuilders.pl
cd $CURRENT_DIR

git clone git://github.com/couchbase/libcouchbase
cd libcouchbase
./config/autorun.sh
./configure --disable-tests --disable-couchbasemock 
make
make dist

BUILD_DIR=build
TAR_FILE=$(find . -name "*tar.gz" | sed 's/.\///g')
echo "$TAR_FILE"

VERSION=$(git describe | sed 's/-/_/g')
mkdir -p $BUILD_DIR

mv $TAR_FILE $BUILD_DIR/libcouchbase_$VERSION.orig.tar.gz
cp  $BUILD_DIR/libcouchbase_$VERSION.orig.tar.gz  $BUILD_DIR/libcouchbase_$1.orig.tar.gz
cd $BUILD_DIR
PKG_DIR=libcouchbase-$VERSION
NEW_PKG_DIR=libcouchbase-$1

tar xvzf libcouchbase_$VERSION.orig.tar.gz
echo "$PKG_DIR"

cp -R ../packaging/deb $PKG_DIR/debian
mv $PKG_DIR $NEW_PKG_DIR

	cd $NEW_PKG_DIR
	dch \
		--no-auto-nmu \
		--newversion "$1" \
		"Release package for libcouchbase $1"


dpkg-buildpackage -uc -us

cd ../
dpkg -r 'libcouchbase*'
 
PKG=$(find . -name "*core*deb" | sed 's/.\///g')
dpkg -i $PKG
PKG=$(find . -name "*dev*deb" | sed 's/.\///g')
dpkg -i $PKG

 
