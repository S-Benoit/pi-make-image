#!/bin/sh
echo 'Hello'

currentUser="benoit"

finalDir=$HOME/Raspberry/Images
workDir=$HOME/Raspberry/Work

mkdir -p $finalDir
mkdir -p $workDir

rm -rf $workDir/*
rm -rf $HOME/.local/share/Trash/files/*
rm -rf $HOME/.local/share/Trash/info/*

echo '-= Step 1/6 =-'
echo 'Display disks'
fdisk -l

echo ''
echo '-= Step 2/6 =-'
echo 'Last letter of /dev/sd? ?'
read letterCard

echo ''
echo '-= Step 3/6 =-'
echo 'Output filename ?'
read fileName

currentDate=`date +"%Y%m%d%H%M%S"`
finalName=$finalDir"/"$currentDate"_raspberryOS_lite_"$fileName".img"

sdCard="/dev/sd"$letterCard

echo ''
echo '-= Step 4/6 =-'
echo "Card "$sdCard" image creation"

workingCopy=$workDir"/working_copie.img"
sudo ddrescue $sdCard $workingCopy

cp $HOME/Raspberry/reduct_img.sh $workDir/reduct_img_cp.sh

echo ''
echo '-= Step 5/6 =-'
echo "Reduction de l'image de l'image "
`cd $HOME/Raspberry/Work; ./reduct_img_cp.sh working_copie.img`

echo '-= Step 6/6 =-'
echo 'Nettoyage'
rm $HOME/Raspberry/Work/reduct_img_cp.sh
chown $currentUser $workingCopy
chgrp $currentUser $workingCopy
mv $workingCopy $finalName

