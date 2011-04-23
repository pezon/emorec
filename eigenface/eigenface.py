import argparse
import ctypes
import Image
import numpy
import os

class EigenFace:
    def __init__(self, files, *args, **kwargs):
        self.libexpress = ctypes.CDLL(kwargs.get('library', './libexpress.so'))
        self.build(files)
        self.valid_extensions = ['.pgm']

    def get_histogram(self, file_name):
        image = Image.open(file_name)
        w, h = image.size

        c_histogram = ctypes.c_void_p()
        c_image = ctypes.c_char_p(''.join(map(chr, list(image.getdata()))))

        self.libexpress.gen_histogram(c_image, h, w, ctypes.byref(c_histogram))

        histogram = numpy.array(ctypes.cast(c_histogram, ctypes.POINTER(ctypes.c_ubyte))[0:256])

        self.libexpress.free_histogram(c_histogram)

        return histogram

    def build(self, files):
        self.array = numpy.add.reduce(numpy.vstack(tuple(self.get_histogram(f) for f in files)), axis=0) / len(files)
        self.list = list(self.array)

p = argparse.ArgumentParser(description='Build an eigenface from a set of images.')
p.add_argument('directory', default='.', help='Directory containing image files to analyze')
p.add_argument('-L', '--library', dest='library', default='./libexpress.so', help='Location of the libexpress library. If not supplied, it is assumed the library is in the current directory.')
args = p.parse_args()

e = EigenFace([ args.directory + os.sep + file_name for file_name in os.listdir(args.directory) if os.path.splitext(file_name)[-1] in ['.pgm'] ], library=args.library)
print e.list
