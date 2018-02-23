NAME=simp
VERSION=1.0.6

rpm:	dist
	rpmbuild -ta dist/simp-poller-$(VERSION).tar.gz
	rpmbuild -ta dist/simp-data-$(VERSION).tar.gz
	rpmbuild -ta dist/simp-comp-$(VERSION).tar.gz

test:
	/usr/bin/perl t/TEST $(TEST_VERBOSE)

test_jenkins:
	/usr/bin/perl t/TEST $(TEST_VERBOSE) --formatter=TAP::Formatter::Console

clean:
	rm -rf dist
	rm -rf tap
	rm -rf cover_db

dist: 	
	rm -rf dist
	mkdir -p dist/simp-data-$(VERSION)/lib/GRNOC/Simp
	mkdir -p dist/simp-data-$(VERSION)/bin
	mkdir -p dist/simp-data-$(VERSION)/conf
	mkdir -p dist/simp-comp-$(VERSION)/lib/GRNOC/Simp
	mkdir -p dist/simp-comp-$(VERSION)/bin
	mkdir -p dist/simp-comp-$(VERSION)/conf
	mkdir -p dist/simp-poller-$(VERSION)/lib/GRNOC/Simp
	mkdir -p dist/simp-poller-$(VERSION)/bin
	mkdir -p dist/simp-poller-$(VERSION)/conf/hosts.d
	cp -r lib/GRNOC/Simp/Poller* dist/simp-poller-$(VERSION)/lib/GRNOC/Simp
	cp -r lib/GRNOC/Simp/Data* dist/simp-data-$(VERSION)/lib/GRNOC/Simp
	cp -r lib/GRNOC/Simp/Comp* dist/simp-comp-$(VERSION)/lib/GRNOC/Simp
	cp -r bin/comp-data.pl dist/simp-comp-$(VERSION)/bin/
	cp -r bin/simp-data.pl dist/simp-data-$(VERSION)/bin/
	cp -r bin/simp-poller.pl dist/simp-poller-$(VERSION)/bin/
	cp -r conf/compDataConfig.xml dist/simp-comp-$(VERSION)/conf/
	cp -r conf/logging.conf dist/simp-comp-$(VERSION)/conf/
	cp -r conf/comp_data.init dist/simp-comp-$(VERSION)/conf/
	cp -r conf/simpDataConfig.xml dist/simp-data-$(VERSION)/conf/
	cp -r conf/logging.conf dist/simp-data-$(VERSION)/conf/
	cp -r conf/simp_data.init dist/simp-data-$(VERSION)/conf/
	cp -r conf/config.xml dist/simp-poller-$(VERSION)/conf/
	cp -r conf/logging.conf dist/simp-poller-$(VERSION)/conf/
	cp -r conf/simp-poller.init dist/simp-poller-$(VERSION)/conf/
	cp -r conf/hosts.d/* dist/simp-poller-$(VERSION)/conf/hosts.d/
	cp -r simp-data.spec dist/simp-data-$(VERSION)/
	cp -r simp-comp.spec dist/simp-comp-$(VERSION)/
	cp -r simp-poller.spec dist/simp-poller-$(VERSION)/
	cd dist; tar -czvf simp-poller-$(VERSION).tar.gz simp-poller-$(VERSION)/ --exclude .svn --exclude .git
	cd dist; tar -czvf simp-data-$(VERSION).tar.gz simp-data-$(VERSION)/ --exclude .svn --exclude .git
	cd dist; tar -czvf simp-comp-$(VERSION).tar.gz simp-comp-$(VERSION)/ --exclude .svn --exclude .git