# CentOS-Bro

Single layer Dockerfile for Bro running on CentOS 7.3.

## Usage:

```
docker run -i -t {docker image ID}

# Or, to use a local path to bring in PCAP for analysis:
docker run -i -t -v /path/to/host/folder:/home/student/PCAP {docker image ID}

```
