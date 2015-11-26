#!py
# This is awful, don't use this

from salt.utils.odict import OrderedDict
import os

def run():
    xfiles = []
    [list(map(xfiles.append, [(dir, fi) for fi in files])) for dir, _, files in os.walk('/usr/local/pyenv') if dir.endswith('/bin')]
    config = {}
    config['create symlinks'] = {
        'file.symlink': [
            {'force': True},
            {
                'names': [
                    OrderedDict([
                        (os.path.join('/usr/local/bin', file), [{'target': os.path.join(dir, file)}])
                    ]) for dir, file in xfiles
                ]
            },
        ]
    }
    return config
