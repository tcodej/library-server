# MusicBin Server

A simple Express app that serves up directory and file information to be used with a front-end UI to play my personal audio files. Works in tandem with the [musicbin-ui](https://github.com/tcodej/musicbin-ui) front end.

The folder structure that I follow for my mp3 collection is roughly like the following:

```
Artist A
	+- YYYY - Album 1
		+- 01 - Song Title 1.mp3
		+- 02 - Song Title 2.mp3
	+- YYYY - Album 2
	+- YYYY - Album 3
Artist B
	+- Folder Official
	   +- YYYY - Album 1
	   +- YYYY - Album 2
	+- Folder Bootlegs
	   +- YYYY - Bootleg 1
	   +- YYYY - Bootleg 2
```
ID3 Tags have been populated on all of my mp3s. Currently that info is used to display album images and some artist/album info. If it doesn't exist, you'll get generic info.

At this moment no album/artist info is cached on the server and no database is used. All infomation comes from the mp3 files and the directory names.

Sync from local to pi usb:  
rsync -e ssh --rsync-path="sudo rsync" -rptn --delete --progress /mnt/g/Audio/mp3/Music trentj@192.168.1.200:/mnt/usb/mp3

(Remove the n from -rptn to perform the actual sync)