#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <logwrap/logwrap.h>
#include <cutils/properties.h>

#define LOG_TAG "md_ctrl"
#include <cutils/log.h>

static void
usage(void)
{
    fprintf(stderr, "%s\n%s\n",
        "usage: md_ctrl 0,   stop modem",
        "       md_ctrl 1,   start modem");
    exit(1);
}

void stop_modem(){
    int fd;
    const char *args[3];
    int rc;
    int status;

    SLOGD("Use muxreport to stop modem\n");

    args[0] = "/system/bin/muxreport";
    args[1] = "3";
    rc = android_fork_execvp(2, (char **)args, &status, false,
            true);
    if (rc != 0) {
        SLOGE("stop md1 failed due to logwrap error");
    }

    args[1] = "7";
    rc = android_fork_execvp(2, (char **)args, &status, false,
            true);
    if (rc != 0) {
        SLOGE("stop md2 failed due to logwrap error");
    }
}

void start_modem(){
    int fd;
    const char *args[3];
    int rc;
    int status;
    SLOGD("Just use muxreport to start modem\n");

    args[0] = "/system/bin/muxreport";
    args[1] = "4";
    rc = android_fork_execvp(2, (char **)args, &status, false,
            true);
    if (rc != 0) {
        SLOGE("start md1 failed due to logwrap error");
    }

    args[1] = "8";
    rc = android_fork_execvp(2, (char **)args, &status, false,
            true);
    if (rc != 0) {
        SLOGE("start md2 failed due to logwrap error");
    }
}

int
main(int argc, char **argv)
{
    int ret = 0, erg;
    int ch;

    SLOGI("there is no modem inside,return directly");


    return 0;
}


