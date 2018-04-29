#!python3

import os
import sys


builder_py = os.path.abspath(__file__)
base_dir = os.path.dirname(builder_py)
ignore = [builder_py]

github_user = 'IanWernecke'
github_repo = 'ccturtle'
github_branch = 'master'

pc_root = 'turtle'

def main():
    """
    Build a setup script to be run by the computer.

    :return: a system exit code.
    """

    lines = ['shell.run("rm {}")'.format(pc_root)]
    # lines = ['mkdir {}'.format(pc_root_dir)]
    for walked_dir, sub_dirs, sub_files in os.walk(base_dir):

        if '.git' in walked_dir:
            continue

        # create the directory being walked
        rel_dir = os.path.relpath(walked_dir, base_dir)
        lines.append('shell.run("mkdir {}/{}")'.format(pc_root, rel_dir))

        # walk each file in the directory
        for sub_file in sub_files:

            # ignore garbage files
            if sub_file in ignore:
                continue

            abs_file = os.path.join(rel_dir, sub_file)

            # find the relative path to the directory
            rel_file = os.path.relpath(abs_file, base_dir)
            lines.append('shell.run("/openp/github get {github_user}/{github_repo}/{github_branch}/{github_path} {pc_root}/{pc_path}")'.format(
                github_user=github_user,
                github_repo=github_repo,
                github_branch=github_branch,
                github_path=rel_file,
                pc_root=pc_root,
                pc_path=rel_file
            ))

    # testing; write out the setup so far
    output = '\n'.join(lines)
    with open('setup', 'wb') as f:
        f.write(output.encode('utf-8'))

    return 0


if __name__ == '__main__':
    sys.exit(main())

