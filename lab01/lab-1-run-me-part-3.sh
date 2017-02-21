cd $me/working

echo 
echo "## Get your BLEU score" 
echo "###Translate"
echo

nohup nice $moses/bin/moses -f ./train/model/moses.ini < $corpus/test-data.fr > ./translated.en 2> trans.out

echo
echo "###Evaluate"
echo

$moses/scripts/generic/multi-bleu.perl -lc $corpus/test-data.en <./translated.en
