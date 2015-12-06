#!/usr/bin/env python
import sys, os

def main():
    path = sys.argv[1]
    # os.system('echo ' + path)
    # os.chdir(path)
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".gif"):
                filename = os.path.join(root, file)
                aviname = filename.replace('gif', 'avi')
                command = '../ffmpeg -f gif -i ' + filename + ' -vf scale=320:240 ' + aviname
                os.system(command)

if __name__ == '__main__':
    main()

