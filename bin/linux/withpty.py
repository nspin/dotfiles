import os
from fcntl import ioctl
from termios import TIOCSCTTY
from argparse import ArgumentParser, REMAINDER


def go(with_master, with_slave, fds):
    master, slave = os.openpty()
    os.set_inheritable(master, True)
    os.set_inheritable(slave, True)
    if os.fork():
        os.close(slave)
        os.execvp('sh', ['sh', '-c', with_master, str(master)])
    else:
        os.setsid()
        ioctl(slave, TIOCSCTTY)
        for fd in fds:
            os.dup2(slave, fd)
        os.execvp('sh', ['sh', '-c', with_slave])


def main():

    fdnames = ['in', 'out', 'err']

    parser = ArgumentParser(description='Run a command with a new urxvt instance as its controlling terminal')
    parser.add_argument('with_master', metavar='MASTER', nargs=1, help='Command to run with the file descriptor of the master as an argument')
    parser.add_argument('with_slave', metavar='SLAVE', nargs=1, help='Command to run with the slave as its controlling terminal')

    for fdname in fdnames:
        parser.add_argument(
                '-' + fdname[0],
                '--' + fdname,
                action='store_true',
                help='Slave process inherits slave pty as std{}'.format(fdname),
                )

    args = parser.parse_args()

    fds = []
    for fd, fdname in enumerate(fdnames):
        if getattr(args, fdname):
            fds.append(fd)

    go(args.with_master[0], args.with_slave[0], fds)


if __name__ == '__main__':
    main()
