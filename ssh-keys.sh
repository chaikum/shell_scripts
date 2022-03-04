#! /bin/bash
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
cd .ssh
echo "***********************************"
echo "****** copy the public  key *******"
echo "***********************************"
public_key=$(cat id_rsa.pub)
echo $public_key
echo "***********************************"
echo "****** paste the key  in git ******"
echo "***********************************"
