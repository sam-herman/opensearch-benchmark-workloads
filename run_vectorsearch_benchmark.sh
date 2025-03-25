#!/bin/bash
# OpenSearch Cluster End point url with hostname and port
export ENDPOINT=localhost:9200
if [ $# -eq 0 ]; then
  echo "Error: Please specify engine type: 'lucene' or 'jvector'"
  echo "Usage: $0 [lucene|jvector]"
  exit 1
fi

engine_type=$1
if [ "$engine_type" != "lucene" ] && [ "$engine_type" != "jvector" ]; then
  echo "Error: Invalid engine type. Must be 'lucene' or 'jvector'"
  echo "Usage: $0 [lucene|jvector]"
  exit 1
fi

export LOCAL_WORKLOADS_PATH=/Users/sam.herman/projects/opensearch-benchmark-workloads

# Absolute file path of Workload param file
if [ "$engine_type" == "lucene" ]; then
  export PARAMS_FILE=$LOCAL_WORKLOADS_PATH/vectorsearch/params/lucene-sift-128-l2.json
  else
  export PARAMS_FILE=$LOCAL_WORKLOADS_PATH/vectorsearch/params/jvector-sift-128-l2.json
fi

export WORKLOAD_PATH=$LOCAL_WORKLOADS_PATH/vectorsearch
#export WORKLOAD_PATH=$LOCAL_WORKLOADS_PATH/treccovid_semantic_search

opensearch-benchmark execute-test \
    --target-hosts $ENDPOINT \
    --workload-params ${PARAMS_FILE} \
    --workload-path $WORKLOAD_PATH \
    --pipeline benchmark-only \
    --kill-running-processes