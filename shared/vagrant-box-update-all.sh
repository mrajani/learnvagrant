#!/bin/bash
# <script src="https://gist.github.com/thom8/791f6c9978abda5e4e84.js"></script>
# Find all boxes which have updates
AVAILABLE_UPDATES=`vagrant box outdated --global | grep outdated | tr -d "*'" | cut -d ' ' -f 2`

if [ ! ${#AVAILABLE_UPDATES[@]} -eq 0 ]; then
  for box in $AVAILABLE_UPDATES ; do

    echo "Found an update for $box"

    # Find all current versions
    VERSIONS=`vagrant box list | grep $box | cut -d ',' -f 2 | tr -d ' )'`

    # Add latest version
    vagrant box add --provider virtualbox --clean $box
    BOX_UPDATED="TRUE"

    # Remove all old versions
    for version in $VERSIONS ; do
      vagrant box remove $box -f --box-version=$version
    done

  done

  echo "All boxes are now up to date!"

else

  echo "All boxes are already up to date!"

fi

vagrant box outdated --global

