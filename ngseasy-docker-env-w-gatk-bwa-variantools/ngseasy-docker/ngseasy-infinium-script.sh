#!bin/bash
## BWA > samblaster > samtools

array=""
refGenome=""

docker run -w /home/pipeman -e HOME=/home/pipeman -e USER=pipeman \
       --user pipeman -i -t compbio/ngseasy-bwa:1.0 /bin/bash -c \
       "bwa mem -t 32 -V -M -a ${refGenome} ${array}.fasta | \
       samblaster --addMateTags --excludeDups | \
       samtools sort -@ 32 -T temp_ -O sam -o ${array}.sam && \
       samtools index ${array}.sam && rm ${array}.sam"
