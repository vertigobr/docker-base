BUILD ARGS
=======

You can set the variables BASEREPO and EPELREPO before running build.sh in order to choose a specific "yum mirror" from your local network. Running local builds becomes a lot faster with a mirror around.

These are actually used as build arguments (`docker build --build-arg`). All images from `vertigo` repositories have this construct. This is intended for local builds to be *optionally* adjusted to use local yum mirrors, but leaving Docker Hub builds unaffected.

Setting BASEREPO for any non-null/empty value will:

- disable fastestmirror plugin
- comment all "mirrorlist" entries in CentOS-Base.repo
- enable "baseurl" entries replacing "mirror.centos.org" by BASEREPO in CentOS-Base.repo

Setting EPELREPO for any non-null/empty value will:

- comment all "mirrorlist" entries in epel.repo
- enable "baseurl" with value BASEREPO in epel.repo

If you want to build this image locally and also have a local yum mirror around (such as Nexus or Artifactory) you can use this at your own will. Just look at `localbuild.sh` and adjust the arguments to whatever works for you.

If you have no idea what I am talking about, don't bother. Just pulling the image from Hub will do just fine.
