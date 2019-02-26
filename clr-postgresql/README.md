# clr-postgresql

To start this service:
```
sudo docker run --rm=true -p 5432:5432 --network host -it byangintel/clr-postgresql
```

To test this service:
```
sudo docker run --rm=true --network host -it byangintel/clr-postgresql /usr/bin/sudo -u postgres createdb --host=127.0.0.1 test1
```
