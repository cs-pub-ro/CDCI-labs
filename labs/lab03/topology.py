#!/usr/bin/python3
# (c) Mihai Chiroiu - CDCI (https://ocw.cs.pub.ro/courses/cdci)
# Lab03 — Web Application Security (Juice Shop)

from mininet.net import Mininet, Containernet
from mininet.node import Host, OVSBridge, Node, Controller, Docker, UserSwitch, OVSSwitch
from mininet.nodelib import NAT
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import Intf
from subprocess import call
import subprocess

def myNetwork():
    net = Containernet(controller=Controller)

    info( '*** Adding controller\n' )
    net.addController(name='c0')

    info( '*** Add switches\n')
    s1 = net.addSwitch('s1', cls=OVSSwitch)

    info( '*** Add hosts\n')
    # Attacker container (cdci_base with curl, jq, nikto, sqlmap, ffuf)
    mn_args = {
        "network_mode": "none",
        "dimage": "cdci_base",
        "ip": "10.0.0.2/24",
    }
    attacker = net.addDocker('attacker', **mn_args)

    # Juice Shop container
    mn_args = {
        "network_mode": "none",
        "dimage": "juiceshop",
        "dcmd": "/usr/local/bin/start_juiceshop.sh",
        "ip": "10.0.0.3/24",
    }
    juiceshop = net.addDocker('juiceshop', **mn_args)

    info( '*** Add links\n')
    net.addLink( attacker, s1 )
    net.addLink( juiceshop, s1 )

    info( '*** Starting network\n')
    net.start()

    # Juice Shop needs a few seconds to start up
    info( '*** Waiting for Juice Shop to start...\n')
    juiceshop.cmd('sleep 5')

    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'critical' )
    myNetwork()
