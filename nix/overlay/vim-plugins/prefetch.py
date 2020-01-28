import re
import json
import subprocess
from collections import OrderedDict
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument('-n', '--new', action='store_true')
args = parser.parse_args()

ignore_re = re.compile(r'#.*|\s*', re.DOTALL)
src_re = re.compile(r'(?P<url>.+/(?P<name>.+?)(.git)?)\s+(?P<rev>.+?)\s*')

if args.new:
    with open('srcs.json', 'r') as f:
        srcs = json.load(f, object_pairs_hook=OrderedDict)
else:
    srcs = OrderedDict()

have_urls = set()
for _, src in srcs.items():
    have_urls.add(src['url'])

with open('srcs.txt') as f:
    for line in f:
        if ignore_re.fullmatch(line) is None:
            m = src_re.fullmatch(line).groupdict()
            assert m is not None
            if m['url'] in have_urls:
                continue
            out = subprocess.check_output(['nix-prefetch-git', '--fetch-submodules', m['url'], m['rev']])
            src = json.loads(out)
            srcs[m['name']] = src

with open('srcs.json', 'w') as f:
    json.dump(srcs, f, indent=2)
