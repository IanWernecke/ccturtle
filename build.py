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
github_root = f'https://raw.github.com/{github_user}/{github_repo}/{github_branch}/'

# the location to save the files on the pc
pc_root = '/turtle/'
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
        # f'if fs.exists("{pc_root}") then',
        # f'  fs.delete("{pc_root}")',
        # 'end',
        '',
        '-- constants',
        f'local src = "{github_root}"',
        f'local dst = nil',
        f'if turtle then',
        f'   dst = "/"',
        f'else',
        f'  dst = "{pc_root}"',
        f'  if fs.exists("{pc_root}") then',
        f'      fs.delete("{pc_root}")',
        f'  end',
        f'end',
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
    files = []
    for walked_dir, sub_dirs, sub_files in os.walk(base_dir):

        # ensure the directories and files are in alphabetical order
        sub_dirs.sort()
        sub_files.sort()

        # skip git files and information
        if '.git' in walked_dir:
            continue

        # create the directory being walked
        rel_dir = os.path.relpath(walked_dir, base_dir)
        directories.append(f'{pc_root}{rel_dir}')

        # walk each file in the directory
        for sub_file in sub_files:

            abs_file = os.path.join(walked_dir, sub_file)

            # ignore garbage files
            if abs_file in setup_ignore:
                continue

            # find the relative path to the directory
            rel_file = os.path.relpath(abs_file, base_dir)
            files.append(rel_file)

    def to_lua_list(name, items):
        lines.append('local {} = {}'.format(name, '{'))
        for item in items:
            lines.append(f'  "{item}",')
        lines[-1] = lines[-1][:-1]
        lines.append('}')
        lines.append('')

    # create the directory and file lists
    to_lua_list('directories', directories)
    to_lua_list('files', files)

    # define the requests to be performed and their output location
    lines.extend([
        '-- tie each path to a request path',
        'local requests = {}',
        'for i=1,#files do',
        '   requests[src..files[i]] = dst..files[i]',
        'end',
        ''
    ])

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
        'for key,value in pairs(requests) do',
        '   http.request(key)',
        'end',
        ''
    ])

    lines.extend([
        '-- asynchronously download all of the files',
        'local downloaded = 0',
        'local failed = {}',
        f'while downloaded < {len(files)} do',
        '   local event, url, handle = os.pullEvent()',
        '   if event == "http_success" then',
        '       download(handle.readAll(), requests[url])',
        '       downloaded = downloaded + 1',
        '   elseif event == "http_failure" then',
        '       failed[os.startTimer(3)] = url',
        '   elseif event == "timer" and failed[url] then',
        '       print("fail: "..url)',
        '       http.request(failed[url])',
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
