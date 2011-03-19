import Image 
import os

def pgm_convert(filename):
    newname = '%s.pgm' % os.path.splitpath(filename)[0]
    im = Image.open(filename)
    width, height = im.size

    max = 0
    sequence = ''
    for i in im.getdata():
        if i > max:
            max = i
        sequence += '%s ' % i
    
    contents = 'P2\n# %s\n%s %s\n%s\n%s' % 
      (newname, width, height, max, sequence)

    save = open(newname)
    save.write(contents)
    save.flush()
    save.close()
