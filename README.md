# Movie_Recommendation

*******************************

This folder contains my Big Data Analytics Java code

Use <b>Ambari</b> to install Hadoop on Linux Cent OS 7. http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.2.1/bk_Installing_HDP_AMB/bk_Installing_HDP_AMB-20151109.pdf

HDFS Cheat Sheet https://blog.matthewrathbone.com/img/hdfs-cheatsheet.pdf

Useful command: `hadoop fs -help`
`hadoop fs -copyFromLocal movie.csv`
`hadoop fs -ls`
`hdfs fsck -blocks -locations -racks  -files /user/tbvme/movie.csv`
`hadoop fs -setrep 6 movie.csv`

Creating Pig scripts to store data: https://hortonworks.com/hadoop-tutorial/how-to-use-basic-pig-commands/

Use oozie to submit map reduce job: `oozie job -oozie http://ip_address:port/oozie -config examples/apps/map-reduce/job.properties -run`

check job status `oozie job -oozie http://ip_address:port/oozie -info job_id`
Oozie is a Java Web application used to schedule Apache Hadoop jobs, is integrated with the rest of the Hadoop stack. It can execute Hadoop jobs out of the box such as Java, MapReduce, Streaming MapReduce, Pig, Hive, Sqoop and Distcp. It can execute system specific jobs such as Java programs and
shell scripts.

Running Sqoop import using Oozie Workflow in Hue 
`import --connect jdbc:mysql://ip_address:port/sqoopex --username sqoopuser --password password --table widgets --target-dir hdfs:///user/tbvme/widgets_import`