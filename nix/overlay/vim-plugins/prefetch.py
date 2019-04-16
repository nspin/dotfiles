import re
import json
import subprocess
from collections import OrderedDict

ignore_re = re.compile(r'#.*|\s*', re.DOTALL)
src_re = re.compile(r'(?P<url>.+/(?P<name>.+?)(.git)?)\s+(?P<rev>.+?)\s*')

srcs = OrderedDict()

with open('srcs.txt') as f:
    for line in f:
        if ignore_re.fullmatch(line) is None:
            m = src_re.fullmatch(line).groupdict()
            out = subprocess.check_output(['nix-prefetch-git', '--fetch-submodules', m['url'], m['rev']])
            src = json.loads(out)
            srcs[m['name']] = src

with open('srcs.json', 'w') as f:
    json.dump(srcs, f, indent=2)
