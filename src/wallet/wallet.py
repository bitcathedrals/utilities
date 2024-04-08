import toml
import sys
import os
from subprocess import run

def process_section(parse, section):
    for variable,value in parse[section].items():
        os.environ[variable] = value

def exec():
    file = os.environ['HOME'] + "/.wallet.toml"  
    parse = toml.load(file)   
    
    sections = sys.argv[1].split(",")

    for sec in sections:
        process_section(parse, sec)

    launch = sys.argv[2:]

    if len(launch) < 1:
        print("wallet.py: no launch arguments provided")
        sys.exit(1)

    status = run(launch)

    sys.exit(status.returncode)

if __name__ == "__main__":
    exec()


