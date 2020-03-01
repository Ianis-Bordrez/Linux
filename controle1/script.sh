PATH_IN=/tmp/in
PATH_OUT=/tmp/out
EXIT_ERROR=0

if [ ! -d $PATH_IN ]; then
    echo "Il manque le dossier /tmp/in" $PATH_OUT/log.txt
    exit 3
elif [ ! "$(ls -A $PATH_IN)" ]; then
    echo "Pas de fichier a compresser" $PATH_OUT/log.txt
    exit 4
fi
if [ ! -d $PATH_OUT ]; then
    mkdir $PATH_OUT
fi
if [ -f $PATH_OUT/lock ]; then
    echo "Le script est deja en cours d'execution" $PATH_OUT/log.txt
    exit 22
fi

if [ ! -f $PATH_OUT/log.txt ]; then
    touch $PATH_OUT/log.txt
fi


touch $PATH_OUT/lock

for f in $PATH_IN/*
do
{
    echo "Compression de $f.." >> $PATH_OUT/log.txt
    gzip $f
    mv $f.gz $PATH_OUT

} || {
    echo "Une erreur est survenue sur le fichier $f" >> $PATH_OUT/log.txt
    EXIT_ERROR=10
}
    
done
rm $PATH_OUT/lock

exit $EXIT_ERROR
