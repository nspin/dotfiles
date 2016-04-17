#!/usr/bin/env python3

import os
import sys
import random
import subprocess
from enum import Enum

env_var = 'TMEX_POSITION'

usage = (
    'usage: tmex [(-(u|d|l|r) <size>[%]] COMMAND\n'
    'If position is absent, tmex checks in ${}, which, if present, must be correctly formatted.\n'
).format(env_var)

sides = Enum('side', ['UP', 'DOWN', 'LEFT', 'RIGHT'])

side_parse = { '-u': sides.UP
             , '-d': sides.DOWN
             , '-l': sides.LEFT
             , '-r': sides.RIGHT
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
        env = sys.getenv(env_var)
        if env is None:
            return pos
        else:
            envs = ' '.split(env)
            if len(envs) == 2:
                pos = parse_pos(envs[0], envs[2])
                if pos is not None:
                    args.update(pos)
                    return pos
    elif len(sys.argv) == 4:
        args = { 'cmd': sys.argv[3] }
        pos = parse_pos(sys.argv[1], sys.argv[2])
        if pos is not None:
            args.update(pos)
            return args

def tmex(cmd, side=sides.UP, size=40, percent=True):
    suffix = str(random.randint(0, 999999))
    fifo_in  = 'tmex-in-'  + suffix
    fifo_out = 'tmex-out-' + suffix
    fifo_ret = 'tmex-ret-' + suffix
    os.mkfifo(fifo_in)
    os.mkfifo(fifo_out)
    os.mkfifo(fifo_ret)
    new_cmd = '{} < {} > {}; echo $? > {}'.format(cmd, fifo_in, fifo_out, fifo_ret)
    subprocess.call(['echo', 'hi'])
    os.remove(fifo_in)
    os.remove(fifo_out)
    os.remove(fifo_ret)

def test():
    tmex('echo ho')

def main():
    args = parse_args()
    if args is None:
        sys.stderr.write(usage)
        sys.exit(1)
    else:
        tmex(**args)

if __name__ == '__main__':
    # main()
    test()
