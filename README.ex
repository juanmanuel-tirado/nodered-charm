# Overview

[Node-RED](https://nodered.org) is a programming tool for wiring together 
hardware devices, APIs and online services in new and interesting ways. It 
provides a browser-based editor that makes it easy to wire together flows 
using the wide range of nodes in the palette that can be deployed to its 
runtime in a single-click.

This charm deploys a basic Node-Red server on the desired port. It provides
an [HTTP interface](https://github.com/juju-solutions/interface-http) with
basic configuration options.

Also remember to check the [icon guidelines][] so that your charm looks good
in the Juju GUI.

# Usage

To deploy Node-RED run

```
juju deploy nodered
```

The download process may take a while. Check the current Juju status until
you see the application up and ready.

```
juju status
Model    Controller  Cloud/Region         Version  SLA          Timestamp
default  test        localhost/localhost  2.9.10   unsupported  14:57:18+02:00

App      Version  Status  Scale  Charm    Store  Channel  Rev  OS      Message
nodered           active      1  nodered  local             6  ubuntu  Ready

Unit        Workload  Agent  Machine  Public address  Ports     Message
nodered/5*  active    idle   5        10.115.103.100  1880/tcp  Ready

Machine  State    DNS             Inst id        Series  AZ  Message
5        started  10.115.103.100  juju-41333b-5  focal       Running
```

Expose the application:

```
juju expose nodered
```

Now you can browse the Node-RED app in the container IP and the configured
port.


## Known Limitations and Issues

Node-RED is built on top of NodeJS. The installation of the NodeJS may require
a while. Afterwards, the installation uses `npm` to install Node-RED as 
explained in the [official guide](https://nodered.org/docs/getting-started/local).
It is possible to install the Node-RED snap package. Unfortunately, this may
result in additional problems when regards to install additional Node-RED 
libraries as mentioned in the official guide.