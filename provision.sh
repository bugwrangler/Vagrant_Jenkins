# Bugwrangler Easy Jenkins box  

echo "-------- PROVISIONING JAVA ------------"

if [ ! -f /usr/lib/jvm/java-8-oracle/bin/java ]; 
then
    echo "-------- PROVISIONING JAVA ------------"
	echo "---------------------------------------"

	echo debconf shared/accepted-oracle-license-v1-1 select true | \
	  debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | \
	  debconf-set-selections

	## Install java 1.7
	## See http://www.webupd8.org/2012/06/how-to-install-oracle-java-7-in-debian.html
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
	apt-get update
	apt-get -y install oracle-java8-installer
else
	echo "CHECK - Java already installed"
fi

if [ ! -f /etc/init.d/jenkins ]; 
then
	echo "-------- PROVISIONING JENKINS ------------"
	echo "------------------------------------------"


	## Install Jenkins
	#
	# URL: http://localhost:6060
	# Home: /var/lib/jenkins
	# Start/Stop: /etc/init.d/jenkins
	# Config: /etc/default/jenkins
	# Jenkins log: /var/log/jenkins/jenkins.log
	wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
	apt-get update
	apt-get -y install jenkins

	# Move Jenkins to port 6060
	sed -i 's/8080/6060/g' /etc/default/jenkins
	/etc/init.d/jenkins restart
else
	echo "CHECK - Jenkins already installed"
fi

### Everything below this point is not stricly needed for Jenkins to work

echo "-------- PROVISIONING DONE ------------"
echo "-- Jenkins: http://localhost:6060      "
echo "---------------------------------------"


