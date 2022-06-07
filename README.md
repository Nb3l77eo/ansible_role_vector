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

License
---

BSD

Author Information
------------------

https://github.com/Nb3l77eo
