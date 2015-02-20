#!/usr/bin/python
import subprocess
import os
import sys
import time
import urllib, urllib2
import webbrowser


#######################
# Global Variables
#######################

#######################
# End of Global Variables
#######################








#######################
# Functions
#######################



	#######################
	# OSINT Domain function
	#######################
def domain():
	
	domain = raw_input("Please enter a domain: ")
	print "Scanning online databases for: "+domain
	
	webbrowser.open('http://'+domain)
	time.sleep(3)
	print "www.manta.com"
	webbrowser.open_new_tab('https://www.google.com/?gws_rd=ssl#q='+domain+'+site:manta.com')
	print "www.urlvoid.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://www.urlvoid.com/scan/'+domain+'/')
	print "www.xssed.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://www.xssed.com/search?key='+domain)
	print "www.archive.org"
	time.sleep(2)
	webbrowser.open_new_tab('http://web.archive.org/web/*/'+domain)
	print "www.netcraft.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://toolbar.netcraft.com/site_report?url='+domain)
	print "www.intodns.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://www.intodns.com/'+domain)
	print "www.dnssniffer.com"
	time.sleep(2)
	webbrowser.open_new_tab('https://www.dnssniffer.com/en/dnsreport/'+domain)
	print "whois.domaintools.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://whois.domaintools.com/'+domain)
	print "Scans have completed"
	time.sleep(5)

	#######################
	# Robots.txt function
	#######################
def robots():
	domain = raw_input("Enter a domain: ")
	time.sleep(3)
	print "Scanning for robots.txt on: "+domain
	time.sleep(2)
	urllib.urlretrieve("http://"+domain+"/robots.txt" , "/tmp/robots.txt")
	time.sleep(2)
	webbrowser.open('http://'+domain, new=1, autoraise=True)
	time.sleep(5)
	
	for line in open("/tmp/robots.txt"):
		if "Disallow" in line:
			robots = line.split('/')[1]
			webbrowser.open_new_tab('http://'+domain+'/'+robots) 
			print robots,


	#######################
	# Subdomains function
	#######################
def subdomains():
	subdomain = raw_input("Please enter the domain: ")
	
	print "Scanning DNS databases for: "+subdomain
	time.sleep(3)
	print "Running blind crawl on:"+subdomain
	os.system('/home/strategicsec/toolz/blindcrawl.pl -d'+subdomain)
	raw_input("Press <enter> to continue with fierce or ctrl-z to quit:")
	time.sleep(3)
	os.system('perl /home/strategicsec/toolz/fierce2/fierce -dns '+subdomain+' --template /home/strategicsec/toolz/fierce2/tt')
	print "Scans have completed"
	time.sleep(5)

    #######################
	# People function
	#######################
def people():
	firstname, lastname = raw_input("Please enter the name of a person of interest(ex:John Doe):").split(' ')
	
	print "Scanning online databases for: "+firstname, lastname
	webbrowser.open('http:///www.google.com/')
	time.sleep(3)
	print "www.google.com"
	webbrowser.open('http:///www.google.com/?gws_rd=ssl#q='+firstname+'+'+lastname)
	time.sleep(2)
	print "www.411.com"
	webbrowser.open_new_tab('http://www.411.com/name/'+firstname+'-'+lastname)
	time.sleep(2)
	print "www.cvgadget"
	webbrowser.open_new_tab('http://www.cvgadget.com/person/'+firstname+'/'+lastname)
	time.sleep(2)
	print "www.pipl.com"
	webbrowser.open_new_tab('https://pipl.com/search/?q='+firstname+'+'+lastname)
	time.sleep(2)
	print "www.zabasearch.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://www.zabasearch.com/people/'+firstname+'+'+lastname)
	time.sleep(2)
	print "www.spokeo.com"
	webbrowser.open_new_tab('http://www.spokeo.com/'+firstname+'-'+lastname)
	print "www.linkedin.com"
	time.sleep(2)
	webbrowser.open_new_tab('http://www.linkedin.com/pub/dir/'+firstname+'/'+lastname)
	print "www.twitter.com"
	time.sleep(2)
	webbrowser.open_new_tab('https://twitter.com/search?q='+firstname+'%20'+lastname+'&src=typd&mode=users')
	print "www.facebook.com"
	time.sleep(2)
	webbrowser.open_new_tab('www.facebook.com/public/'+firstname+'-'+lastname)
	print "Scans have completed"

	time.sleep(5)


	########################
	# Load Balancer function
	########################
