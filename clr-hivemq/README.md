# clr-postgresql

To start this service:
```
sudo docker run --rm=true --network host -it byangintel/clr-hivemq
```

To test this service:
```
mosquitto_sub -h <your ip address> -p 1883 -t test
```
