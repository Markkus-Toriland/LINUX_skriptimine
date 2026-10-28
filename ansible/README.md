# Ansible - halduse automatiseerimine

Aine Skriptimisvahendid Ansible'i laborid. Ansible-server `ansible-markkus` (Debian 13)
haldab kahte kliendiserverit:

| Host | OS | Kasutus |
|------|----|---------|
| klient1 (`klient1-markkus`) | Debian 13 | veebiserver, MySQL |
| klient2 (`klient2-markkus`) | CentOS Stream 10 | veebiserver, MySQL |

Ühendus käib SSH võtmetega root kasutajana. Ansible-serveris on `hosts` fail `/root/hosts`,
`ansible.cfg` fail `/root/.ansible.cfg` ja playbookid kaustas `/root/playbooks`.

## Laborid

| Labor | Fail | Sisu |
|-------|------|------|
| Lab 1 | `hosts`, `ansible.cfg` | inventar (grupp `webservers`) ja seadistus, kontroll `ansible -m ping all` |
| Lab 2 | `playbooks/apache2_samm1.yml` | samm 1: ainult veebiserveri paigaldamine |
| Lab 2 | `playbooks/apache2.yml` | Apache2 / httpd, userdir moodul ja kasutaja `user` koduleht `http://server/~user/` |
| Lab 2 | `playbooks/index.yml` | iseseisev ülesanne: igale serverile unikaalne avaleht (hostinimi ja IP) |
| Lab 4 | `playbooks/mysql-server.yml` | MySQL ametlik APT hoidla ja MySQL 8.4 server (CentOS-is pakett mysql8.4-server) |
| Lab 4 | `playbooks/mysql-user.yml` | iseseisev ülesanne: root kasutaja parool ja `/root/.my.cnf` |

Iga playbook kontrollitakse enne käivitamist: `ansible-playbook --check playbook.yml`.

Debiani ja CentOS-i erinevused (paketinimed, teenuse nimi, SELinux) on lahendatud tingimusega
`when: ansible_os_family == "Debian"` / `"RedHat"`.

MySQL root parooli playbookis ei ole - `mysql-user.yml` küsib selle käivitamisel (`vars_prompt`).
