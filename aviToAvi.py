#!/usr/bin/env python
import sys, os, glob

def main():
    path = sys.argv[1]
    os.chdir(path)
    for file in glob.glob("*.avi"):
        filename = '/Users/kei/Desktop/visionfinal/'+path+file
        # filename = os.path.join(path, file)
        command = '../../ffmpeg -i ' + filename + ' ' + filename + '_conv.avi'
        print command
        os.system(command)

if __name__ == '__main__':
    main()
