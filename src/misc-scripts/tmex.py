#!/usr/bin/env python3

import os
import sys
from enum import Enum

usage = (
    'usage: tmex [(-(u|d|l|r) <size>[%]] COMMAND\n'
    'If the first two arguments are absent, tmex checks in $TMEX_POS.\n'
)

sides = Enum('side', ['UP', 'DOWN', 'LEFT', 'RIGHT'])

side_parse = { '-u': 'UP'
             , '-d': 'DOWN'
             , '-l': 'LEFT'
             , '-r': 'RIGHT'
             }

def parse_pos(side, size):
    percent = size.endswith('%')
    try:
        return { 'side': side_parse[side]
               , 'size': int(size[:-1] if percent else size)
               , 'percent': percent
               }
    except (KeyError, ValueError):
        return None

def parse_args():
    if len(sys.argv) == 2:
        args = { 'cmd': sys.argv[1] }
        env = sys.getenv('TMEX_POS')
        if env is None:
            return pos
        else:
            envs = ' '.split(env)
            if len(envs) == 2:
                pos = parse_pos(envs[0], envs[2])
                if pos is not None:
                    args.update(pos)
                    return pos
            return None
    elif len(sys.argv) == 4:
        args = { 'cmd': sys.argv[3] }
        pos = parse_pos(sys.argv[1], sys.argv[2])
        if pos is None:
            return None
        else:
            args.update(pos)
            return args

def tmex(cmd, side=sides.UP, size=40, percent=True, stdin=None, stdout=None, stderr=None):
    print(cmd, side, size, percent, stdin, stdout, stderr)

def main():
    args = parse_args()
    if args is None:
        sys.stderr.write(usage)
        sys.exit(1)
    else:
        tmex(**args)

if __name__ == '__main__':
    main()
