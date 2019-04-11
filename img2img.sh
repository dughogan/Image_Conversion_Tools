#! /bin/bash

progress=""

bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

echo -n "First, what is your source image format (jpg, tif, png, exr)?:${normal} "
read source
echo -n "Ok, enter the path to your ${bold}$source images:${normal} "
read path
echo -n "What image format are you changing to (jpg, tifs, png, exr)?:${normal} "
read format
echo -n "Finally, do you want the alpha on or off?${normal} "
read alpha_check

echo ""
echo "${bold}Got it! Prepping images for $format creation${normal}..."
echo ""

for i in $path*.$source;
  do
  res=$(identify -format %wx%h\\n "$i");
  convert "$i" -resize $res -alpha $alpha_check -colorspace sRGB -monitor "${i%.$source}.$format";
  progress+=("#");
  echo -e ${progress[@]};
  done
  
for i in $path;
  do
  mkdir $path$format;
  done

for i in $path*.$format;
  do mv "$i" $path$format;
  done

echo ""
echo "${bold}${green}Done!${normal}"
echo ""
echo ""