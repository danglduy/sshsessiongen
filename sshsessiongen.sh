#!/bin/bash
read -p 'SSH Session Name: ' sessionname
printf '\n'
read -p 'IP Address: ' IP
printf '\n'
read -p 'Login user: ' user
printf '\n'

### Set your environment here

# Private key file name
privatekeyname='private.pem'

# Root path
rootpath=$(pwd)

# Result sessions folder path
sessionspath=$rootpath'/sessions'

# Check known hosts certificate
checkknownhosts=false

###
if [ $checkknownhosts == false ]; then
  knownhostsstring="-o StrictHostKeyChecking=no" 
else
  knownhostsstring=""
fi

if [ ! -d $sessionspath ]; then
  mkdir $sessionspath
fi

privatekey=$rootpath'/'$privatekeyname
chmod 600 $privatekey
sessionfile=$sessionspath'/'$sessionname'.sh'
if [ -f $sessionfile ]; then
  rm $sessionfile
fi
touch $sessionfile
echo '#!/bin/bash' | tee $sessionfile
echo "ssh $knownhostsstring -i $privatekey $user@$IP" | tee -a $sessionfile
chmod +x $sessionfile
