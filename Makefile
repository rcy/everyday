grab:
	/bin/sh ./grab.sh

FPS=24

avis := $(patsubst images/%,videos/%/movie.avi,$(wildcard images/*/*/*))

videos/%/movie.avi: images/%
	mkdir -p $(dir $@)
	mencoder mf://$^/*.jpg -mf fps=$(FPS):type=jpg -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell -oac copy -o $@

all: $(avis) index.html

index.html: $(avis)
	/bin/sh ./mkhtml.sh $(avis) > $@

clean:
	rm -f index.html $(avis)
