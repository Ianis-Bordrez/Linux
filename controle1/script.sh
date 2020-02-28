PATH_IN=/tmp/in
PATH_OUT=/tmp/out
EXIT_ERROR=0

if [ ! -d $PATH_IN ]; then
    echo "Il manque le dossier /tmp/in"
    exit 3
elif [ ! "$(ls -A $PATH_IN)" ]; then
    echo "Pas de fichier a compresser"
    exit 4
elif [ ! -d $PATH_OUT ]; then
    mkdir $PATH_OUT
elif [ -f $PATH_OUT/lock ]; then
    echo "Le script est deja en cours d'execution"
    exit 22
fi

touch $PATH_OUT/lock

for f in $PATH_IN/*
do
{
    echo "Compression de $f.."
    gzip $f
    mv $f.gz $PATH_OUT
} || {
    echo "Une erreur est survenue sur le fichier $f"
    EXIT_ERROR=10
}
    
done
rm $PATH_OUT/lock

exit $EXIT_ERROR
