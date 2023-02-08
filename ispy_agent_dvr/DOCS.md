# Home Assistant Add-on: iSpy Agent DVR

## How to use

The user manual for iSpy Agent DVR can be found here: [https://www.ispyconnect.com/userguide-agent-dvr.aspx](https://www.ispyconnect.com/userguide-agent-dvr.aspx)

### [Storage Management](https://www.ispyconnect.com/userguide-agent-storage-management.aspx)
The addon is a docker container. By default the default folder of iSpy is persistent, but not accessible for anywhere.
To solve this problem, there are 2 options:
1) add an extra storage location, pointing to a folder in de `/share` folder
2) use the override switch to link the default folder of iSpy to a folder `/share`. The name of the new folder can be given in the configuration of the addon.