def lbd():
	domain = raw_input("Please enter a Domain: ")
	time.sleep(2)
	print "\nFirst Scan - Running Halberd on domain: "+domain
	os.system('halberd '+domain+' -v')
	print "\n Halberd scan has completed"
	time.sleep(2)
	raw_input("\nSecond Scan - Running LBD, Press <enter> to continue or press ctrl-z to QUIT:")
	os.system('/bin/bash /home/strategicsec/toolz/lbd-0.1.sh '+domain)
	print "Scans have completed"
	time.sleep(5)

		

	############################
	# IPS Detection function
	############################
def ipsd():
	domain = raw_input("Please enter a Domain: ")
	time.sleep(2)
	print "\nStarting Osstmm over standard HTTP on: "+domain
	os.system('osstmm-afd -P HTTP -t '+domain+' -v')
	print "\n Osstmm scan has completed"
	time.sleep(5)

	############################
	# IPS/TLS function
	############################
def ipsdtls():
	domain = raw_input("Please enter a Domain: ")
	time.sleep(2)
	print "\nStarting Osstmm over SSL on: "+domain
	f = open('/home/strategicsec/toolz/ssl_proxy.sh' ,'w')
	f.write('#!/bin/bash \n \nopenssl s_client -quiet -connect '+domain+':443\n')
	f.close()
	os.system('service xinetd status')
	time.sleep(5)
	os.system('osstmm-afd -P HTTP -t 127.0.0.1 -p 8888 -v')
	print "\n Osstmm scan has completed"
	f = open('/home/strategicsec/toolz/ssl_proxy.sh' , 'w')
	f.write('#!/bin/bash \n \nopenssl s_client -quiet -connect www.strategicsec.com:443\n')
	time.sleep(5)
	
	#######################
	# ListScan function
	#######################
def listscan():
	iprange = raw_input("Enter your IP range in CIDR formation: ")
	time.sleep(2)
	print "\nStarting nmap -sL on: "+iprange
	os.system('sudo nmap -sL '+iprange)
	print "\n Nmap -sL has completed"
	time.sleep(2)
	raw_input("\nPress <enter> to run a CNAME scan, or ctrl-z to QUIT:")
	os.system('sudo nmap -p 443,444,8443,8080,8088 --script=ssl-cert --open '+iprange)
	print "\n CNAME scan has completed"
	time.sleep(5)
	
	#######################
	# Clear Screen function
	#######################
def cls():
    os.system(['clear','cls'][os.name == 'nt'])

	#######################
	# Menu function
	#######################
def menu():
	cls()	
	print"""



 _____ _             _                   
/  ___| |           | |                  
\ `--.| |_ _ __ __ _| |_ ___  __ _ _   _ 
 `--. \ __| '__/ _` | __/ _ \/ _` | | | |
/\__/ / |_| | | (_| | ||  __/ (_| | |_| |
\____/ \__|_|  \__,_|\__\___|\__, |\__, |
                              __/ | __/ |
    A Simple Tool            |___/ |___/ 
=========================================
* Strategy v0.1 *
* by Nick Sanzotta *
* XploitInfinity-Research *




	"""
	print """
	1.OSINT Domain
	2.Robots.txt
	3.Subdomains
	4.OSINT People
	5.Halberd/LBD Scan
	6.OSSTMM  
	7.OSSTMM w/SSL 
	8.List/CNAME Scan
	9.QUIT!
		"""
	return input ("Choose your Option: ")
	

#######################
# Call Menu()
#######################
loop = 1
choice = 0
while loop == 1:
    choice = menu()
    if choice == 1:
        domain()
    elif choice == 2:
        robots()
    elif choice == 3:
        subdomains()
    elif choice == 4:
        people()
    elif choice == 5:
    	lbd()
    elif choice == 6:
    	ipsd()
    elif choice == 7:
    	ipsdtls()
    elif choice == 8:
    	listscan()
    elif choice == 9:
		print "Bye! " 
	 	sys.exit()
    elif choice != [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]:
		print "You entered a incorrect choice. "
		loop = 0

#######################
# 
#######################




	



