#!/bin/sh
KERNEL_VERSION=$1
KERNEL_ARCHITECTURE=$2
UNAME_EXECUTABLE=/usr/local/bin/uname
cat > $UNAME_EXECUTABLE << 'EOF'
#!/bin/bash
if [ "$1" == "-r" ]
then
EOF
cat >> $UNAME_EXECUTABLE  << EOF
    echo "$KERNEL_VERSION"
EOF
cat >> $UNAME_EXECUTABLE << 'EOF'
elif [ "$1" == "-m" ]
then
EOF
cat >> $UNAME_EXECUTABLE << EOF
    echo "$KERNEL_ARCHITECTURE"
fi
EOF

cat $UNAME_EXECUTABLE

chmod +x $UNAME_EXECUTABLE