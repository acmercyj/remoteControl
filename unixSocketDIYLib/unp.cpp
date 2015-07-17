//
//  unp.cpp
//  CPP_Primer
//
//  Created by cyj on 7/2/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

#include "unp.h"

Sigfunc* signal(int signo, Sigfunc* func){
    struct sigaction act, oact;
    act.sa_handler = func;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    if(signo == SIGALRM){
#ifdef SA_INTERRUPT
        act.sa_flags |= SA_INTERRUPT;
#endif
    }else{
#ifdef SA_RESTART
        act.sa_flags |= SA_RESTART;
#endif
    }
    if(sigaction(signo, &act, &oact) < 0) return SIG_ERR;
    return oact.sa_handler;
}

void sig_chld(int signo){
    pid_t pid;
    int stat;
    pid = wait(&stat);
    printf("child %d terminated\n", pid);
    return;
}

ssize_t readn(int fd, void *vptr, size_t n){
    size_t nleft;
    ssize_t nread;
    char* ptr;
    ptr = (char*)vptr;
    nleft = n;
    while (nleft > 0) {
        if ((nread = read(fd, ptr, nleft)) < 0) {
            if(errno == EINTR) nread = 0;
            else return -1;
        }else if(nread == 0) break;
        nleft -= nread;
        ptr += nread;
    }
    return (n - nleft);
}

ssize_t writen(int fd, const void* vptr, size_t n){
    size_t nleft;
    ssize_t nwritten;
    const char* ptr;
    
    ptr = (char*)vptr;
    nleft = n;
    while (nleft > 0) {
        if ((nwritten = write(fd, ptr, nleft)) <= 0) {
            if (nwritten < 0 && errno == EINTR)nwritten = 0;
            else return  -1;
        }
        nleft -= nwritten;
        ptr += nwritten;
    }
    return n;
}

ssize_t readline(int fd, void* vptr, size_t maxlen){
    ssize_t n, rc;
    char c, *ptr;
    ptr = (char*)vptr;
    for (n = 1; n < maxlen; ++n) {
//    again:
//        if ((rc = read(fd, &c, 1)) == 1) {
//            *ptr++ = c;
//            if (c == '\n') break;
//        }else if(rc == 0){
//            *ptr = 0;
//            return n - 1;
//        }else{
//            if(errno == EINTR) goto again;
//            return -1;
//        }
        while(true) {
            rc = read(fd, &c, 1);
            if(rc != 1 and rc != 0 and errno == EINTR) continue;
            if (rc == 1) {
                *ptr++ = c;
                if (c == '\n') {*ptr = 0; return n;}
                else break;
            }else if(rc == 0){
                *ptr = 0;
                return n - 1;
            }else{
                if(errno == EINTR) continue;
                return -1;
            }
        }
    }
    *ptr = 0;
    return n;
}

