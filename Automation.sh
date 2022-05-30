sudo apt update -y
sudo apt install apache2
sudo /etc/init.d/apache2 start
sudo systemctl apache2 enable
sudo service apache2 status

cd /var/log/apache2
for file in *.log
do
        storedir=shruti_httpd_logs$(date "+%d%m%y-%H%M%S")
        if [ -d ${storedir} ]
        then
                cp ${file} ${storedir}
                tar -cvf ${storedir}.tar ${storedir}
                mv ${storedir}.tar /root/Shruti/tmp/
        else
                mkdir ${storedir}
                cp ${file} ${storedir}
                tar -cvf ${storedir}.tar ${storedir}
                mv ${storedir}.tar /root/Shruti/tmp/
        fi
done

aws s3 cp /root/Shruti/tmp/${storedir}.tar s3://${storedir}.tar
