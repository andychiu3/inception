## Inception

A multi-container **Docker** project for building a self-hosted, secure web service infrastructure 

using Nginx, WordPress and MariaDB.

<br>

### How to use

To check the project, open the terminal entering below:

```
git clone <URL> inception

cd incepton

make
```
Then, open browser entering:

```
https://localhost
```

.env are included. Ideally is to gitignore all the .env for security reason.

However, this is just a project to broaden the knowledge of docker and how do services communicate with each other.

info of .env are not sensitive here.

<br>

### Architecture

  [ Client Browser ] -> [ Nginx ] -> [ WordPress ] -> [ MariaDB ]

<br>

### Concept

This project is about running isolated services within virtualized containers. 

The goal is not to deploy the simplest stack possible, 

but to **understand how to architect and manage interconnected services using Docker**.

<br>

### This project covers:

- Docker basics: images, volumes, networks
  
- Service orchestration using Docker Compose
  
- HTTPS encryption with self-signed TLS certificates
  
- Data persistence with named volumes
  
- Secure and minimal configuration

<br>

