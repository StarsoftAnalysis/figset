#!/bin/bash

#ip=localhost
# just want the first IP -- don't know why using () does the trick
#ip=(`~/utils/netlist --4 --scope=global`)
ip=192.168.1.44

port=1316
dest=served
hugo="hugo"
content="./content"
baseurl="$ip:$port"
# Need future content for planned events etc.
future="--buildFuture"
draft="--buildDrafts"
clean="--cleanDestinationDir"

$hugo server --baseURL="$ip/" --port=$port --bind=$ip -c $content --renderToDisk -d $dest --disableFastRender --watch $future $draft --verbose --noHTTPCache $clean "$@"
