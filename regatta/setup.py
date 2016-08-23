from setuptools import setup, find_packages

version = '0.0.1'
# version=regatta.__version__,
long_description = open('../README.md', 'r').read()

setup(
    name='regatta',
    version=version,
    license='General Public License',
    author='Fabian Sturm',
    author_email='f@rtfs.org',
    url='http://github.com/sturmf/regatta-angular/',
    description='A simple sailing race scoring program.',
    long_description=long_description,
    setup_requires=['flake8'],
    test_suite='runtests.runtests',
    packages=find_packages(),
    platforms='any',
    classifiers=[
        'Development Status :: 1 - Planning',
        'Environment :: Web Environment',
        'Framework :: Django :: 1.10',
        'Intended Audience :: End Users/Desktop',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
        ],
)
