#!/bin/bash
set -o errexit    # Exit on error
set -o nounset    # Exit on unset variable
set -o pipefail   # Exit on failing pipe

if [ ${#} -ne 1 ]
then
    NAME=$(basename "${0}")
    echo "Usage: ${NAME} FILE"
    exit ${E_BADARGS}
fi

CURDIR=$(realpath "${0}")
CURDIR=$(dirname "${CURDIR}")

GRAMMAR="${CURDIR}/../res/nn_morf.cg"

mtag -wxml -nn < "${1}"				\
    | vislcg3 --codepage-all latin1		\
	      --codepage-input utf-8		\
	      --grammar "${GRAMMAR}"		\
	      --codepage-output utf-8		\
	      --no-pass-origin			\
	      --quiet				\
	      --show-end-tags 2>/dev/null	\
    | sed '/^\s*$/d'
