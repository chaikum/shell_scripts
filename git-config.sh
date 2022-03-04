#! /bin/bash
read -p "Enter your email : " email
read -p "Enter your name : " name
git config --global user.email $email
git config --global user.name $name
git config --list
