#!/bin/bash

PACKAGES="Google Account Manager|com.google.android.gsf.login\n
Google Services Framework|com.google.android.gsf\n
Google Play Services|com.google.android.gms\n
Google Play Store|com.android.vending"

echo -e "This will install the following packages:"
echo -e $PACKAGES | while read -r PACKAGE; do
    name=${PACKAGE%\|*}
    pkg=${PACKAGE#*\|}
    echo -e "\t- $name ($pkg)"
done
echo ""
echo "PRESS ENTER TO CONTINUE OR CTRL+C TO ABORT."
read -s TEMP
echo ""

echo -e $PACKAGES | while read -r PACKAGE; do
    name=${PACKAGE%\|*}
    pkg=${PACKAGE#*\|}
    if compgen -G "${pkg}_*.apk"; then
        echo "Installing ${pkg}..."
        adb install ${pkg}_*.apk
        if [[ $? -ne 0 ]]; then
            echo "ERROR!: Something went wrong. Exiting."
            exit 1
        fi
    else
        echo "ERROR!: ${pkg}_*.apk was not found. Exiting."
        exit 1
    fi
done
