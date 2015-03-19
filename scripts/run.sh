#!/bin/bash
sleep 10
if env | grep -q "RIAK_JOINING_IP"; then
  # Join node to the cluster
  (sleep 5;riak-admin cluster join "riak@${RIAK_JOINING_IP}" > /dev/null 2>&1 && echo -e "Node Joined The Cluster") &

  # Are we the last node to join?
  (sleep 8; if riak-admin member-status | egrep "joining|valid" | wc -l | grep -q "${RIAK_CLUSTER_SIZE}"; then
    riak-admin cluster plan > /dev/null 2>&1 && riak-admin cluster commit > /dev/null 2>&1 && echo -e "\nCommiting The Changes..."
  fi) &
fi

