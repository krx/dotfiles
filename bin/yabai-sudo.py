#!/usr/bin/env python3
from pathlib import Path
import shutil
from hashlib import sha256
from getpass import getuser
import os

SUDO = Path('/etc/sudoers.d/yabai')
YABAI = Path(shutil.which('yabai'))
USER = os.getenv('SUDO_USER')


def main():
    if os.getuid() != 0:
        print('must be run as root')
        return 1

    h = sha256(YABAI.read_bytes()).hexdigest()
    SUDO.write_text(f'{USER} ALL = (root) NOPASSWD: sha256:{h} {YABAI} --load-sa')
    SUDO.chmod(0o440)
    # os.system('yabai --install-sa')
    print('Done!')

if __name__ == '__main__':
    exit(main())
