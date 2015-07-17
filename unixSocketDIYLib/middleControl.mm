//
//  socketCliDIY.cpp
//  CPP_Primer
//
//  Created by cyj on 7/2/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

//#include "unp.h"
//#include "socketDIY.h"
//#import "graphicGraps.h"
#import "middleControl.h"

//////////////////////////////OCCLI//////////////////////////////

@implementation OCSocketCliDIY

-(id) init{
    if (self = [super init]){
        OCClient = new socketCliDIY();
    }
    return self;
}

-(void) dealloc{
    if(OCClient != NULL){
        delete OCClient;
        OCClient = NULL;
    }
}

-(void) initSocket:(const char*)IP port:(int)port{
    OCClient->initSocket(IP, port);
}

-(void) sendData:(Byte*)data{
    OCClient->sendCharData(data);
}
@end

//////////////////////////////OCSRV//////////////////////////////

@implementation OCSocketSrvDIY

-(id) init{
    if(self = [super init]){
        OCServer = new socketSrvDIY();
    }
    return self;
}

-(void) dealloc{
    if(OCServer != NULL){
        delete OCServer;
        OCServer = NULL;
    }
}

-(void) initSocket:(int)port{
    OCServer->initSocket(port);
}

@end

