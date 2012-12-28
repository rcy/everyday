#!/bin/sh

/bin/cat <<EOF
<!DOCTYPE html> 
<html>
  <head>
    <title>rcy everyday</title>
  </head>
  <body>
    <h1>rcy everyday</h1>
    <ul>
EOF

for i in $@
do
    cat <<EOF
      <li>
        <a href="$i">$i</a>
      </li>
EOF
done

/bin/cat <<EOF
    </ul>
  </body>
</html>
EOF
