cd $me/working
nohup nice $moses/scripts/training/mert-moses.pl $corpus/tune-data.fr $corpus/tune-data.en $moses/bin/moses ./train/model/moses.ini --mertdir $moses/bin/ >mert.out
