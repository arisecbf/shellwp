#!/bin/sh

#ipa解压并 extract 脚本，如果是 unity工程，还会尝试disunity 并分类整理。

function unity()
{
  if [ -d "Data" ]; then
    echo "unity"
    cd Data
    disunity extract *
    mkdir ../_OBJ
    mkdir ../_TGA
    mkdir ../_TGA/_KTX
    mkdir ../_AUDIO
    mkdir ../_SHADER
    mkdir ../_TTF

    find . -name "*.tga" -print -exec mv {} ../_TGA/ \;
    find . -name "*.ktx" -print -exec mv {} ../_TGA/_KTX/ \;
    find . -name "*.obj" -print -exec mv {} ../_OBJ/ \;
    find . -name "*.mp3" -print -exec mv {} ../_AUDIO/ \;
    find . -name "*.wav" -print -exec mv {} ../_AUDIO/ \;
    find . -name "*.shader" -print -exec mv {} ../_SHADER/ \;
    find . -name "*.ttf" -print -exec mv {} ../_TTF/ \;
    find . -name "*.TTF" -print -exec mv {} ../_TTF/ \;
    echo "unity done"
    cd ..
  fi

}

function unipa()
{
  echo $1
  mkdir "$1.dir"
  unzip "$1" -d "$1.dir"
  cd "$1.dir"
  mv Payload/*/*  ./
  rm -ff iTunes*
  rm -rf META-INF
  rm -rf Payload
  rm -rf _CodeSignature
  rm -rf *.lproj
  rm -rf zh*
  unity "$1"
  cd ..
  rm -rf "$1"
}

unipa "$1"
