import sys
from setuptools import setup, find_packages

version = '0.0.1'
# version=regatta.__version__,
long_description = open('README.md', 'r').read()

setup(
    name='regatta',
    version=version,
    license='General Public License',
    author='Fabian Sturm',
    author_email='f@rtfs.org',
    url='http://github.com/sturmf/regatta-angular/',
    description='A simple sailing race scoring program.',
    long_description=long_description,
    test_suite='setuptest.setuptest.SetupTestSuite',
    tests_require=['django-setuptest',],
    packages=find_packages(),
    #packages=['regatta', 'events'],
    platforms='any',
    classifiers=[
        'Development Status :: 1 - Planning',
        'Environment :: X11 Applications :: Qt',
        'Environment :: MacOS X',
        'Environment :: Win32 (MS Windows)',
        'Intended Audience :: End Users/Desktop',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
        ],
)
