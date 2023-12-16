# Ansible Local Runner

This project gives a simple Ansible Docker image to run Ansible locally in a Docker container. From Docker side, it
provides the Dockerfile to build the image and a Docker Compose to run the container. As examples, an inventory file is
provided, with only one local execution node, and a _Hello World!_ playbook is also furnished within this repository.

**More information can be found here:**

- [Docker](https://docker.com/)
    - [Dockerfile](https://docs.docker.com/engine/reference/builder/)
    - [Docker Compose](https://docs.docker.com/compose/)
- [Ansible](https://ansible.com/)
    - [Ansible inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)
    - [Ansible playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html)

## Build the image

To build the image, run the following command:

```shell
docker build -t local/ansible .
```

The build will download `ubuntu:22.04` and install the required packages to run Ansible. It will also create the
user `ansible` and all the directories to mount local playbooks and inventory. Finally, it adds the following aliases to
make playbook run easily:

- `ansible-playbook='ansible-playbook -i /home/ansible/inventory.yml'` to use the local inventory as the default one
- `ap='ansible-playbook` to quickly run playbooks

The image tag is `local/ansible`.

## Run the container

To run the container, simply use the provided docker-composer configuration file:

```shell
docker-compose up -d ansible
```

## Connect to the container

To connect to the container, run the following command:

```shell
docker-compose exec ansible bash
```

Once run, you will be logged as `ansible` user in the `/home/ansible` directory.

## Run Ansible playbooks

**With the legacy command:**

```shell
cd playbooks
ansible-playbook hello-world.yml
```

As you notice, there is no need to provide the inventory location as an argument, as the `ansible-playbook` is an alias
of the full command `ansible-playbook -i /home/ansible/inventory/inventory.yml`

**With the short alias:**

```shell
cd playbooks
ap hello-world.yml
```

Once run you might have an output like this:

```text
PLAY [Hello World] ***************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************
ok: [localhost]

TASK [Log Hello World!] **********************************************************************************************
ok: [localhost] => {
    "msg": "Hello World!"
}

PLAY RECAP ***********************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
