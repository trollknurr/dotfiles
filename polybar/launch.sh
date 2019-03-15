#!/usr/bin/env bash

pkill polybar

polybar --reload top &
polybar --reload top_right &
