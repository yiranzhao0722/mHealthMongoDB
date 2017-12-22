#!/bin/bash

if grep -q "This computer is now linked" ~/.dropbox-ami/DBurl; then
  ~/.dropbox-dist/dropboxd &
fi
