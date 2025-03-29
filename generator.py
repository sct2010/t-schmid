#!/usr/bin/env python3

import os
import re
import shutil
from pathlib import Path


def indexContent(baseUrl: str) -> str:
    html = ''
    subdirnames = next(os.walk('content'))[1]
    subdirnames.sort(reverse=True)
    for dir in subdirnames:
        html += '        <div class="titleImage"><img class="randImage" src="'
        html += baseUrl
        html += 'content/'
        html += dir
        html += '/title/dummy.png" width="300px" height="300px" alt="'
        html += dir
        html += '" title="'
        html += dir
        html += '" /></div>\n'
    return html[0:-1]


def dataTable(baseUrl: str, dir: Path) -> str:
    html = ''
    with open(os.path.join('content', dir, 'content.txt')) as f:
        lines = f.readlines()
        for line in lines:
            data = line.split('|')
            data[3] = baseUrl + 'content/' + dir + '/' + data[3]
            dataline = '        ["' + '", "'.join(data).replace('\n', '') + '"],\n'
            html += dataline
    return html[0:-1]


def dataMapTable(baseUrl: str, dir: Path) -> str:
    html = ''
    with open(os.path.join('content', dir, 'content.txt')) as f:
        lines = f.readlines()
        for line in lines:
            data = line.split('|')
            data[3] = baseUrl + 'content/' + dir + '/t_' + data[3]
            dataline = '        ["' + '", "'.join(data).replace('\n', '') + '"],\n'
            html += dataline
    return html[0:-1]


def mapView(baseUrl: str, dir: Path) -> str:
    html = ''
    with open(os.path.join('content', dir, 'map.txt')) as f:
        lines = f.readlines()
        content = lines[0].split('|')
        html = f'setView([{content[0]},{content[1]}], {content[2]});'
    return html


def galleryTitle(baseUrl: str, dir: str) -> str:
    return f'"{dir}"'


def generate(baseUrl: str, outputDir: Path):
    # copy assets
    shutil.copytree('assets', outputDir, dirs_exist_ok=True)

    # generate index.html
    with open('content/main.tpl') as f:
        data = f.read()
        functionNames = re.findall(r'(?<={{)\w+(?=}})', data)
        for functionName in functionNames:
            try:
                content = globals()[functionName](baseUrl)
                data = data.replace('{{' + functionName + '}}', content)
            except Exception:
                pass
        with open(os.path.join(outputDir, 'index.html'), 'w') as html:
            html.write(data)

    # generate gallery.html
    subdirnames = next(os.walk('content'))[1]
    for dir in subdirnames:
        with open('content/picture.tpl') as f:
            data = f.read()
            functionNames = re.findall(r'(?<={{)\w+(?=}})', data)
            for functionName in functionNames:
                try:
                    content = globals()[functionName](baseUrl, dir)
                    data = data.replace('{{' + functionName + '}}', content)
                except Exception:
                    pass
            directory = os.path.join(outputDir, dir)
            if not os.path.exists(directory):
                os.makedirs(directory)
            with open(os.path.join(directory, 'picture.html'), 'w') as html:
                html.write(data)

    # generate map.html
    subdirnames = next(os.walk('content'))[1]
    for dir in subdirnames:
        with open('content/map.tpl') as f:
            data = f.read()
            functionNames = re.findall(r'(?<={{)\w+(?=}})', data)
            for functionName in functionNames:
                try:
                    content = globals()[functionName](baseUrl, dir)
                    data = data.replace('{{' + functionName + '}}', content)
                except Exception:
                    pass
            directory = os.path.join(outputDir, dir)
            if not os.path.exists(directory):
                os.makedirs(directory)
            with open(os.path.join(directory, 'map.html'), 'w') as html:
                html.write(data)


if __name__ == '__main__':
    try:
        baseUrl = os.getenv('PROJECT_BASE_URL')
    except Exception:
        baseUrl = '.'
    
    generate(baseUrl, Path('out'))
