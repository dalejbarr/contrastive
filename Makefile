REMOTE := hh1-web
DEST := /web/web2/talklab/contrastive

all : index.html

index.html : index.qmd
	quarto render index.qmd

deploy : index.html
	rsync -av --delete --exclude 'private' . "$(REMOTE):$(DEST)"
	ssh $(REMOTE) "find $(DEST) -type f -exec chmod a+r {} \;"
	ssh $(REMOTE) "find $(DEST) -type d -exec chmod a+rx {} \;"
