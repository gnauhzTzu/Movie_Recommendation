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