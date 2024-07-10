vagrant destroy -f
vagrant box remove debian/bookworm64 bento/debian-12
vagrant box remove bento/debian-12
rm -rf .vagrant credentials
echo Done