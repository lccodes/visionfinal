#!/usr/bin/env python
import sys, os, glob

def main():
    path = sys.argv[1]
    # HOG_ONLY = "HOG"
    # HOF_ONLY = "HOF"
    HOF_AND_HOG = "HOF+HOG"
    
    #make result directories
    # os.makedirs(HOF_ONLY)
    # os.makedirs(HOG_ONLY)
    os.makedirs(HOF_AND_HOG)

    for file in glob.glob("*.avi"):
        commandPrefix = '/gpfs/scratch/guest207/cvpr2014/bin/fastvideofeat ' + file
        # command1 = commandPrefix + ' --disableHOG --disableMBH > ' + './HOF/' + file + '.txt'
        # print command1
        # os.system(command1)
        # command2 = commandPrefix + ' --disableHOF --disableMBH > ' + './HOG/' + file + '.txt'
        # os.system(command2)
        command3 = commandPrefix + ' --disableMBH > ' + './HOF+HOG/' + file + '.txt'
        os.system(command3)

if __name__ == '__main__':
    main()
