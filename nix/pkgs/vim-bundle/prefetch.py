import sys
import json
import subprocess

print('{ fetchgit }:')
print('')
print('{')
print('')

for line_ in sys.stdin:
    line = line_.strip()
    if not line or line.startswith('#'):
        continue
    url, rev = line.split()
    name = url.split('/')[-1]
    suffix = '.git'
    if name.endswith(suffix):
        name = name[-(len(suffix)):]
    out = subprocess.check_output(['nix-prefetch-git', '--fetch-submodules', url, rev])
    obj = json.loads(out)
    print(f'''  "{name}" = fetchgit {{
    url = "{url}";
    rev = "{obj['rev']}";
    sha256 = "{obj['sha256']}";
  }};
''')

print('}')
