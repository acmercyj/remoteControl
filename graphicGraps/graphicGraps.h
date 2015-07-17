//
//  graphicGraps.h
//  CPP_Primer
//
//  Created by cyj on 7/13/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface graphicGraps : NSObject
{
}

+(graphicGraps*)getInstance;
//-(NSString*)NSDic2json:(NSDictionary*)dic;

//-(NSString*)Dic2json:(id)dic;
-(NSImage *)capture;

-(void)drawImageInOriginSize:(NSImage*)img;

-(void)drawImage:(NSImage*)img drawRect:(NSRect)rect;

-(void)saveAsJpegWithName:(NSString*) fileName imagge:(NSImage*)img;

-(NSImage*)charData2Img:(unsigned char*) data length:(int) len;

-(unsigned char*)img2binaryData:(NSImage*)img;

@end

//用Socket的时候可能会遇到这样的协议如下
//（自己特殊举例的协议）
//US=[用户姓名]&PS=[用户密码]&UF=[16进制的图片数据的字符串]
//
//[16进制的图片数据的字符串]  格式是这样的 UF=4d4d002a0000261cd6f4d6d2f4d2d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4d3d3f4。
//当遇到要把图片等数据用16进制字符串拼接上其他数据一起传输的时候该怎么做。
//方法可以如下：
//发送端：
//1.把图片数据转二进制数据（例子发送端  以Macos 下的服务端为例子）
//NSImage *image=[NSImageimageNamed:@"beepscoreIcon.png"];
//NSData *idata=[image TIFFRepresentation];
//Byte *byte=(Byte*)[idata bytes];//NSdata->Byte
//
//2.把二进制数据转16进制字符串
////byte->16进制
//NSString *hexStr=@"";
//for(int i=0;i<[idata length];i++){
//    NSString *newHexStr = [NSStringstringWithFormat:@"%x",byte[i]&0xff]; ///16进制数
//    if([newHexStr length]==1)
//        hexStr = [NSStringstringWithFormat:@"%@0%@",hexStr,newHexStr];
//        else
//            hexStr = [NSStringstringWithFormat:@"%@%@",hexStr,newHexStr];
//            
//            
//            }
//
//NSLog(@"bytes 的16进制数为:%@",hexStr);
//这里就获得的图片数据的16进制字符串了  然后可以和其他任意数据拼接成一个字符串来发送。
//NSData *d=[hexStr dataUsingEncoding:NSUTF8StringEncoding];
//这里把拼接的字符串转NSdata就可通过Socket发送了。
//
//接收端
//1.NSData 转字符串
//NSString *s=[[NSStringalloc] initWithData:data encoding:NSUTF8StringEncoding];
//2.截取出图片，音频等的16进制字符串。其他的信息可以直接显示。图片等数据要转换后才能显示。
//3.16进制字符串转Byte数组
//Byte bytes[1];
//NSMutableData *datas=[NSMutableDatadata];
//for(int i=0;i<[s length];i++)//s为图片数据16进制字符串
//{
//    int int_ch;  /// 两位16进制数转化后的10进制数
//    
//    unichar hex_char1 = [s characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
//    int int_ch1;
//    if(hex_char1 >= '0' && hex_char1 <='9')
//        int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
//        elseif(hex_char1 >= 'A' && hex_char1 <='F')
//        int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
//        else
//            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
//            i++;
//    
//    unichar hex_char2 = [s characterAtIndex:i]; ///两位16进制数中的第二位(低位)
//    int int_ch2;
//    if(hex_char2 >= '0' && hex_char2 <='9')
//        int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
//        elseif(hex_char1 >= 'A' && hex_char1 <='F')
//        int_ch2 = hex_char2-55; //// A 的Ascll - 65
//        else
//            int_ch2 = hex_char2-87; //// a 的Ascll - 97
//            
//            int_ch = int_ch1+int_ch2;
//            NSLog(@"int_ch=%d",int_ch);
//            bytes[0] = int_ch;  ///将转化后的数放入Byte数组里
//            
//            
//            [datas appendBytes:bytes length:1];
//    
//}
//
//这里的datas就是真正的图片或音频数据了。
//
//
//UIImage *i=[UIImageimageWithData:datas]//以图片为例转换后获得真正的图片
