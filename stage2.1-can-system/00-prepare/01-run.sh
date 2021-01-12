#!/bin/bash
install -v -m 755 create_fake_uname.sh		"${ROOTFS_DIR}/tmp/"
install -v -m 755 remove_fake_uname.sh		"${ROOTFS_DIR}/tmp/"
