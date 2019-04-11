#! /bin/bash

format="QT"
#res="2048x858"
progress=""

bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

echo -n "Please enter the path to your ${bold}tifs:${normal} "
read path
echo -n "Copy/Paste the name of your image basename: "
read base

echo ""
echo "${bold}Prepping images for Quicktime creation${normal}..."
echo ""

for i in $path$base.m.*.tif;
  do
  res=$(identify -format %wx%h\\n "$i");
  convert "$i" -resize $res -alpha off -colorspace sRGB -monitor "${i%.tif}.png";
  progress+=("#");
  echo -e ${progress[@]};
  done
  
for i in $path;
  do
  mkdir $path$format;
  done

for i in $path$base.m.*.png;
  do mv "$i" $path$format;
  done

echo ""
echo "${bold}${green}Done!${normal}"
echo ""
echo "${bold}Starting Quicktime creation...${normal}"
echo ""

for image in $path$format/$base.m.*.png; 
  do
  INPUT=`echo $image | sed 's:\.[0-9]\{4,\}\.:.%04d.:'`;  
  res=$(identify -format %wx%h\\n "$image");
  ffmpeg -i $INPUT -s $res -vcodec qtrle $path$format/$base.mov;
  break;
  done
  
for i in $path$format/$base.m.*.png;
  do
  rm "$i";
  done
  

echo ""
echo ""
echo "${bold}${green}Done!${normal}"
echo ""
echo "Quicktime file located at ${bold}$path$format/${normal}"
echo ""
echo ""