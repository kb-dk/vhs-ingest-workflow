Steps to release
====

* Run Integrationstest and verify that it works
 
        mvn integration-test -P integrationTestProfile -Denv.passwordlessKey=$HOME/.ssh/id_rsa
                
* Update CHANGELOG.md

    * Find new version number from pom.xml
    * Find changes from GIT log and insert the relevant parts
 
* Then release:prepare using Maven

    This command will ask you questions about release version numbers etc. (you can usually just hit return)
    
    This command tags the release and pushes this tag
     
        mvn clean release:prepare
                
* Then release:perform using Maven

    This command checks out the new tag, builds it, and uploads the resulting artefacts to nexus.

        mvn release:perform

* Get the resulting artefact from target/vhs-ingest-workflow-XXX-bundle.tar.gz and send it to jhlj@statsbiblioteket.dk
  or just send him the link to the released artifact from nexus <https://sbforge.org/nexus/content/repositories/releases/dk/statsbiblioteket/medieplatform/vhs-ingest-workflow/XXXX/vhs-ingest-workflow-XXXX-bundle.tar.gz>
                
* If you updated the configurations, send the changed config files and locations as well...                