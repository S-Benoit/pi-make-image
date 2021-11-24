#!/bin/sh
echo 'Hello'

finalDir="/home/benoit/Raspberry/Images"
workDir="/home/benoit/Raspberry/Work"

rm -rf $workDir"/*"
rm -rf "/home/benoit/.local/share/Trash/files/*"
rm -rf "/home/benoit/.local/share/Trash/info/*"

echo '-= Step 1/6 =-'
echo 'Affichage des disques'
fdisk -l

echo ''
echo '-= Step 2/6 =-'
echo 'Derniere lettre de /dev/sd? ?'
read letterCard

echo ''
echo '-= Step 3/6 =-'
echo 'Nom du fichier de sortie?'
read fileName

currentDate=`date +"%Y%m%d%H%M%S"`
finalName=$finalDir"/"$currentDate"_raspberryOS_lite_"$fileName".img"

sdCard="/dev/sd"$letterCard

echo ''
echo '-= Step 4/6 =-'
echo "Creation de l'image de la carte "$sdCard

workingCopy=$workDir"/working_copie.img"
sudo ddrescue $sdCard $workingCopy

cp /home/benoit/Raspberry/reduct_img.sh $workDir/reduct_img_cp.sh

echo ''
echo '-= Step 5/6 =-'
echo "Reduction de l'image de l'image "
`cd /home/benoit/Raspberry/Work; ./reduct_img_cp.sh working_copie.img`

echo '-= Step 6/6 =-'
echo 'Nettoyage'
rm /home/benoit/Raspberry/Work/reduct_img_cp.sh
chown benoit $workingCopy
chgrp benoit $workingCopy
mv $workingCopy $finalName

