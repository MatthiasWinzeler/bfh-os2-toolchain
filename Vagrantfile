# -*- mode: ruby -*-
# vi: set ft=ruby :
HERE = File.dirname(__FILE__)
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT

checkForPackage()
{
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1|grep "install ok installed")
echo Checking for $1: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "Package $1 not installed."
  retval=1
else
  echo "Package $1 is already installed."
  retval=0
fi


return $retval
}

echo I am provisioning...

package="libmagickcore-dev"
checkForPackage "$package"
retval=$?
if [ "$retval" == 1 ]
then
  apt-get -y install $package
fi

package="libmagickwand-dev"
checkForPackage "$package"
retval=$?
if [ "$retval" == 1 ]
then
  apt-get -y install $package
fi
  
package="mysql-server"
checkForPackage "$package"
retval=$?
if [ "$retval" == 1 ]
then
  dbpass="123qwe" 
  export dbpass
  export DEBIAN_FRONTEND=noninteractive
  echo mysql-server-5.1 mysql-server/root_password password $dbpass | debconf-set-selections
  echo mysql-server-5.1 mysql-server/root_password_again password $dbpass | debconf-set-selections
  apt-get -y install $package
fi

package="libmysqlclient-dev"
checkForPackage "$package"
retval=$?
if [ "$retval" == 1 ]
then
  apt-get -y install $package
fi

SCRIPT


$mysql = <<SCRIPT
echo Setting up mysql..

mysql -u root --password=123qwe <<EOFMYSQL
drop database if exists oss2_dev;
create database oss2_dev;
grant usage on *.* to developer@localhost identified by '123qwe';
grant all privileges on oss2_dev.* to developer@localhost;
EOFMYSQL

cd /vagrant

echo Finished setting up mysql

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box     = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.network :private_network, ip: "192.168.56.101"
  config.vm.hostname = "oss2.vm"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 81, host: 8081
  config.vm.network "forwarded_port", guest: 444, host: 8444

  config.vm.synced_folder "data/", "/opt/nginx/sites/oss2", owner: "nobody", group: "users"

  config.vm.provision :shell, :path => 'kitchen_renovator.sh'
  config.vm.provision :shell, :inline => $script
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["#{HERE}/cookbooks", "#{HERE}/site-cookbooks"]
    chef.add_recipe 'passenger_nginx'
    chef.add_recipe 'oss2::deploy'
    chef.json = { :passenger => { :nginx_prefix => '/opt/nginx' } }
  end
  config.vm.provision :shell, :inline => $mysql

end
