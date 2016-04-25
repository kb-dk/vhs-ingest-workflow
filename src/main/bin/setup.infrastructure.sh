#
# This is the only file in the vhs-ingest-workflow tree which is likely to
# require customisation
#

#
# Taverna installation directory
#
export TAVERNA_HOME="$HOME/tools/taverna-workbench-2.4.0"

#
# All other configuration parameters lie under this root
#
export VHSINGEST_CONFIG="$HOME/services/conf/vhs-ingest"

#
# In addition, one may here wish to specify the following parameters
#

# JAVA_HOME
# export JAVA_HOME="/usr/java/java-1.6.0-sun-1.6.0.33.x86_64"

# Files to be uploaded to bitmagasinet are normally presumed to be mounted locally on client an server
# machines. so they are available from the server by prefixing the file path with "file://". If this is
# not the case then an alternative prefix may be specified.
# export URL_PREFIX="http://canopus/cfutvdownload/"
