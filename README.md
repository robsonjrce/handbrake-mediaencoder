# Handbrake MediaEncoder

The main purpose of this project is to build a simple media encoder using Handbrake to be used for encoding content as optimized versions for a Plex instance, although this is not the unique user for it. You should name other uses.

## Recommended quality settings 

Extracted from Handbrake docs

### RF settings

Recommended settings for x264 and x265 encoders:

    RF 18-22 for 480p/576p Standard Definition1
    RF 19-23 for 720p High Definition2
    RF 20-24 for 1080p Full High Definition3
    RF 22-28 for 2160p 4K Ultra High Definition4

Raising quality minus 1-2 RF may produce better results when encoding animated Sources (anime, cartoons). Lower quality settings may be used to produce smaller files. Drastically lower settings may show significant loss of detail.

Using higher than recommended quality settings can lead to extremely large files that may not be compatible with your devices. When in doubt, stick to the recommended range or use the default setting for the Preset you selected.

## How to use

You should edit the `docker-compose.yml` file accordingly with your needs. I do advise however that your main media should be **read only** and your `docker-compose.yml` should look something like this:

```YAML
version: "3.7"
services:
  handbrake-mediaencoder:
    image: handbrake-mediaencoder:0.0.0
    build:
      context: ./
      dockerfile: Dockerfile
    container_name: handbrake-mediaencoder
    command: bash
    volumes:
      - type: bind
        source: /mnt/media
        target: /mnt/media
        read_only: true
      - type: bind
        source: /mnt/media/optimized
        target: /mnt/media-optimized
        read_only: false
```

After doing so, you can run the container:

```
# make run
```

When provided with the bash you can encode using the following:

```
handbrake-mediaencoder \
    -p "fast-720p" \
    -o "bitrate=3000" \
    -d "/mnt/media-optimized/movies" \
    -b "/mnt/media/movies/" \
    -f "/mnt/media/movies/Movie Filename (2020) - 2160p.BluRay.x265.Dual.Audio.mkv"
```

## Command handbrake-mediaencoder

There are some command options that you can provide to the script:

  - **-b**: will define the basedir from the file you are encoding
  - **-d**: will define the destination directory for the file encoded to be saved
  - **-e**: will enforce the whole media enconding stack
  - **-f**: will define the filename to be encoded
  - **-o**: will pass options to update the default preset configurations
  - **-p**: will set the preset to be used on the enconding, the available presets are stored at `assets/filesystem/etc/handbrake-mediaencoder/presets`

## Command handbrake-mediaencoder options

There are some options that can be used to override the presets defaults:

  - **bitrate**: the bitrate in kbps to be used for encoding (will disable CBR)
  - **rf**: the RF to be used for encoding (will disable bitrate)

## Contributing

Feel free to fork and send changes :D