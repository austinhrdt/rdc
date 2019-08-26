import click
import json
from pyfiglet import Figlet
#FIG = Figlet(font='slant')
#print(f"{FIG.renderText('rdc')}")


@click.group()
def rdc():
    """ remove development containers """


@click.option('-set', '--settings', help='Add vscode settings')
@click.option('-ext', '--extensions', help='Add vscode extensions to install on your dev container')
@click.option('-e', '--environment', help='Add environmental variables')
@click.option('-p', '--provider', help='Specify a provider for where to host this dev container')
@click.option('-i', '--image', help='The image of the dev container')
@click.option('-n', '--name', help='Name your dev container')
@rdc.command()
def spawn(name: str, image: str, provider: str, environment: str, extensions: str, settings: str):
    """ spawn a dev container """
    if not provider:
        provider = "local"
    
    build = JsonBuilder(name, image, provider, environment, extensions, settings)
    build.construct()

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


class JsonBuilder():
    """ builds devcontainer.json """

    def __init__(self, name, img, prov, env, ext, settings):
        self.name = name
        self.img = img
        self.prov = prov
        self.env = env
        self.ext = ext
        self.settings = settings
        self.data = {}
        self.file = "devcontainer.json"

    def construct(self):
        data = self.data
        data['name'] = self.name
        data['image'] = self.img
        data['runArgs'] = ["-v", "/var/run/docker.sock:/var/run/docker.sock"]
        if self.ext:
            print(self.ext)
            if "ms-azuretools.vscode-docker" not in self.ext:
                self.ext = self.ext + ",ms-azuretools.vscode-docker"
                print(self.ext)
            data['extensions'] = self.ext.split(',')
        
        data['settings'] = {}
        
        if self.settings:
            settings = self.settings.split(',')
            for setting in settings:
                settin = setting.split('=')
                data['settings'][settin[0]] = settin[1]

        data['settings']['remote.extensionKind'] = {"ms-azuretools.vscode-docker": "workspace"}
        self.export(data)
        



    def export(self, data):
        with open(self.file, 'w') as outfile:
            json.dump(data, outfile)


if __name__ == '__main__':
    rdc(prog_name='rdc') #pylint: disable=unexpected-keyword-arg
