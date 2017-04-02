OS: Ubuntu 14.04 64bit

Hadoop will be run on a single-node cluster in a pseudo-distributed mode
It includes Hadoop Common, HDFS, YARN, MapReduce.
------------

Install prerequest for ruby
```
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
# install vim, it's my preference
sudo apt-get install vim
```

Install ruby

```
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.4.0
rbenv global 2.4.0
ruby -v
```

Install brew
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
PATH="$HOME/.linuxbrew/bin:$PATH"

echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >>~/.bash_profile
```

---------

Check if java installed:
`java -version`

If not, install java 8:
```
sudo apt-get update
sudo apt-get install default-jre
sudo apt-get install default-jdk

# optional to install Oracle JDK
# sudo apt-get install python-software-properties
# sudo add-apt-repository ppa:webupd8team/java
# sudo apt-get install oracle-java8-installer

# setting the JAVA_HOME environment variable
sudo update-alternatives --config java
# sudo update-alternatives --config javac

vim ~/.bashrc
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
suorce ~/.bashrc

# then save the file
# test

echo $JAVA_HOME
java -version
$JAVA_HOME/bin/java -version
```

Use brew install wget:

`brew install wget`

create a hadoop user for accessing HDFS and MapReduce:
```
sudo useradd -m hadoop -s /bin/bash
sudo passwd *****
```

config SSH:
```
sudo apt-get install openssh-server
sudo su hadoop
# generate ssh key
ssh-keygen -t rsa -P ""
## Copy id_rsa.pub to authorized keys from hadoop
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
```

disable IPv6

```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

Use wget download hadoop:
```
wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
wget https://dist.apache.org/repos/dist/release/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz.mds
```

output mds number:
`shasum -a 256 hadoop-2.7.3.tar.gz`
compare with:
`cat hadoop-2.7.3.tar.gz.mds`
 to make sure they are same

```
tar -xzvf hadoop-2.7.3.tar.gz
sudo mv hadoop-2.7.3 /usr/local/hadoop
```

-------

Configure Hadoop to run as pseudo-distributed

check default java path:
`readlink -f /usr/bin/java | sed "s:bin/java::"`

`sudo vim /usr/local/hadoop/etc/hadoop/hadoop-env.sh` then add `export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/`


`core-site.xml` and `hdfs-site.xml` at `/hadoop/etc/hadoop` are two main configuration file

```
sudo vim core-site.xml

## Paste the content below
<configuration>
    <property>
         <name>hadoop.tmp.dir</name>
         <value>file:/usr/local/hadoop/tmp</value>
         <description>Abase for other temporary directories.</description>
    </property>
    <property>
         <name>fs.defaultFS</name>
         <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

```
sudo vim hdfs-site.xml

<configuration>
    <property>
         <name>dfs.replication</name>
         <value>1</value>
    </property>
    <property>
         <name>dfs.namenode.name.dir</name>
         <value>file:/usr/local/hadoop/tmp/dfs/name</value>
    </property>
    <property>
         <name>dfs.datanode.data.dir</name>
         <value>file:/usr/local/hadoop/tmp/dfs/data</value>
    </property>
</configuration>
```

Format namenode:
`./bin/hdfs namenode -format`
the output should be "successfully formatted" and "Exitting with status 0"

start daemons of namenode and datanode:
`./sbin/start-dfs.sh`

start mapreduce daemons:
`./sbin/start-yarn.sh`

--------------
YARN

```
sudo vim ./etc/hadoop/mapred-site.xml

# paste the content below
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

```
sudo vim ./etc/hadoop/yarn-site.xml

# paste the content below

<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
</configuration>

```

stop yarn:
```
./sbin/stop-yarn.sh
./sbin/mr-jobhistory-daemon.sh stop historyserver
```

add path environment variable:
```
vim ~/.bashrc
export PATH=$PATH:/usr/local/hadoop/sbin:/usr/local/hadoop/bin
source ~/.bashrc
```


-------
Reference:

* https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-16-04
* http://www.powerxing.com/install-hadoop/
