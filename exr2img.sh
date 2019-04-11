#! /bin/bash

format="QT"
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
echo "${bold}Prepping images for Quicktime creation${normal}..."
echo ""

for i in $path*.exr;
  do
  res=$(identify -format %wx%h\\n "$i");
  convert "$i" -resize $res -alpha off -colorspace sRGB -monitor "${i%.exr}.png";
  progress+=("#");
  echo -e ${progress[@]};
  done
  
for i in $path;
  do
  mkdir $path$format;
  done

for i in $path*.png;
  do mv "$i" $path$format;
  done

echo ""
echo "${bold}${green}Done!${normal}"
echo ""
echo "${bold}Starting Quicktime creation...${normal}"
echo ""

for image in $path$format/*.png;
  do
  BASENAME=`echo $image | sed 's:.*/::' | sed 's:\..*::'`;
  INPUT=`echo $image | sed 's:\.[0-9]\{4,\}\.:.%04d.:'`;
  res=$(identify -format %wx%h\\n "$image");
  break;
  done;

for image in $path$format/*.png; 
  do
  res=$(identify -format %wx%h\\n "$image");
  ffmpeg -i $INPUT -s $res -vcodec libx264 -crf 5  -pix_fmt yuv420p -y $path$format/$BASENAME.mov;
  break;
  done
  
for i in $path$format/*.png;
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