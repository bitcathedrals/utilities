import sys

from toml import loads as tload, dumps as tdump
from json import loads as jload, dumps as jdump
from yaml import safe_load as yload, dump as ydump

from collections import namedtuple

format_table = {
    'json': True,
    'toml': True,
    'yaml': True
}

data = namedtuple('data',
                  ['format',
                   'data'])

def convert(data_in, out_format):
    intermediate = None

    if data_in.format == "json":
        intermediate = jload(data_in.data)
    elif data_in.format == "toml":
        intermediate = tload(data_in.data)
    elif data_in.format == "yaml":
        intermediate = yload(data_in.data)

    if out_format == 'json':
        return jdump(intermediate)
    elif out_format == 'toml':
        return tdump(intermediate)
    elif out_format == 'yaml':
        return ydump(intermediate)

    return None

if __name__ == '__main__':
    in_format = sys.argv[1]
    out_format = sys.argv[2]

    if in_format not in format_table:
        print('in format: arg(1)', sys.stderr)

    if out_format not in format_table:
        print('out format: arg(2)', sys.stderr)

    print(convert(data(format=in_format,
                       data=sys.stdin.read().rstrip()),
                  out_format))
