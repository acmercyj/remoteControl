/* include unph */
/* Our own header.  Tabs are set for 4 spaces, not 8 */

#import "socketDIY.h"
////////////////////////////////////OCSocketCliDIY///////////////////////////////

#import <Foundation/Foundation.h>

@interface OCSocketCliDIY:NSObject{
@private
    socketCliDIY* OCClient;
}

-(void) initSocket:(const char*)IP port:(int)port;
-(void) sendData:(Byte*)data;
@end

////////////////////////////////////OC///////////////////////////////

@interface OCSocketSrvDIY:NSObject{
@private
    socketSrvDIY* OCServer;
}

-(void) initSocket:(int)port;

-(void) dealWithReceiveData:(int)sockfd;
@end



