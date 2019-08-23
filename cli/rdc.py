""" rdc cli """
import click
from pyfiglet import Figlet
FIG = Figlet(font='slant')

print(f"{FIG.renderText('rdc')}")

@click.group()
def rdc():
    """"""
    print(f"{FIG.renderText('rdc.....')}")


@click.option('-ext', '--extensions', help='Add vscode extensions to install on your dev container')
@click.option('-e', '--environment', help='Add environmental variables')
@click.option('-p', '--provider', help='Specify a provider for where to host this dev container')
@click.option('-i', '--image', help='The image of the dev container')
@click.option('-n', '--name', help='Name your dev container')
@rdc.command()
def spawn(name: str, image: str, provider: str, environment: str, extensions: str):
    """ spawn a dev container """
    if not provider:
        provider = "local"
    print(name)
    print(image)
    print(provider)
    print(environment)
    print(extensions)

@click.option('-n', '--name', help='Name of your dev container')
@rdc.command()
def connect(name: str):
    """ connect to a dev container """
    print(name)

@click.option('-n', '--name', help='Name of your dev container')
@rdc.command()
def purge(name: str):
    """ purge a dev container """
    print(name)


if __name__ == '__main__':
    rdc(prog_name='rdc') #pylint: disable=unexpected-keyword-arg
