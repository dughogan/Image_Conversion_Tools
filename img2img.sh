#! /bin/bash

progress=""

bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

echo -n "What is your ${bold}SOURCE ${normal}image format (jpg, tif, png, tga, or exr)?:${normal} "
read source
echo -n "What format are you converting to (jpg, tif, png, tga, or exr)?:${normal} "
read format
echo -n "Finally, enter the direct folder path to your ${bold}$source images:${normal} "
read path

echo ""
echo "${bold}Got it!" 
echo "Prepping ${bold}$source ${normal} images for ${bold}$format creation${normal}..."
echo ""

for i in $path*.$source;
  do
  res=$(identify -format %wx%h\\n "$i");
  convert "$i" -resize $res -alpha off -colorspace sRGB -monitor "${i%.$source}.$format";
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