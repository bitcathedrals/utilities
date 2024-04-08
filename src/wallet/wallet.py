import sys
import os
import subprocess

import toml

def process_section(parse, section):
    for variable,value in parse[section].items():
        os.environ[variable] = value

def exec():
    file = os.environ['HOME'] + "wallet.toml" 

    parse=None

    with open(file, "r") as toml_file:
        contents = toml_file.read()
        print(f'wallet.py: parsing toml file: {toml_file} contents: {contents}', file=sys.stderr)
        parse = toml.loads(contents)

    if not parse:
        print(f'wallet.py: no toml file found: %s or it\'s empty' % file, file=sys.stderr)
        sys.exit(1)

    sections = sys.argv[1].split(",")

    for sec in sections:
        process_section(parse, sec)

    launch = sys.argv[2:]

    if len(launch) < 1:
        print("wallet.py: no launch arguments provided")
        sys.exit(1)

    status = subprocess.call(launch)

    sys.exit(status.returncode)

if __name__ == "__main__":
    exec()


