#!/bin/bash


if env | grep -q "FIRST_RIAK_NODE"; then
  # Join node to the cluster
  (sleep 5;riak-admin cluster join "riak@${FIRST_RIAK_NODE}" > /dev/null 2>&1) &

  # Are we the last node to join?
  (sleep 8; if riak-admin member-status | egrep "joining|valid" | wc -l | grep -q "${RIAK_CLUSTER_SIZE}"; then
    riak-admin cluster plan > /dev/null 2>&1 && riak-admin cluster commit > /dev/null 2>&1
  fi) &
fi

useradd -m riakcl
echo "riakcl:riakcl" | chpasswd 
