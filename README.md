# <p align="center">Welcome to</p>

<p align="center">
    <img src="Ksorter.svg" alt="Ksorter" title="ksorter logo">
</p>

# Overview

> [!NOTE]
> This script will most likely receive some big changes in the future.

Simple PowerShell script to sort files in a directory by their extensions.

Ktool is a part of my K suite of tools that so far includes:
- [Ktool](https://github.com/kociumba/ktool)
- [Ksorter](https://github.com/kociumba/ksorter) - this repo
- [Kinjector](https://github.com/kociumba/Kinjector)
- [Kpixel](https://github.com/kociumba/kpixel)

This script is integrated with [Ktool](https://github.com/kociumba)

## Usage

Using this script is as easy as downloading the latest version of [Ksorter.ps1](https://raw.githubusercontent.com/kociumba/ksorter/main/Ksorter.ps1)

This is a powershell script that when executed will sort files in the directory it was opened in based on their extensions.

The easies way of using it is via [Ktool](https://github.com/kociumba/ktool) as it is directly integrated into it.

> [!WARNING]
> I have not tested this script on big folders (1000+ files) so I can't assure it will work in those scenarios.
> 
> If you find any issues please report them on the [Ksorter issue tracker](https://github.com/kociumba/ksorter/issues)

## TODO
- so far errors when encountering duplicates leaving them as is in the sorting directory.
- add some kind of snapshotting to be able to revert changes if needed.

