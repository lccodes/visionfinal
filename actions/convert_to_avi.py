#!/usr/bin/env python
import sys, os

def main():
    path = sys.argv[1]
    # os.system('echo ' + path)
    # os.chdir(path)
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".mp4"):
                filename = os.path.join(root, file)
                aviname = filename.replace('mp4', 'avi')
                command = '../ffmpeg -f mp4 -i ' + filename + ' -vf scale=320:240 ' + aviname
                os.system(command)

if __name__ == '__main__':
    main()

