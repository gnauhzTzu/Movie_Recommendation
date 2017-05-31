1. Run `hadoop version` to get version of hadoop on server
2. Download at https://spark.apache.org/downloads.html and select the corresponding version
3. On Ubuntu use `wget`

5. Every download can be run in standalone mode

6. Unzip - `tar -xzvf spark-*.tgz`

7. Python Shell: `bin/pyspark`

8. a test
run `bin/spark-shell`

```
val lines = sc.textFile("../../test/hellospark")
lines.count()
lines.first()
```

9. (option)
```
cd spark-1.6.2-bin-hadoop2.6/conf/
cp log4j.properties.template log4j.properties
vim log4j.properties
log4j.rootCategory=WARN, console
```

10. Start spark cluster and submit spark job
```
./sbin/start-master.sh
jps 
# will see Master and Jps there
./bin/spark-class org.apache.spark.deploy.worker.Worker spark://localhost.localdomain:7077

# found the localhost.localdomain at spark job ui localhost:8080

# submit job
./bin/spark-submit --master spark://localhost.localdomain:7077 --class WordCount  XXX/XXX/XXX.jar
```


11. To start spark with jupyter, run the following in a terminal
```shell
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=0.0.0.0 --port=8081 --no-browser" pyspark 
# in order to connnect with mysql db
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=0.0.0.0 --port=8081 --no-browser" pyspark --packages mysql:mysql-connector-java:5.1.38
# or better 
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=0.0.0.0 --port=8081 --no-browser" pyspark --jars mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar --driver-class-path mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar

```

12. To submit jobs with jdbc, run
```shell
spark-submit --jars mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar foo.py
```





