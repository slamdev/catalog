#!/bin/sh

##
## Extracts google proto files for better support from IDEA and cli tools
##

set -euox pipefail

PROTO_DIR="../proto"
JAR=`find ~/.gradle/caches/modules-2/files-2.1 -name "protobuf-java-*.jar" | sort -r | head -n 1`

unzip ${JAR} 'google/*' -d ${PROTO_DIR}
