#!/usr/bin/env python3
#
# Copyright (C) 2016  Bjarte Johansen
# Copyright (C) 2016  Truls Pedersen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
"""
make_key_file

Usage:
  make_key_file [ FILE ]
"""
import json
from docopt import docopt

def main():

    columns = {}

    args = docopt(__doc__, version='0.1.0')

    with open(args['FILE']) if args['FILE'] else sys.stdin as f:
        for i_val, key_line in enumerate(f):
            column, key = key_line.split("\t")

            if not column in columns:
                columns[column] = {}

            columns[column][key.rstrip()] = i_val+1


        for col_num in sorted(columns):
            print(
                "keys_column_%s" % col_num,
                "=",
                json.dumps(columns[col_num])
            )

if __name__ == "__main__":
    main()
