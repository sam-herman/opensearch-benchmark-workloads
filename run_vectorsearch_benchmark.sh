# OpenSearch Cluster End point url with hostname and port
export ENDPOINT=localhost:9200
# Absolute file path of Workload param file
export PARAMS_FILE=vectorsearch/params/lucene-sift-128-l2.json
#export PARAMS_FILE=vectorsearch/params/jvector-sift-128-l2.json

opensearch-benchmark execute-test \
    --target-hosts $ENDPOINT \
    --workload vectorsearch \
    --workload-params ${PARAMS_FILE} \
    --pipeline benchmark-only \
    --kill-running-processes