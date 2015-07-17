//
//  AppDelegate.m
//  justOC(cocoa)
//
//  Created by cyj on 7/13/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

#import "AppDelegate.h"


#import "graphicGraps.h"
//#import "unp.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //graphicGraps* g = [[graphicGraps alloc] init];
    //[g capture];
    //[[[graphicGraps alloc] init] capture];
    //NSImage* img = [[graphicGraps getInstance] capture];
    //[[graphicGraps getInstance] drawImageInOriginSize:img];
    
    //OCSocketSrvDIY* srv = [[OCSocketSrvDIY alloc] init];
    //[srv initSocket:SERV_PORT];
    
    client = [[OCSocketCliDIY alloc] init];
    [client initSocket:"192.168.1.75" port:SERV_PORT];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)applicationWillUpdate:(NSNotification *)notification{
    //[[self _frame] ]
    //self._frame.size;
    
    //NSWindow *window = [self.box window];
    //[window frame].size.height;
    
//    NSImage* img = [[graphicGraps getInstance] capture];
//    [[graphicGraps getInstance] drawImage:img drawRect:[self.window frame]];
    //[self.window getFrame].size;
    //NSLog(@"coming");
    
    NSImage* img = [[graphicGraps getInstance] capture];
    Byte* imgData = [[graphicGraps getInstance] img2binaryData:img];
    [client sendData:imgData];
}

- (void)applicationDidUpdate:(NSNotification *)notification{
    NSLog(@"coming");
}

- (void)awakeFromNib {
    // 使窗口屏幕居中
    [self.window center];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification{
    NSLog(@"coming");
}

@end
