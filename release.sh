#!/bin/bash

usage(){
	echo "Version: $(git describe --tags --abbrev=0)"
	echo "Usage: $0 [options]"
	echo " h _______________ print this help"
	echo " v tag_name ______ create a tag git using tag_name. All version files from output libraries will be updated." 
	echo " r _______________ create a release for github API"
	echo " t _______________ skip the git tag creation"
	echo
	echo "PS: You must have the GITHUB_TOKEN env set for the 'r' option works"
}

if [ $# -eq 0 ];then
	usage
	exit 1
fi

while getopts "h:v:rt" OP; do
	case "${OP}" in
		h)
			usage
			exit 0
			;;
		v)
			VERSION=$OPTARG
			;;
		r)
			RELEASE=1
			;;
		t) 
			NO_TAG_GIT=1
			;;
		*)
			usage
			exit 1
			;;
	esac
done

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

if [ "$NO_TAG_GIT" != "1" ]; then
	git tag -a v$VERSION -m "release version $VERSION" 
	git push --tags
fi

if [ "$RELEASE" == "1" ]; then
	echo "* Creating Github release"
	API_JSON=$(printf '{"tag_name": "v%s","target_commitish": "master","name": "v%s","body": "Release of version %s","draft": false,"prerelease": false}' $VERSION $VERSION $VERSION)
	OWNER=giovanebribeiro
	REPO=api.boaviagem.xyz-contracts
	curl -H "Authorization: token $GITHUB_TOKEN" -H 'Accept: application/vnd.github.v3+json' --data "$API_JSON" https://api.github.com/repos/$OWNER/$REPO/releases
	echo "* Creating Github release (OK)"
fi
