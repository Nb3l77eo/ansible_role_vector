Vector
=========

Role for installation Vector.

Requirements
------------

No

Role Variables
--------------
- Определение устанавливаемой версии Vector <p>
```vector_version: "0.21.2" # or "latest"```

Dependencies
------------

No

Example Playbook
----------------

```yaml
  - name: Install Vector
    hosts: vectors
    vars:
      vector_version: "0.21.2"
```

Testing
-------
molecule:
  <P>molecule test -s (centos_7||centos_8||ubuntu_latest)

tox:
<p> - podman
<p> - docker
<p>Для запуска теста tox(podman||docker) необходимо собрать образ из Dockerfile в репозитории.


License
---

MIT

Author Information
------------------

https://github.com/Nb3l77eo
