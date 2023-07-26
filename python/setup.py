from setuptools import setup, find_packages

with open("../readme.md", "r") as fh:
    long_description = fh.read()

setup(name='Loader',
      version='1.3.0',
      description='Scripts to convert classic layers to OGC layers',
      url='',
      author='Ian Turton',
      author_email='ianturton@astuntechnology.com',
      license='MIT',
      packages=find_packages(),
      long_description=long_description,
      long_description_content_type="text/markdown",
      python_requires='>=3.6',
      install_requires=['lxml'],
      zip_safe=False)
