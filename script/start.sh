#!/bin/bash

# start services
/etc/init.d/ntpd start
/etc/init.d/cloudera-scm-server-db start
/etc/init.d/cloudera-scm-agent start
/etc/init.d/cloudera-scm-server start
