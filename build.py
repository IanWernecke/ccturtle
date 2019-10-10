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
    lines = [
        '#!/bin/lua',
        f'fs.delete("{pc_root}")',
        '',
        '-- simple function to write data to files',
        'local function download(data, file)',
        '   local f = fs.open(file, "w")',
        '   f.write(data)',
        '   f.close()',
        'end',
        ''
    ]
    directories = []
    files = {}
    # request_count = 0
    for walked_dir, sub_dirs, sub_files in os.walk(base_dir):

        # ensure the directories and files are in alphabetical order
        sub_dirs.sort()
        sub_files.sort()

        # skip git files and information
        if '.git' in walked_dir:
            continue

        # create the directory being walked
        rel_dir = os.path.relpath(walked_dir, base_dir)
        directories.append(f'{pc_root}/{rel_dir}')

        # walk each file in the directory
        for sub_file in sub_files:

            abs_file = os.path.join(walked_dir, sub_file)

            # ignore garbage files
            if abs_file in setup_ignore:
                continue

            # find the relative path to the directory
            rel_file = os.path.relpath(abs_file, base_dir)
            url = f'https://raw.github.com/{github_user}/{github_repo}/{github_branch}/{rel_file}'
            files[url] = f'{pc_root}/{rel_file}'

    # create the directory table
    lines.append('local directories = {')
    for directory in directories:
        lines.append(f'  "{directory}",')
    lines[-1] = lines[-1][:-1]
    lines.append('}')
    lines.append('')

    # # create the massive table to house our information
    # lines.append('local paths = {')
    # for file_name in files:
    #     lines.append(f'  "{file_name}" = "{files[file_name]}",')
    # # remove the comma from the last line
    # lines[-1] = lines[-1][:-1]
    # lines.append('}')

    # create the massive table to house our information
    lines.append('local paths = {}')
    for file_name in files:
        lines.append(f'paths["{file_name}"] = "{files[file_name]}"')
    lines.append('')

    # create each of the directories
    lines.extend([
        '-- make each of the required directories',
        'for i=1,#directories do',
        '   fs.makeDir(directories[i])',
        'end',
        ''
    ])

    # request each of the files
    lines.extend([
        '-- request each of the files to be retrieved',
        'for key,value in pairs(paths) do',
        '   http.request(key)',
        'end',
        ''
    ])

    lines.extend([
        '-- asynchronously download all of the files',
        'local downloaded = 0',
        'local failed = {}',
        f'while downloaded < {len(files)} do',
        '   local e, a, b = os.pullEvent()',
        '   if e == "http_success" then',
        '       download(b.readAll(),paths[a])',
        '       downloaded = downloaded + 1',
        '   elseif e == "http_failure" then',
        '       failed[os.startTime(3)] = a',
        '   elseif e == "timer" and failed[a] then',
        '       http.request(failed[a])',
        '   end',
        'end',
        ''
    ])

    # write the new setup file
    lines_to_file(lines, 'setup')

    # write the new cleaner file
    lines = ['#!/bin/lua']
    for f in sorted(os.listdir(base_dir)):
        if f in turtle_ignore:
            continue
        if '.git' == f:
            continue
        lines.append(f'fs.delete("/{f}")')

    lines_to_file(lines, 'sanitize')

    execute(['git', 'add', 'setup', 'sanitize'])

    return 0


if __name__ == '__main__':
    sys.exit(main())
