#!/bin/bash
cd /users/case4/wallm22/smt-lab/working/mert-work
/usr/local/mosesdecoder/bin/extractor  --scconfig case:true  --scfile run4.scores.dat --ffile run4.features.dat -r /users/case4/wallm22/smt-lab/corpus/tune-data.en -n run4.best100.out.gz
