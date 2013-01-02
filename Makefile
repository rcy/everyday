# to grab an image every minute, run from cron like this:
# * * * * * /usr/bin/make grab -C /path/to/this/directory > /dev/null

FPS=24

mp4s := $(patsubst images/%,videos/%/movie.mp4,$(wildcard images/*/*/*))

videos/%/movie.mp4: images/%
	mkdir -p $(dir $@)/build
	cp $^/*.jpg $(dir $@)/build
	cd $(dir $@)/build; i=0; for file in *jpg; do mv $$file `printf %010d.jpg $$i`; i=`expr $$i + 1`; done
	avconv -loglevel error -y -i $(dir $@)/build/%010d.jpg -vcodec libx264 -pix_fmt yuv420p -vprofile high -preset fast -b:v 500k -maxrate 500k -bufsize 1000k -vf scale=trunc\(oh*a/2\)*2:480 -threads 0 $@
	rm -rf $(dir $@)/build

all: $(mp4s) public/videos.js

public/videos.js: $(mp4s)
	/bin/sh ./bin/mkvideosjs.sh $(mp4s) > $@

grab:
	/bin/sh ./bin/grab.sh

clean:
	rm -f index.html $(mp4s)
