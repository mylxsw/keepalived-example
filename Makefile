test:
	curl http://192.168.88.100/
	curl http://192.168.88.100/
	curl http://192.168.88.100/
	curl http://192.168.88.100/

stop-master:
	cd keepalived && vagrant halt -f && cd ..

start-master:
	cd keepalived && vagrant up && cd ..

create:
	cd node-1 && vagrant up && cd ..
	cd node-2 && vagrant up && cd ..
	cd keepalived && vagrant up && cd ..
	cd keepalived-backup && vagrant up && cd ..

destroy:
	cd node-1 && vagrant destroy -f && cd ..
	cd node-2 && vagrant destroy -f && cd ..
	cd keepalived && vagrant destroy -f && cd ..
	cd keepalived-backup && vagrant destroy -f && cd ..
	

