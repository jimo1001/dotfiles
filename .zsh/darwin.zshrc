# -*- coding: utf-8; mode: shell-script; -*-

## JAVA for MacOS
if [ `uname` = 'Darwin' ]; then
    JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
    export JAVA_HOME
    export PATH=${JAVA_HOME}/bin:$PATH
    export TOMCAT_HOME=/usr/local/tomcat6
    export CATALINA_HOME=/usr/local/tomcat6
    export CLASSPATH=$CLASSPATH:$CATALINA_HOME/lib
fi
