#!/usr/bin/ bash
#This is a test file that uses EOF to redirect multiple MySQL commands.

mysql -u root <<EOF
use performance
INSERT INTO performances(hard_drive_total,hard_drive_free,cpu_usage,vmem_total,vmem_free) VALUES(20,20,20,20,20);
EOF

exit 0
