# Docker - Tox DHT bootstrap node daemon
A simple Dockerfile and docker-compose file that can be used to create a Tox DHT bootstrap node on SBCs.

## Requirements
### Building
__CPU Architecture:__ ARM64 <sub><sup>(Use the [official image](https://github.com/TokTok/c-toxcore/tree/master/other/docker) for x86 and AMD64)</sup></sub><br>
__RAM:__ Less than 16MiB <sub><sup>(More is required while compiling)</sup></sub>
### Container
__CPU Architecture:__ ARM64 <sub><sup>(Use the [official image](https://github.com/TokTok/c-toxcore/tree/master/other/docker) for x86 and AMD64)</sup></sub><br>
__RAM:__ Less than 16MiB

## Remarks
TODO.

## Building
In order to build this container, all you have to do is to clone this repository and run `docker-compose up`.

## Configuration
### Environment Variables (W.I.P)
<table>
	<tr>
		<td>
			Variable
		</td>
		<td>
			Value
		</td>
		<td>
			TODO
		</td>
	</tr>
	<tr>
		<td>
			PUID
		</td>
		<td>
			Integer<br>
			The user's UID running the application.
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td>
			PGID
		</td>
		<td>
			Integer<br>
			The user's PID running the application.
		</td>
		<td>
		</td>
	</tr>
</table>

## License
[GNU General Public License v3.0](LICENSE)

This project uses the same license as [c-toxcore](https://github.com/TokTok/c-toxcore) in order to simplify the management of licenses on your side.
