#!/bin/sh

/bin/cat <<EOF
<!DOCTYPE html> 
<html>
  <head>
    <title>rcy everyday</title>
    <link href="http://vjs.zencdn.net/c/video-js.css" rel="stylesheet">
    <link href="index.css" rel="stylesheet">
  </head>
  <body>
    <h1>rcy everyday</h1>
    <div id="content"></div>
    <div id="calendar"></div>

    <script>
      var videos = [
EOF

for i in $@; do echo "\"$i\","; done

/bin/cat <<EOF
    ];
    </script>
    <script src="http://vjs.zencdn.net/c/video.js"></script>
    <script src="index.js"></script>
  </body>
</html>
EOF
