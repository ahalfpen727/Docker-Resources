#!bin/bash
## BWA > samblaster > samtools

array=""
refGenome=""

docker run -w ${HOME}/${USER} -e HOME= ${HOME}/${USER}/toolbin -e USER=${USER} \
       --user ${USER} -i -t compbio/ngseasy-bwa:1.0 /bin/bash -c \
       "bwa mem -t 32 -V -M -a ${refGenome} ${array}.fasta | \
       samblaster --addMateTags --excludeDups | \
       samtools sort -@ 32 -T temp_ -O sam -o ${array}.sam && \
       samtools index ${array}.sam && rm ${array}.sam"
