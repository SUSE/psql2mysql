from setuptools import setup, find_packages

setup(
    name='psql2mysql',
    version='0.4.0',
    description='Copy data from PostgreSQL databases to MySQL',
    url='https://github.com/SUSE/psql2mysql',
    author='SUSE LLC',
    author_email='things@suse.com',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache License 2.0',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
    ],
    packages=find_packages(exclude=['tests']),
    install_requires=[
        'oslo.config',
        'oslo.log',
        'psycopg2',
        'prettytable',
        'PyMySQL',
        'rfc3986',
        'SQLAlchemy<1.1.0,>=1.0.10',
    ],
    tests_requires=[
        'flake8',
        'mock',
    ],
    entry_points={
        'console_scripts': [
            'psql2mysql=psql2mysql:main',
        ],
    },
)
