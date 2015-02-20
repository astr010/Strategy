#!/bin/bash

#######################################################################
# Global Variables #
##########################
long='============================================================================================================================='
medium='====================================================================================='
file="/tmp/robots.txt"
file2="/tmp/robots2.txt"

#################################
# End of Global Variables #
########################################################################################################################









#######################################################################
# function f_recondomain #
##########################
f_recondomain(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 1 running OSINT Web Domain "
echo $long
echo -n "Enter a domain: "
read domain


# Check for no reponse
if [ -z domain ]; then
	echo
	echo "You did not enter a domain."
	exit
fi

echo
echo
echo "Ready to run OSINT on $domain? "
read -p "Press <enter> to continue."
echo "Running $domain against the following databases. "
echo $long
firefox &
sleep 4
echo "www.manta.com"
firefox -new-tab https://www.google.com/?gws_rd=ssl#q=$domain+site:manta.com
echo "www.urlvoid.com"
sleep 3
firefox -new-tab http://www.urlvoid.com/scan/$domain/ &
sleep 3
echo "www.xssed.com"
firefox -new-tab http://www.xssed.com/search?key=$domain &
sleep 3
echo "www.archive.org"
firefox -new-tab http://web.archive.org/web/*/$domain &
sleep 3
echo "www.netcraft.com"
firefox -new-tab http://toolbar.netcraft.com/site_report?url=$domain &
sleep 2
echo "www.intodns.com"
firefox -new-tab http://www.intodns.com/$domain &
sleep 2
echo "whois.domaintools.com"
firefox -new-tab http://whois.domaintools.com/$domain &


read -p "Press <enter> to quit: "

}
#################################
# End of function f_recondomain #
######################################################################################################################









#######################################################################
# function f_robots #
#####################
f_robots(){
clear

rm -f $file  2>/dev/null
rm -f $file2 2>/dev/null

clear
echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 2 Robots.txt"
echo $long
echo
echo "Usage: example.com" 
echo "Do not use: www.example.com"
echo
echo -n "Enter a domain: "
read domain

# Check for no response
if [ -z $domain ]; then
    echo
    echo "You did not enter a domain."
    exit
fi

wget -O /tmp/robots.txt http://$domain/robots.txt 2>/dev/null &
sleep 5

#clean up robots.txt
rm -f /tmp/robots2.txt
sleep 1
cat "/tmp/robots.txt" | grep 'Disallow' | cut -d ' ' -f2 > "/tmp/robots2.txt" &

firefox &
sleep 5
for i in `cat $file2`;do firefox -new-tab http://$domain$i; sleep 5; done 
#for i in `cat $file2`;do echo $i;done

}
###########################
# End of function f_robots#
########################################################################################################################









#######################################################################
# function f_subdomain#
#######################
f_subdomain(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 3 finding subdomains"
echo $long

echo -n "Enter a domain: "
read domain

# Check for no reponse
if [ -z domain ]; then
	echo
	echo "You did not enter a domain."
	exit
fi

echo "1. Running blind crawl on: $domain "
perl /home/strategicsec/toolz/blindcrawl.pl -d $domain &&
echo $long
read -p "Press <enter> to continue with fierce or ctrl-z to quit"
echo "2. Running fierce on: $domain "
perl /home/strategicsec/toolz/fierce2/fierce -dns $domain --template /home/strategicsec/toolz/fierce2/tt &
}
#################################
# End of function f_subdomain #
########################################################################################################################









#######################################################################
# function f_people #
#####################
f_people(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 4 running OSINT on a person of interest"
echo $long
echo -n "Enter your target's First name:"
read fname

if [ -z $fname ]; then
	echo
	echo "You did not enter a firt name."
	exit
fi

echo 
echo -n "Enter your target's Last name:"
read lname

if [ -z $lname ]; then
	echo
	echo "You did not enter a last name."
	exit
fi

echo
echo "Ready to run OSINT on $fname $lname."
echo
read -p "Press <enter> to continue."
echo "Running $fname $lname against the following databases"
firefox &
sleep 4
echo "www.411.com"
firefox -new-tab http://www.411.com/name/$fname-$lname/ &
sleep 3
echo "www.cvgadget"
firefox -new-tab http://www.cvgadget.com/person/$fname/$lname &
sleep 3
echo "www.pipl.com"
firefox -new-tab https://pipl.com/search/?q=$fname+$lname &
sleep 3
echo "www.zabasearch.com"
firefox -new-tab http://www.zabasearch.com/people/$fname+$lname/ &
}
############################
# End of function f_people #
########################################################################################################################









