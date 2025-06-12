make local_server:
	hugo server --environment development
	# hugo server -D --disableFastRender -w


make push:
	git add .
	git commit -m "update"
	git push
