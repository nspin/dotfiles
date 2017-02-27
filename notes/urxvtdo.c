#include <termios.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <pty.h>

int main(int argc, char **argv) {

    int master, slave, pid;
    char masters[16];

    if (openpty(&master, &slave, NULL, NULL, NULL) == -1) {
        return -1;
    }
 
    switch (pid = fork ()) {
        case -1:
            close(master);
            close(slave);
            return -1;
        case 0:
            close(master);
            setsid();
            if (ioctl(slave, TIOCSCTTY, (char *)NULL)) {
                return -1;
            }
            /* dup2(slave, 0); */
            /* dup2(slave, 1); */
            dup2(slave, 2);
            execvp("sh", (char *const[]) {"sh", "-c", argv[1], NULL});
            return -1;
        default:
            close(slave);
            sprintf(masters, "%d", master);
            execvp("urxvt", (char *const[]) {"urxvt", "-pty-fd", masters, NULL});
            return -1;
    }
}
