from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [Extension("leven_c", ["leven_c.pyx", "leven.c"])]

setup(
  cmdclass = {"build_ext": build_ext},
  ext_modules = ext_modules
)