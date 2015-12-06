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
                mp4name = filename.replace('gif', 'mp4')
                command = '../ffmpeg -f gif -i ' + filename + ' -vf scale=320:240 ' + mp4name
                os.system(command)

if __name__ == '__main__':
    main()
