make server:
	hugo server -D --disableFastRender -w

make push:
	git add .
	git commit -m "update"
	git push origin master
