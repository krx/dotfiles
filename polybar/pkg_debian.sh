#!/usr/bin/env bash
# encoding: utf-8

C=$(apt list --upgradable 2>/dev/null | tail -n +2 | wc -l)
echo "%{T4}%{F#b16286}%{F-}%{T-} ${C}"
