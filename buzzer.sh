#!/bin/bash
YEAR=2019
DECADE=2010
while [ $DECADE -ge 1910 ]
do
    while [ $YEAR -ge $DECADE ]
    do
        wget -r -A *.pdf https://www.translink.ca/Rider-Guide/Print-Buzzer.aspx?year=$YEAR
        cd www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/${DECADE}s/
        mv ${YEAR}/* .
        rmdir ${YEAR}
        cd ../../../../../../../
        YEAR=`expr $YEAR - 1`
    done
    cd www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/${DECADE}s/
    pdfunite *.pdf ${DECADE}s.pdf
    cd ../
    mv ${DECADE}s/${DECADE}s.pdf . && rm -rf ${DECADE}s
    cd ../../../../../../
    DECADE=`expr $DECADE - 10`
done

mkdir The\ Buzzer\ Compilation
mv www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/* The\ Buzzer\ Compilation && rm -rf www.translink.ca