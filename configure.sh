#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�s��bconfigure.sh �RMo�0��W�,�{�I�{�R%��S#�V�I&�!��=�V�߱���P	�̛�7��%;H��t�F�h��J4��C�b	��������
Xo0�Bd���M�����`�����˵*e�:�f�b\�L����|a��a�x�9��fs��N�I�q�o�B���<����DE�x�����Jӯ������yīY����Ҋ�������Un~v�����xB'�dP���+�m�{iv��Y�	�=��PJzu���s���߃p�{��f�.b�[>e�#s�ey��^>Ά�P�m�Y��ݩ�wA���p�!�L����A�b��zq[;Qa\S���<�i���DUR=&V���h�X��!�dR%����|^iz����Ή�K�M<��m�B_��H�Q�*X[W�.˷k��Ф1  