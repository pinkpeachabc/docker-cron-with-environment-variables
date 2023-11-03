# Display all env variable
echo 'backup start';
mongodump --authenticationDatabase=admin --uri $URL --gzip --archive=maxwell+$(date +'%y-%m-%d-%H%M').gz
cp maxwell+$(date +'%y-%m-%d').gz /backup
azcopy copy /backup/* $AZCOPY
echo 'backup end';