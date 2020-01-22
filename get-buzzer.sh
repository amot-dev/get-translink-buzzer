echo "Hello, "$USER", and welcome to the Translink Buzzer download tool!"
read -p "Please enter the year in which to begin downloads (1910-2019): " START_YEAR
START_DECADE='expr $START_YEAR / 10 \* 10'

read -p "Please enter the year in which to end downloads (1910-2019): " END_YEAR
END_DECADE='expr $END_YEAR / 10 \* 10'

CURRENT_YEAR=$START_YEAR
CURRENT_DECADE=$START_DECADE

while [ $CURRENT_DECADE -le $END_DECADE ]
do
    while [ $CURRENT_YEAR -le $END_YEAR ]
    do
        wget -r -A *.pdf https://www.translink.ca/Rider-Guide/Print-Buzzer.aspx?year=$CURRENT_YEAR
        cd www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/${CURRENT_DECADE}s/
        mv ${CURRENT_YEAR}/* .
        rmdir ${CURRENT_YEAR}
        cd ../../../../../../../
        CURRENT_YEAR=`expr $CURRENT_YEAR + 1`
    done
    cd www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/${CURRENT_DECADE}s/
    pdfunite *.pdf ${CURRENT_DECADE}s.pdf
    cd ../
    mv ${CURRENT_DECADE}s/${CURRENT_DECADE}s.pdf . && rm -rf ${CURRENT_DECADE}s
    cd ../../../../../../
    CURRENT_DECADE=`expr $CURRENT_DECADE + 10`
done

mkdir The\ Buzzer\ Compilation
mv www.translink.ca/-/media/Documents/rider_guide/Buzzer-Vault/* The\ Buzzer\ Compilation && rm -rf www.translink.ca