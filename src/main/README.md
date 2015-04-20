# VHS ingest workflow

The VHS ingest workflow is actually two workflows. One for new digitised VHS files, and one for VHS clips matching
a specific program. Both are Taverna workflows (see taverna folder) designed to ingest digitised VHS files and clips
into the SB digital repositories.

The VHS file ingest workflow involves these steps
 * copy file
 * ffprobe file
 * get metadata
 * validate properties base on ffprobe output
 * checksum file
 * ingest into Bit Storage
 * package metadata for Doms
 * ingest into Doms

Each step is a Taverna Tool Invocation, which calls a bash script in the scripts folder.

The scripts depend on configurations found in the SB internal VHSINGEST_CONFIG project.

The workflow can be tested using integrationTests/runIntegrationTests.sh

mvn integration-test -P integrationTestProfile -Denv.passwordlessKey=/home/<user>/.ssh/id_rsa


