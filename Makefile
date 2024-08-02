BUILDDIR := $(CURDIR)/build
INSTALLDIR := /usr/local/bin/
VERSION := sa2477errorhandling$(shell date +%s)
all: gocheck clean build
	echo Build complete!
	echo Run 'make install' to copy files to $(INSTALLDIR)
setverison:
	echo $(VERSION)
	mkdir -p $(BUILDDIR)
	cp ssllabs-scan-v4.go ssllabs-scan-v4-register.go $(BUILDDIR)/
	sed -i 's/\$$makeversion\$$/$(VERSION)/g' $(BUILDDIR)/ssllabs-scan-v4.go
build: setverison
	go build -o $(BUILDDIR) $(BUILDDIR)/ssllabs-scan-v4.go
	go build -o $(BUILDDIR) $(BUILDDIR)/ssllabs-scan-v4-register.go
	ls -l $(BUILDDIR)
clean:
	touch $(BUILDDIR)
	rm -r $(BUILDDIR)
gocheck:
	echo is go 1.19?
	go version || ( echo ERROR Bad exit value for 'go version' && exit 2 )
install:
	cp -v $(BUILDDIR)/ssllabs-scan-v4 $(BUILDDIR)/ssllabs-scan-v4-register $(INSTALLDIR) || ( echo "ERROR Copy to $(INSTALLDIR) failed. Try 'sudo make install'" && exit 3 )
