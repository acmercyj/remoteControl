//
//  socketCliDIY.cpp
//  CPP_Primer
//
//  Created by cyj on 7/2/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

#include "unp.h"
#include "socketDIY.h"
#import "graphicGraps.h"

void socketCliDIY::initSocket(string IP, int port){
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(port);
    inet_pton(AF_INET, IP.c_str(), &servaddr.sin_addr);
    connect(sockfd, (SA*)&servaddr, sizeof(servaddr));
}

void socketCliDIY::sendCharData(unsigned char* data, int len){
    //writen(sockfd, data, strlen(data));
    
    
    //char sendline[MAXLINE];
    string sendLine;
    unsignedChar2String(data, sendLine);//string.format() //string(data);
    int pos = 0;
    while(pos < sendLine.length()){
        string block = sendLine.substr(pos, MAXLINE);
        pos += MAXLINE;
        writen(sockfd, block.c_str(), block.length());
    }
}

void socketCliDIY::unsignedChar2String(unsigned char* input, string &output){
    output = reinterpret_cast<char*>(input);
}

void socketCliDIY::threadReceiveData(){
    char recvline[MAXLINE];
    if(readline(sockfd, recvline, MAXLINE) == 0){
        printf("str_cli: server terminated prematurely");
        exit(0);
    }
    fputs(recvline, stdout);
}

void socketSrvDIY::dealWithReceiveData(int sockfd){
    ssize_t n;
    char buf[MAXLINE];
    string img;
    do{
        img = "";
        while((n = read(sockfd, buf, MAXLINE)) > 0){
            //writen(sockfd, buf, n);
            string temp = buf;
            img = img + temp;
        }
        if(n < 0){
            NSImage* NSImg = [[graphicGraps getInstance] charData2Img:(unsigned char*)img.c_str() length:img.length()];
            [[graphicGraps getInstance] drawImageInOriginSize:NSImg];
            //drawImg(<#string img#>);
            printf("str_echo: read error");
            break;
        }
    }while(n < 0 && errno == EINTR);
}


void socketSrvDIY::initSocket(int port){
    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(port);
    
    bind(listenfd, (SA*)&servaddr, sizeof(servaddr));
    listen(listenfd, LISTENQ);
    for(;;){
        clilen = sizeof(cliaddr);
        connfd = accept(listenfd, (SA*)&cliaddr, &clilen);
        if((childpid = fork()) == 0){
            close(listenfd);
            dealWithReceiveData(connfd);
            exit(0);
        }
        close(connfd);
    }
}

////////////////////////////////OCCLI//////////////////////////////
//
//@implementation OCSocketCliDIY
//
//-(id) init{
//    if (self = [super init]){
//        OCClient = new socketCliDIY();
//    }
//    return self;
//}
//
//-(void) dealloc{
//    if(OCClient != NULL){
//        delete OCClient;
//        OCClient = NULL;
//    }
//}
//
//-(void) initSocket:(const char*)IP port:(int)port{
//    OCClient->initSocket(IP, port);
//}
//
//-(void) sendData:(Byte*)data{
//    OCClient->sendCharData(data);
//}
//@end
//
////////////////////////////////OCSRV//////////////////////////////
//
//@implementation OCSocketSrvDIY
//
//-(id) init{
//    if(self = [super init]){
//        OCServer = new socketSrvDIY();
//    }
//    return self;
//}
//
//-(void) dealloc{
//    if(OCServer != NULL){
//        delete OCServer;
//        OCServer = NULL;
//    }
//}
//
//-(void) initSocket:(int)port{
//    OCServer->initSocket(port);
//}
//
//@end

