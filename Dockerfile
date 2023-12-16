FROM ubuntu:22.04

RUN useradd --home /home/ansible \
    --create-home \
    --shell /bin/bash \
    ansible

RUN apt update \
    && apt -y install software-properties-common sshpass \
    && apt -o "Aquire::https::Verify-Peer=false" -y install ansible \
    && apt clean

RUN echo "" >> /home/ansible/.bashrc \
    && echo "# Ansible aliases" >> /home/ansible/.bashrc \
    && echo "alias ansible-playbook='ansible-playbook -i /home/ansible/inventory/inventory.yml'" >> /home/ansible/.bashrc \
    && echo "alias ap='ansible-playbook'" >> /home/ansible/.bashrc

RUN mkdir /home/ansible/playbooks /home/ansible/inventory

VOLUME /home/ansible/playbooks
VOLUME /home/ansible/inventory

USER ansible
WORKDIR /home/ansible

CMD ["/bin/bash"]
