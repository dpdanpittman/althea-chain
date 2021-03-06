#!/bin/bash
# the script run inside the container for all-up-test.sh
NODES=$1
TEST_TYPE=$2
set -eux

bash /althea/tests/container-scripts/setup-validators.sh $NODES

bash /althea/tests/container-scripts/run-testnet.sh $NODES &

# deploy the ethereum contracts
DEPLOY_CONTRACTS=1 RUST_BACKTRACE=full RUST_LOG=INFO test-runner

bash /althea/tests/container-scripts/integration-tests.sh $NODES $TEST_TYPE