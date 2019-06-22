## Tela Icon Theme

A flat colorful Design icon theme

## Installation

Usage:  `./install.sh`  **[OPTIONS...]** **[COLOR VARIANTS...]**

|  OPTIONS: |                                                             |
|:----------|:------------------------------------------------------------|
| -d        | Specify theme destination directory (Default: $HOME/.themes)|
| -n        | Specify theme name (Default: Tela)                          |
| -h        | Show this help                                              |

|  COLOR VARIANTS |                                                             |
|:----------------|:------------------------------------------------------------|
| black           | Black color folder version                                  |
| blue            | Blue color folder version                                   |
| brown           | Brown color folder version                                  |
| green           | Green color folder version                                  |
| grey            | Grey color folder version                                   |
| orange          | Orange color folder version                                 |
| pink            | Pink color folder version                                   |
| purple          | Purple color folder version                                 |
| red             | Red color folder version                                    |
| yellow          | yellow color folder version                                 |
| manjaro         | Manjaro default color folder version                        |
| ubuntu          | Ubuntu default color folder version                         |

By default, **all** color variants are selected.

### On Gentoo Linux

First, you can add [Beatussum's overlay](https://github.com/beatussum/beatussum-overlay) by using [Layman](https://wiki.gentoo.org/wiki/Layman):

```bash
layman --list
layman --add  beatussum-overlay
layman --sync beatussum-overlay
```

And install the _x11-themes/tela-icon-theme_ package.

## Preview
![Tela](../master/tela-dark.png)
![Tela](../master/tela-light.png)
