# Home Assistant Add-on: iSpy Agent DVR
![version][version-shield] ![arch][arch-shield]

[version-shield]: https://img.shields.io/badge/dynamic/yaml?color=success&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fljsquare%2Fhassio-addons%2Fmain%2Fispy_agent_dvr%2Fconfig.yaml

[arch-shield]: https://img.shields.io/badge/dynamic/yaml?color=success&label=arch&query=arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fljsquare%2Fhassio-addons%2Fmain%2Fispy_agent_dvr%2Fconfig.yaml

![image](https://user-images.githubusercontent.com/64090632/195932021-ce3d4674-9d1a-4f16-861e-bf0b67e8f3f8.png)

* [About Agent DVR](https://www.ispyconnect.com/)
* [Documentation AgentDVR](https://www.ispyconnect.com/userguide-agent-dvr.aspx)
* [Images on docker hub](https://registry.hub.docker.com/r/doitandbedone/ispyagentdvr)
* [iSpy Agent DVR docker](https://github.com/doitandbedone/ispyagentdvr-docker)
* [Help and contact](https://github.com/doitandbedone/ispyagentdvr-docker/issues)

## How to use

The user manual for iSpy Agent DVR can be found here: [https://www.ispyconnect.com/userguide-agent-dvr.aspx](https://www.ispyconnect.com/userguide-agent-dvr.aspx)

### [Storage Management](https://www.ispyconnect.com/userguide-agent-storage-management.aspx)
The addon is a docker container. By default the default folder of iSpy is persistent, but not accessible for anywhere.
To solve this problem, there are 2 options:
1) add an extra storage location, pointing to a folder in de `/share` folder
2) use the override switch to link the default folder of iSpy to a folder `/share`. The name of the new folder can be given in the configuration of the addon.
