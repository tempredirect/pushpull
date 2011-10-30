
GF_HOME=~/local/glassfish3-cluster/glassfish3
mvn clean package

if [ "$?" == "0" ] ; then
  $GF_HOME/bin/asadmin deploy --force=true --contextroot pusher-web --target cluster1 pusher-web/target/pusher-web.war
  $GF_HOME/bin/asadmin deploy --force=true --contextroot puller-web --target cluster1 puller-web/target/puller-web.war
fi
