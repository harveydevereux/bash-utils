# this should be added to crontab for a daily update
# for crontab the full path /user/sbin/ssmtp is needed
# replace user@email.com with the recipient address
dig +short myip.opendns.com @resolver1.opendns.com | /usr/sbin/ssmtp user@email.com
