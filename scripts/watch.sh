#!/bin/bash

ROOT="$(pwd)/src"
FOLDER_TO_WATCH="${1/\//}"

[[ -z "$FOLDER_TO_WATCH" ]] && echo "No folder was specified. " && exit 1

update_index() {
  FOLDER=$1
  INDEX_PATH="$FOLDER/index.js"

  if [ ! -f "$INDEX_PATH" ]
  then
    echo "No \"$INDEX_PATH\" file found. Creating.."
    touch $INDEX_PATH
  fi

  # delete file content
  truncate -s 0 $INDEX_PATH

  FILES=(`find $FOLDER -type f \( -name "*.jsx" -or -name "*.js" ! -iname "index.js" -not -path "*/utils/*" \)`)

  pushd $FOLDER

  for f in "${FILES[@]}";
  do
    rel_path=".${f#$FOLDER}"
    filename=`basename "$rel_path"`
    name=${filename%%.*}
    echo "export { default as $name } from '$rel_path'" >> $INDEX_PATH
  done

  popd
}


daemon() {
  FOLDER="$ROOT/$1"

  if [ ! -d "$FOLDER" ]
  then
    echo "$FOLDER not found."
    return 1
  fi

  CHECK_SUM_1=""

  while [[ true ]]
  do
    # CHECK_SUM_2=`find $FOLDER/ -maxdepth 1 -type f -exec md5sum {} \;`
    CHECK_SUM_2=`find $FOLDER -type f  \( -name "*.jsx" -or -name "*.js" ! -iname "index.js" \) | md5sum`
    if [[ $CHECK_SUM_2 != $CHECK_SUM_1 ]]
    then
      CHECK_SUM_1=$CHECK_SUM_2
      update_index $FOLDER
    fi
    sleep 2
  done
}

daemon "$FOLDER_TO_WATCH"
