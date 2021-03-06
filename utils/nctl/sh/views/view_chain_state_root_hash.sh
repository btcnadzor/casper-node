#!/usr/bin/env bash

unset BLOCK_HASH
unset NODE_ID

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
        block) BLOCK_HASH=${VALUE} ;;
        node) NODE_ID=${VALUE} ;;
        *)
    esac
done

NODE_ID=${NODE_ID:-"all"}
BLOCK_HASH=${BLOCK_HASH:-""}

# ----------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------

source $NCTL/sh/utils.sh
source $NCTL/sh/views/funcs.sh

if [ $NODE_ID = "all" ]; then
    for NODE_ID in $(seq 1 $(get_count_of_nodes))
    do
        render_chain_state_root_hash $NODE_ID $BLOCK_HASH
    done
else
    render_chain_state_root_hash $NODE_ID $BLOCK_HASH
fi
