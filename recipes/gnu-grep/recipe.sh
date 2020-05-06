VERSION=3.1
TAR=https://ftp.gnu.org/gnu/grep/grep-$VERSION.tar.xz

function recipe_version {
    echo "$VERSION"
    skip=1
}

function recipe_update {
    echo "skipping update"
    skip=1
}

function recipe_build {
    export LDFLAGS="-static"
    ./configure --build=${BUILD} --host=${HOST} --prefix=/
    $REDOX_MAKE -j"$($NPROC)"
    skip=1
}

function recipe_test {
    echo "skipping test"
    skip=1
}

function recipe_clean {
    $REDOX_MAKE clean
    skip=1
}

function recipe_stage {
    dest="$(realpath $1)"
    $REDOX_MAKE DESTDIR="$dest" install
    $HOST-strip "$1"/bin/grep
    rm -rf "$1"/{lib,share}
    skip=1
}
