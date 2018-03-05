#!/bin/bash

mkdir -p keys/{web,worker}

for output in web/tsa_host_key web/session_signing_key worker/worker_key
do
    ssh-keygen -t rsa -f ./keys/$output -N ''
done

cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp ./keys/web/tsa_host_key.pub ./keys/worker/
