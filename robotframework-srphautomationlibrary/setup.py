from os.path import abspath, dirname
from setuptools import setup

CWD = abspath(dirname(__file__))
with open('requirements.txt') as f:
    required = f.read().splitlines()

CLASSIFIERS = """
Development Status :: 3 - Alpha
Topic :: Software Development :: Testing
Operating System :: OS Independent
License :: OSI Approved :: Apache Software License
Programming Language :: Python
Programming Language :: Python :: 3.10
Topic :: Software Development :: Testing
Framework :: Robot Framework
Framework :: Robot Framework :: Library
""".strip().splitlines()

setup(
    name="robotframework-srphautomationlibrary",
    version="0.1",
    description="Automation Library for Robot Framework",
    long_description="A library containing all reusable keywords and useful libraries for Robot Framework",
    long_description_content_type="text/markdown",
    url="https://github.sec.samsung.net/SRPH/robotframework-srphautomationlibrary",
    author="Test Automation Part",
    author_email="#",
    license="Apache License 3.0",
    classifiers=CLASSIFIERS,
    keywords="robot framework testing automation selenium seleniumlibrary",
    platforms="any",
    install_requires = required,
    packages=["SRPHAuto"],
    package_dir={"": "src"},
    package_data={"SRPHAuto": ["*.robot"]},
)