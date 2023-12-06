<h1>MongoDB plugin</h1>

<h2>Installation on local HPCC Cluster</h2>
1.Install HPCC Platform,Client Tools for Linux(9.4.10 or higher current version).

2.Install the MongoDB embed for ur distribution from-( https://github.com/hpcc-systems/HPCC-Platform/releases/tag/community_9.4.10-1)
Make sure this is done after platform is installed.(sudo dpkg -i ./hpccsystems-plugin-mongodbembem_<version>.deb)

If overwrite error-
sudo dpkg -P <package-name>
sudo dpkg -i --force-overwrite <file-path>
sudo apt-get --fix-broken install
This will provide warnings but will fix the overwrite issues.

3.Avoid version mismatch .Ensure the presence of shared object file "libmongodbembed.so" in /HPCCSystems/Plugins

4.Can start the HPCC localhost:8010/ cluster using /etc/init.d/hpcc-init start(stop/restart can also be done).
Ensure 'OK'  for all servers.

5.Make sure the cluster is started after mongodb plugin installation or restart .(Open ECL watch to confirm, be in Root).

6.Test the code in VS Code/ECL IDE to ensure the mongodb plugin is working.






<h2>changestreams.ecl file-</h2>












<h2>display.ecl file</h2>

*This display.ecl file connects to the MongoDB cluster , a RECORD structure has been created for a specific data schema , which is then sprayed onto the HPCC Cluster through the OUTPUT where the scope of Logical File has been mentioned .
*OVERWRITE helps to spray the latest versions of documents from the HistoryVersion Collection in MongoDB database.
*The HistoryVersion Collection contains the JSON documents with additional fields whenever new modifications has occured in the MyCollection Collection , where the change streams is watching for changes like insertion, deletion and updation.
