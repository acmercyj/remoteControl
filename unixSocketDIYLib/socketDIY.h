/* include unph */
/* Our own header.  Tabs are set for 4 spaces, not 8 */

#ifndef	__socketDIY__h
#define	__socketDIY__h
#include <iostream>
#include <string>
using namespace std;

class socketDIY{
    int sockfd;
    struct sockaddr_in servaddr;
public:
    void initSocket(string IP, int port);
    
    void sendCharData(unsigned char* data, int len = 0);
    
    void threadReceiveData();
    
    void unsignedChar2String(unsigned char* input, string &output);
};

class socketSrvDIY{
    int listenfd;
    int connfd;
    pid_t childpid;
    socklen_t clilen;
    struct sockaddr_in cliaddr;
    struct sockaddr_in servaddr;
    
public:
    void initSocket(int port);
    
    void dealWithReceiveData(int sockfd);
    
    
    void drawImg(string img);
//    void sendCharData(unsigned char* data, int len = 0);
//    
//    void threadReceiveData();
//    
//    void unsignedChar2String(unsigned char* input, string &output);
};

#endif	/* __unp_h */
