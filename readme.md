# Docker - Tox DHT Bootstrap Node Daemon
A simple dockerized version of the *tox-bootstrapd* application from the [c-toxcore](https://github.com/TokTok/c-toxcore) project.
This container is mainly intended to be built and ran on ARM-based SBCs.

## Requirements
### Building
__CPU Architecture:__ Any <sub><sup>(Use the [official image](https://github.com/TokTok/c-toxcore/tree/master/other/docker) for x86-64)</sup></sub><br>
__RAM:__ Around 256MiB <sub><sup>(More of a recommendation)</sup></sub><br>
__HDD:__ Around 300MB
### Running
#### Self-built
__CPU Architecture:__ Any<br>
__RAM:__ Less than 16MiB<br>
__HDD:__ Less than 16MB <sub><sup>(If leftovers are cleaned)</sup></sub>
#### Docker Hub
__CPU Architecture:__ ARM64 <sub><sup>(Use the [official image](https://github.com/TokTok/c-toxcore/tree/master/other/docker) for x86-64)</sup></sub><br>
__RAM:__ Less than 16MiB<br>
__HDD:__ Less than 16MB

## Building
### Cloning
In order to clone this repository, you simply have to use the foollowing commands:
```bash
git clone https://github.com/aziascreations/Docker-Tox-DHT-Bootstrap-Node-Daemon.git
cd Docker-Tox-DHT-Bootstrap-Node-Daemon
```

### Via Docker
**TODO !**

### Via Docker-compose
In order to build this container with *docker-compose*, you simply have to use the following command:
```bash
docker-compose up
```

However, you can also choose to configure the ports, environment variables and volumes in the [docker-compose.yml](docker-compose.yml) file if you want to.

Once the container has been built, you can change the [tox-bootstrapd.conf](tox-bootstrapd.conf) config file and clean any build leftovers.

## Running
TODO: Wait until it is available on Docker Hub.

### Configuration
#### Build Arguments
<table>
	<tr>
		<td>
			Name
		</td>
		<td>
			Description
		</td>
		<td>
			Value
		</td>
		<td>
			Default
		</td>
	</tr>
	<tr>
		<td>
			<code>TOXCORE_DESIRED_VERSION</code>
		</td>
		<td>
			Release version number of the tox-core project that should be grabbed from GitHub and compiled.
		</td>
		<td>
			String
		</td>
		<td>
			<code>0.2.16</code>
		</td>
	</tr>
</table>

#### Environment Variables
<table>
	<tr>
		<td>
			Name
		</td>
		<td>
			Description
		</td>
		<td>
			Value
		</td>
		<td>
			Default
		</td>
	</tr>
	<tr>
		<td>
			<code>PUID</code>
		</td>
		<td>
			The UID under which the application should run.
		</td>
		<td>
			Integer
		</td>
		<td>
			<code>1000</code>
		</td>
	</tr>
	<tr>
		<td>
			<code>PGID</code>
		</td>
		<td>
			The PID under which the application should run.
		</td>
		<td>
			Integer
		</td>
		<td>
			<code>1000</code>
		</td>
	</tr>
</table>

## License
[GNU General Public License v3.0](LICENSE)

This project uses the same license as [c-toxcore](https://github.com/TokTok/c-toxcore) in order to simplify the management of licenses on your side.
