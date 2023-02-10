#!/bin/bash

this_directory=$(dirname "$0")

pushd $this_directory/../site
  rm -fr public
  hugo
popd

pushd $this_directory 
  cf push
popd
