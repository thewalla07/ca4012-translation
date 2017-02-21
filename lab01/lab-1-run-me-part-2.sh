#cp -r /users/tutors/ca4012lab/lab-data/. $corpus

echo 
echo "#  Testing"
echo "## Run decoder" 
echo

cd $me/working 
$moses/bin/moses -f ./mert-work/moses.ini

