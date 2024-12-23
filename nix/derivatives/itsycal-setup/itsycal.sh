#!/bin/bash

set -e;
echo "Configuring Itsycal...";

defaults read com.mowglii.ItsycalApp;

defaults write com.mowglii.ItsycalApp ClockFormat "MMM dd \\Ud83d\\Udc7e HH:mm ";
defaults write com.mowglii.ItsycalApp HideIcon 1;