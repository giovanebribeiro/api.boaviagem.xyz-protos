#!/bin/bash

if [ "$1" != "" ]; then
	VERSION=$1
else
	echo "Informe uma versão. Ex: $0 1.0.0"
	exit 1
fi

VERSION=$1

echo "#########"
echo "### Atualizando descrição de pacotes com a versão $VERSION"
echo "#########"
echo 
echo 
echo 
sed -i -e "s/\<Version\>.*\<\/Version\>/<Version>$VERSION<\/Version>/g" out/csharp/*.csproj
git add out/csharp/*.csproj
git commit -m "atualização de versão - pacote C#"
echo "* C# (OK)"
BASEDIR=$PWD
cd out/nodejs
npm version $VERSION --no-git-tag-version -m "atualização de versão - pacote nodejs" 
cd $PWD
echo "* Node.JS (OK)"
git tag -a $VERSION -m "release version $VERSION" 
