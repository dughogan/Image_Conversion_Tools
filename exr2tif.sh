#! /bin/bash

format="tifs"
#res="2048x858"
progress=""

bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

echo -n "Please enter the path to your ${bold}EXRs:${normal} "
read path

#echo -n "Please enter the resolution you want to render at: "
#read res

echo ""
echo "${bold}Prepping images for TIF creation${normal}..."
echo ""

for i in $path*.exr;
  do
  res=$(identify -format %wx%h\\n "$i");
  convert "$i" -resize $res -alpha on -colorspace sRGB -monitor "${i%.exr}.tif";
  progress+=("#");
  echo -e ${progress[@]};
  done
  
for i in $path;
  do
  mkdir $path$format;
  done

for i in $path*.tif;
  do mv "$i" $path$format;
  done

echo ""
echo "${bold}${green}Done!${normal}"
echo ""
echo ""