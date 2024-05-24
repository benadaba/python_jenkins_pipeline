from setuptools import setup, find_packages

setup(
    name='flask_app',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'Flask==2.0.3'
    ],
    entry_points={
        'console_scripts': [
            'run-app=app.main:app.run'
        ],
    },
)
