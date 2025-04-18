#!/bin/bash

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILES="$LOGS_FOLDER/SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

R="\e[31m"
G=\e[32m"
N=\e[0m"
Y=\e[33"

CHECK_ROOT(){
  if [ $USERID -ne 0 ]
then
   echo -e "$R please run this script with root privilages $N" &>>$LOG_FILE
     exit 1
  fi
}
VALIDATE(){
if [ $1 -ne 0 ]
then
     echo -e "$2 is...$R SUCCESS $N" &>>$LOG_FILE
     exit 1
else
     echo -e "$2 is...$G FAILED $N" &>>$LOG_FILE
fi

}
CHECK_ROOT

dnf instal mysql-sever -y
VALIDATE $? "installing mysql server"

ststemctl enable mysqld
VALIDATE $? "started mySQL server"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? setting up root password"