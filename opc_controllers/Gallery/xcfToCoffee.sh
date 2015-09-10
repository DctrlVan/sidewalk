#!/bin/bash
# execute this script with the name of the file
# to be processed as the first argument.
# have a folder of xcf frames
# saved as 1.xcf, 2.xct ... in the
# designated <fileName>/xcf/*.xcf

dir=${1}/xcf/
resDir=${1}/coffee/
fileCount=`ls -l $dir[0-9]*\.xcf | wc -l`
mkdir $resDir
for N in `seq 1 1 $fileCount`;
do
convert $dir$N\.xcf $N.txt
cat $N.txt | \
sed s/.*\(/\ \ \[/ | \
sed s/,[^,]*\).*$/\ \]/ > \
temp.txt
echo """module.exports=[ `cat temp.txt` ]""" > \
$resDir$N.coffee
rm $N.txt
rm temp.txt
done
