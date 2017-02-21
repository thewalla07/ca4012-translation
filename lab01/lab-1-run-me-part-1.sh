#cp -r /users/tutors/ca4012lab/lab-data/. $corpus

echo 
echo "#  Preprocessing"
echo "## Tokenisation" 
echo
# preprocessing
## tokenisation
$moses/scripts/tokenizer/tokenizer.perl -l en < $corpus/train-data.en > $corpus/train-data-token.en
$moses/scripts/tokenizer/tokenizer.perl -l fr < $corpus/train-data.fr > $corpus/train-data-token.fr

### repeat this for other sets

echo 
echo "## Training" 
echo
## cleaning
$moses/scripts/training/clean-corpus-n.perl $corpus/train-data-token fr en $corpus/train-data-clean 1 50

echo 
echo "#  Language Modelling" 
echo
# language modelling
cd $me
#mkdir lm
cd ./lm
$irstlm/bin/add-start-end.sh < $corpus/train-data-token.en > ./lm-fr-en.sb.en

$irstlm/bin/build-lm.sh -i ./lm-fr-en.sb.en -n 3 -t ./tmp -p -s improved-kneser-ney -o ./lm.en

$irstlm/bin/compile-lm --text=yes lm.en.gz lm.arpa.en

echo "is this an english sentence" ? | $moses/bin/query lm.arpa.en

echo 
echo "#  Training" 
echo
#training
cd $me
#mkdir working
cd ./working
nohup nice $moses/scripts/training/train-model.perl -root-dir train -corpus $corpus/train-data-clean -f fr -e en -alignment grow-diag-final-and -reordering msd-bidirectional-fe -lm 0:3:$me/lm/lm.arpa.en:8 -external-bin-dir $moses/tools >&training.out &

echo "#-- run the tuning step seperately for 2 minutes"
