#!/bin/bash
set -e

IN_TREE_VLT=$(realpath ${PWD}/submodules/verilator)

if [[ -n ${VERILATOR_ROOT} ]]; then
    USER_VLT=$(realpath ${VERILATOR_ROOT})

    if [[ ${IN_TREE_VLT} != ${USER_VLT} ]]; then
        SUBMODULES=$(ls -d submodules/* | grep -v verilator)
    fi
fi

git submodule update --init --recursive --remote ${SUBMODULES}
