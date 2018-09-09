#!python3


import os
import subprocess
import sys


# define some global variables
builder_py = os.path.abspath(__file__)
base_dir = os.path.dirname(builder_py)
setup_ignore = [
    builder_py,
    os.path.join(base_dir, 'README.md')
]

# github information
github_user = 'IanWernecke'
github_repo = 'ccturtle'
github_branch = 'master'

# the location to save the files on the pc
pc_root = 'turtle'
pc_setup = 'setup'

# protected turtle directories
turtle_sanitize = 'sanitize'
turtle_ignore = [
    'disk',
    'openp',
    'rom'
]


def execute(args, cwd=None):
    """
    Call something on the host and get the result.

    :return: stdout, stderr, returncode
    """
    if cwd is None:
        cwd = os.getcwd()

    p = subprocess.Popen(
        args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        cwd=cwd
    )

    stdout, stderr = p.communicate()

    return stdout, stderr, p.returncode


def lines_to_file(file_lines, file_name):
    """
    Write the lines to the file as the content of that file and return.

    :return: the length of the files written
    """
    output = '\n'.join(file_lines)
    with open(file_name, 'wb') as f:
        f.write(output.encode('utf-8'))
    return len(file_lines)


def main():
    """
    Build a setup script to be run by the computer.

    :return: a system exit code.
    """
    lines = ['#!/bin/lua', 'shell.run("rm {}")'.format(pc_root)]
    for walked_dir, sub_dirs, sub_files in os.walk(base_dir):

        # ensure the directories and files are in alphabetical order
        sub_dirs.sort()
        sub_files.sort()

        # skip git files and information
        if '.git' in walked_dir:
            continue

        # create the directory being walked
        rel_dir = os.path.relpath(walked_dir, base_dir)
        lines.append('shell.run("mkdir {}/{}")'.format(pc_root, rel_dir))

        # walk each file in the directory
        for sub_file in sub_files:

            abs_file = os.path.join(walked_dir, sub_file)

            # ignore garbage files
            if abs_file in setup_ignore:
                continue

            # find the relative path to the directory
            rel_file = os.path.relpath(abs_file, base_dir)
            lines.append('print("Retrieving: {pc_root}/{pc_path}")'.format(pc_root=pc_root, pc_path=rel_file))
            lines.append('shell.run("/openp/github get {github_user}/{github_repo}/{github_branch}/{github_path} {pc_root}/{pc_path}")'.format(
                github_user=github_user,
                github_repo=github_repo,
                github_branch=github_branch,
                github_path=rel_file,
                pc_root=pc_root,
                pc_path=rel_file
            ))

    # write the new setup file
    lines_to_file(lines, 'setup')

    # write the new cleaner file
    lines = ['#!/bin/lua']
    for f in sorted(os.listdir(base_dir)):
        if f in turtle_ignore:
            continue
        if '.git' == f:
            continue
        lines.append('shell.run("rm /{}")'.format(f))

    lines_to_file(lines, 'sanitize')

    execute(['git', 'add', 'setup', 'sanitize'])

    return 0


if __name__ == '__main__':
    sys.exit(main())

