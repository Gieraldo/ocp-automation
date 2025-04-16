#!/bin/bash

# Mendapatkan tanggal dan hostname
DATE=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

# Mendapatkan status nodes
echo "=========================================="
echo -e "\n1. Node Status:"
echo " Date: $DATE"
echo " Host: $HOSTNAME"
echo "=========================================="
oc get node

# Mendapatkan status cluster operators
echo "=========================================="
echo -e "\n2. Cluster Operators Status:"
echo " Date: $DATE"
echo " Host: $HOSTNAME"
echo "=========================================="
oc get co

# Mendapatkan status MachineConfigPool
echo "=========================================="
echo -e "\n3. MachineConfigPool Status:"
echo " Date: $DATE"
echo " Host: $HOSTNAME"
echo "=========================================="
oc get mcp

# Footer
echo -e "\n=========================================="
echo " Report generated on $DATE by $HOSTNAME"
echo "=========================================="