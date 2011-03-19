import os
import pgmconvert

for root, dirs, files in os.walk(database):
    for f in files:
        fullpath = os.path.join(root, f)
        try:
            pgmconvert(fullpath)
            os.remove(fullpath)
        except:
            print 'could not open %s' % fullpath
