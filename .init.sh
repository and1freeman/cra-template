#!/bin/bash

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]
then
  echo "No project name provided. Exit."
  exit 1
fi

if [ -d "$PROJECT_NAME" ]
then
  echo "Folder with name $PROJECT_NAME already exist. Exit."
  exit 1
fi

echo "Creating $PROJECT_NAME.."
mkdir $PROJECT_NAME

pushd $PROJECT_NAME

echo "Cloning from and1freeman/cra-template.git"
git clone git@github.com:and1freeman/cra-template.git

mv cra-template/* cra-template/.gitignore .
sed -i "s/__PROJECT_NAME__/$PROJECT_NAME/" ./package.json

git init

yarn

echo "Delete cra-template folder manually."
popd
