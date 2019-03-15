#!/usr/bin/env bash

pkill compton

compton --conf $HOME/.config/compton/compton &

