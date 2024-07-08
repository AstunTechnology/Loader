from setuptools import setup, find_packages

setup(name='Loader',
      version='1.3.0',
      description='A loader for geographic data in GML',
      url='https://github.com/AstunTechnology/Loader',
      author='Matt Walker',
      author_email='mattwalker@astuntechnology.com',
      license='MIT',
      packages=find_packages(),
      long_description='A loader for geographic data in GML that needs some preparation before loading via ogr2ogr.',
      long_description_content_type="text/plain",
      python_requires='>=3.6',
      install_requires=['lxml'],
      zip_safe=False)
