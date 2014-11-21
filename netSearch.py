#! /usr/bin/env python
import socket
import sys

if len(sys.argv) > 1:
    ip = sys.argv[1]
    add = ip.split('.')
    port = 11311

    for n1 in range (0 if (add[0] == '*') else int(add[0]),256 if (add[0] == '*') else int(add[0])+1):
        for n2 in range (0 if (add[1] == '*') else int(add[1]),256 if (add[1] == '*') else int(add[1])+1):
            for n3 in range (0 if (add[2] == '*') else int(add[2]),256 if (add[2] == '*') else int(add[2])+1):
                for n4 in range (0 if (add[3] == '*') else int(add[3]),256 if (add[3] == '*') else int(add[3])+1):
                    ip = str(n1) + '.' + str(n2) + '.' + str(n3) + '.' + str(n4)

                    try:
                        s = socket.socket()
                        s.settimeout(0.1)
                        s.connect((ip,port))
                        s.send("\r\n\r\n")
                        result = s.recv(16) #See if we get any response at all
                        s.close()
                        print "ROS Master at: " + ip

                    except Exception, e:
                        pass
else:
    print "Usage: netSearch.py 192.168.1.*"
    print "Placing the * symbol will search that entire subnet address, from 0-255"

