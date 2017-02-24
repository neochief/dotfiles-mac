#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf "${DIR}"/Russian\ \(Typographic\ +\ Ukrainian\).keylayout ~/Library/Keyboard\ Layouts/Russian\ \(Typographic\ +\ Ukrainian\).keylayout

defaults write com.apple.HIToolbox AppleEnabledInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>252</integer><key>KeyboardLayout Name</key><string>ABC</string></dict>' '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>-20914</integer><key>KeyboardLayout Name</key><string>Russian (Typographic + Ukrainian)</string></dict>'

defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "{enabled = 1; value = { parameters = (32, 49, 1048576); type = 'standard'; }; }"