#######################################################################
# function f_lbd #
##################
f_lbd(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 5 Load Balancer Detection"
echo $long
echo
echo
echo "Usage: example.com"
echo "Do not use: www.example.com"
echo
echo -n "Enter a domain: "
read domain

# Check for no response
if [ -z $domain ]; then
    echo
    echo "You did not enter a domain."
    exit
fi

echo
echo "Running halberd on:$domain "
halberd $domain -v &&

echo "Running lbd on:$domain "
/bin/bash /home/strategicsec/toolz/lbd-0.1.sh $domain
}
#########################
# End of function f_lbd #
########################################################################################################################









#######################################################################
# function f_ipsd#
#################
f_ipsd(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 6 Intrusion Prevention Detection "
echo $long
echo
echo
echo "Usage: example.com"
echo "Do not use: www.example.com"
echo
echo -n "Enter a domain: "
read domain

# Check for no response
if [ -z $domain ]; then
    echo
    echo "You did not enter a domain."
    exit
fi

echo ##################################
echo # Intrusion Prevention Detection #
echo ##################################
echo 
echo
echo "Starting osstmm on: $domain over standard HTTP"
echo $long
echo
echo
osstmm-afd -P HTTP -t $domain -v &&
echo
echo
echo "This scan has completed."
}
#########################
# End of function f_lbd #
########################################################################################################################









#######################################################################
# function f_ipsd_tls#
######################
f_ipsd_tls(){
clear

echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 7 Intrusion Prevention Detection over TLS "
echo $long
echo
echo
echo "Usage: example.com"
echo "Do not use: www.example.com"
echo
echo -n "Enter a domain: "
read domain

# Check for no response
if [ -z $domain ]; then
    echo
    echo "You did not enter a domain."
    exit
fi



read -p "Press <enter> to run OSSTMM over SSL/TLS or press ctr-z to cancel"
echo
echo
echo
echo $long
# Overwriting ssl_proxy.sh with our $domain variable
echo -e "#!/bin/bash \n \nopenssl s_client -quiet -connect $domain:443 2>/dev/null" > /home/strategicsec/toolz/ssl_proxy.sh &
sleep 2
echo
echo
echo $long
# Displaying xinetd status on stdout
service xinetd status & 
sleep 5
echo
echo
echo
echo "Running OSSTMM over TLS on 127.0.0.1 TCP Port 8888"
echo $long
osstmm-afd -P HTTP -t 127.0.0.1 -p 8888 -v &&
sleep 5

# Restoring ssl_proxy.sh with its orginal vaule www.strategicsec.com
echo -e "#!/bin/bash \n \nopenssl s_client -quiet -connect www.strategicsec.com:443 2>/dev/null >" > /home/strategicsec/toolz/ssl_proxy.sh
}
#############################
# End of function f_lbd_tls #
########################################################################################################################










#######################################################################
# function f_list_scan #
########################
f_list_scan(){
clear


echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo " Option 8 List Scan and CNAME query"
echo $long
echo
echo "Usage: 192.168.1.1/24"
echo "Enter your IP range in CIDR formation"
read ip

# Check for no response
if [ -z $ip ]; then
    echo
    echo "You did not enter a IP."
    exit
fi

echo
read -p "Press <enter> to run a list scan on $ip or press ctrl-z to cancel"
echo
echo
sudo nmap -sL $ip &&

sleep 5
echo $long
read -p "Press <enter> to continue and run a CNAME query on $ip or press ctrl-z to cancel"
echo
echo
sudo nmap -p 443,444,8443,8080,8088 --script=ssl-cert --open $ip 
}
###############################
# End of function f_list_scan #
########################################################################################################################









#######################################################################
# Main Menu #
#############
f_main(){
clear


echo "Joe McCray's Pentester Candidate Program "
echo " Week 3 - Linux and Linux shell scripting"
echo " by Nick Sanzotta"
echo $long
echo "1.OSINT Web Domain"
echo "2.Domain's robots.txt"
echo "3.Find subdomains"
echo "4.OSINT People"
echo "5.Load Balancer Detection"
echo "6.IPS Dectection"
echo "7.IPS Dectection over TLS"
echo "8.List Scan & CNAME query"
echo $long
echo
echo -n "Enter your Choice: "
echo
read choice


echo $choice

case $choice in
    1) f_recondomain;;
    2) f_robots;;
    3) f_subdomain;;
    4) f_people;;
    5) f_lbd;;
    6) f_ipsd;;
    7) f_ipsd_tls;;
    8) f_list_scan;;
    *) echo; echo "Invalid choice"; echo

esac
}

while true; do f_main; done

###################
# End of Main Menu#
########################################################################################################################










