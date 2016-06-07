#!/bin/bash
set -o errexit    # Exit on error
set -o nounset    # Exit on unset variable
set -o pipefail   # Exit on failing pipe

if [ $# -ne 1 ]
then
    NAME=$(basename "${0}")
    echo "Usage: ${NAME} FILE"
    exit $E_BADARGS
fi

CURDIR=$(realpath "${0}")
CURDIR=$(dirname "${CURDIR}")

GRAMMAR="${CURDIR}/../res/bm_morf-prestat.cg"
if [[ ! -f "${GRAMMAR}" ]]; then
    echo "Missing cg grammar file: ${GRAMMAR}" >&2
    exit 127
fi
"${CURDIR}/mtag" -wxml < "${1}"						\
    | vislcg3 --grammar "${GRAMMAR}"					\
	      --no-pass-origin						\
	      --quiet							\
	      --show-end-tags 2>/dev/null				\
    | "${CURDIR}/obt_stat"						\
    | sed '/^\s*$/d'
