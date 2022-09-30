#!/usr/bin/env bash

set -e

./docker/rebuild3.sh
./docker/up3.sh
./docker/test.suite.sh test_suite_idempotency.json
./docker/test.suite.sh test_suite_list_offsets.json
./docker/test.suite.sh test_suite_reads_writes.json
./docker/fetch.logs.sh
./docker/down3.sh

./docker/rebuild6.sh
./docker/up6.sh
./docker/test.suite.sh test_suite_tx_money.json
./docker/test.suite.sh test_suite_tx_reads_writes.json
./docker/test.suite.sh test_suite_tx_streaming.json
./docker/fetch.logs.sh
./docker/down6.sh

./docker/rebuild3.2.sh
./docker/up3.2.sh
# ./docker/test.test.sh suites/tests/tx_subscribe/redpanda_1.json
./docker/test.suite.sh test_suite_tx_subscribe.json
./docker/fetch.logs.sh
./docker/down6.2.sh

python3 harness/combine.results.py