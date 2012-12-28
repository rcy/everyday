# to grab an image every minute, run from cron like this:
# * * * * * /usr/bin/make grab -C /path/to/this/directory > /dev/null

FPS=24

avis := $(patsubst images/%,videos/%/movie.avi,$(wildcard images/*/*/*))

videos/%/movie.avi: images/%
	mkdir -p $(dir $@)
	mencoder mf://$^/*.jpg -mf fps=$(FPS):type=jpg -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell -oac copy -o $@


all: $(avis) index.html

index.html: $(avis)
	/bin/sh ./mkhtml.sh $(avis) > $@

grab:
	/bin/sh ./grab.sh

clean:
	rm -f index.html $(avis)
