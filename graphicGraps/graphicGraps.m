//
//  graphicGraps.m
//  CPP_Primer
//
//  Created by cyj on 7/13/15.
//  Copyright (c) 2015 cyj. All rights reserved.
//

@import AppKit;
#import "graphicGraps.h"
#include "OpenGL/gl.h"

static graphicGraps* _Instance = nil;

@implementation graphicGraps

+(graphicGraps*)getInstance{
    if(nil == _Instance){
        _Instance = [[graphicGraps alloc] init];
    }
    return _Instance;
}

-(NSImage *)capture{
    CGImageRef imageRef = CGDisplayCreateImage(kCGDirectMainDisplay);
    //UIImage *img = [[UIImage alloc] ]
    NSImage *image = [[NSImage alloc]initWithCGImage:imageRef size:NSZeroSize];
    //[image drawInRect:NSMakeRect(100, 100, 50, 50)];
    return image;
}

-(void)drawImage:(NSImage*)img drawRect:(NSRect)rect{//drawSize:(Size)size{
    //NSRect rec = [[NSScreen mainScreen] visibleFrame];
    if(img == nil) return;
    //NSImage *image = [NSImage imageNamed:@"image"];
    //NSLog(@"%f, %f", image.size.width, image.size.height);
    //CGFloat x = [[NSScreen mainScreen] visibleFrame].origin.x;
    //CGFloat y = [[NSScreen mainScreen] visibleFrame].origin.y;
    [img drawInRect:rect];//]
}

-(void)drawImageInOriginSize:(NSImage*)img{
    //NSRect rec = [[NSScreen mainScreen] visibleFrame];
    if(img == nil) return;
    //NSImage *image = [NSImage imageNamed:@"image"];
    //NSLog(@"%f, %f", image.size.width, image.size.height);
    [img drawInRect:[[NSScreen mainScreen] visibleFrame]];//]NSMakeRect(100, 100, 50, 50)];
}

-(void) saveAsJpegWithName:(NSString*) fileName imagge:(NSImage*)img{
    // Cache the reduced image
    NSData *imageData = [img TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];
}

-(unsigned char*)img2binaryData:(NSImage *)img{
    //NSImage *image=[NSImageimageNamed:@"beepscoreIcon.png"];
    NSData *idata=[img TIFFRepresentation];
    Byte *byte=(Byte*)[idata bytes];//NSdata->Byte
    
    return byte;
}

-(NSImage*)charData2Img:(unsigned char*) data length:(int) len{
    NSData* imgData = [[NSData alloc] initWithBytes:data length:len];
    NSImage* img = [[NSImage alloc] initWithData:imgData];
    
    return img;
}

//1.判断邮箱格式是否正确的代码
//
////利用正则表达式验证
//-(BOOL)isValidateEmail:(NSString *)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
//    return [emailTest evaluateWithObject:email];
//}
//
////2.图片压缩
////用法：UIImage *yourImage= [self imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
//
////压缩图片
//- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    // Tell the old image to draw in this newcontext, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    // End the context
//    UIGraphicsEndImageContext();
//    // Return the new image.
//    return newImage;
//}
//
////3.亲测可用的图片上传代码
//
//- (IBAction)uploadButton:(id)sender {
//    UIImage *image = [UIImage imageNamed:@"1.jpg"]; //图片名
//    NSData *imageData = UIImageJPEGRepresentation(image,0.5);//压缩比例
//    NSLog(@"字节数:%i",[imageData length]);
//    // post url
//    NSString *urlString = @"http://192.168.1.113:8090/text/UploadServlet";
//    //服务器地址
//    // setting up the request object now
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    //
//    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:@"Content-Disposition:form-data; name=\"userfile\"; filename=\"2.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]]; //上传上去的图片名字
//    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:body];
//    // NSLog(@"1-body:%@",body);
//    NSLog(@"2-request:%@",request);
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"3-测试输出：%@",returnString);
//}

//4.给imageView加载图片
//
//UIImage *myImage = [UIImage imageNamed:@"1.jpg"];
//[imageView setImage:myImage];
//[self.view addSubview:imageView];
//
//5.对图库的操作
//选择相册：
//
//UIImagePickerControllerSourceTypesourceType=UIImagePickerControllerSourceTypeCamera;
//if (![UIImagePickerControllerisSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//    sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//}
//UIImagePickerController * picker = [[UIImagePickerControlleralloc]init];
//picker.delegate = self;
//picker.allowsEditing=YES;
//picker.sourceType=sourceType;
//[self presentModalViewController:picker animated:YES];
//选择完毕：
//
//-(void)imagePickerController:(UIImagePickerController*)pickerdidFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissModalViewControllerAnimated:YES];
//    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
//    [self performSelector:@selector(selectPic:) withObject:imageafterDelay:0.1];
//}
//-(void)selectPic:(UIImage*)image
//{
//    NSLog(@"image%@",image);
//    imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    [self.viewaddSubview:imageView];
//    [self performSelectorInBackground:@selector(detect:) withObject:nil];
//}
//detect为自己定义的方法，编辑选取照片后要实现的效果
//取消选择：
//
//-(void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker
//{
//    [picker dismissModalViewControllerAnimated:YES];
//}
//
//6.跳到下个View
//
//nextWebView = [[WEBViewController alloc] initWithNibName:@"WEBViewController" bundle:nil];
//[self presentModalViewController:nextWebView animated:YES];
////创建一个UIBarButtonItem右边按钮
//UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
//[self.navigationItem setRightBarButtonItem:rightButton];
//设置navigationBar隐藏
//self.navigationController.navigationBarHidden = YES;//
//iOS开发之UIlabel多行文字自动换行 （自动折行）
//UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 180)];
//UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 150)];
//label.text = @"Hello world! Hello world!Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!Hello world! Hello world! Hello world! Hello world! Hello world! Helloworld!";
////背景颜色为红色
//label.backgroundColor = [UIColor redColor];
////设置字体颜色为白色
//label.textColor = [UIColor whiteColor];
////文字居中显示
//label.textAlignment = UITextAlignmentCenter;
////自动折行设置
//label.lineBreakMode = UILineBreakModeWordWrap;
//label.numberOfLines = 0;
//
//7.代码生成button
//
//CGRect frame = CGRectMake(0, 400, 72.0, 37.0);
//UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//button.frame = frame;
//[button setTitle:@"新添加的按钮" forState: UIControlStateNormal];
//button.backgroundColor = [UIColor clearColor];
//button.tag = 2000;
//[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//[self.view addSubview:button];
//
//8.让某个控件在View的中心位置显示
//（某个控件，比如label，View）label.center = self.view.center;
//
//9.好看的文字处理
//
//以tableView中cell的textLabel为例子：
//
//cell.backgroundColor = [UIColorscrollViewTexturedBackgroundColor];
////设置文字的字体
//cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:100.0f];
////设置文字的颜色
//cell.textLabel.textColor = [UIColor orangeColor];
////设置文字的背景颜色
//cell.textLabel.shadowColor = [UIColor whiteColor];
////设置文字的显示位置
//cell.textLabel.textAlignment = UITextAlignmentCenter;
//
//10.隐藏Status Bar
//读者可能知道一个简易的方法,那就是在程序的viewDidLoad中加入
//
//[[UIApplication sharedApplication]setStatusBarHidden:YES animated:NO];
//
//11.更改AlertView背景
//
//UIAlertView *theAlert = [[[UIAlertViewalloc] initWithTitle:@"Atention"
//                                                   message: @"I‘m a Chinese!"
//                                                  delegate:nil
//                                         cancelButtonTitle:@"Cancel"
//                                         otherButtonTitles:@"Okay",nil] autorelease];
//[theAlert show];
//UIImage *theImage = [UIImageimageNamed:@"loveChina.png"];
//theImage = [theImage stretchableImageWithLeftCapWidth:0topCapHeight:0];
//CGSize theSize = [theAlert frame].size;
//UIGraphicsBeginImageContext(theSize);
//[theImage drawInRect:CGRectMake(5, 5, theSize.width-10, theSize.height-20)];//这个地方的大小要自己调整，以适应alertview的背景颜色的大小。
//theImage = UIGraphicsGetImageFromCurrentImageContext();
//UIGraphicsEndImageContext();
//theAlert.layer.contents = (id)[theImage CGImage];
//
//12.键盘透明
//
//textField.keyboardAppearance = UIKeyboardAppearanceAlert;
//状态栏的网络活动风火轮是否旋转
//
//[UIApplication sharedApplication].networkActivityIndicatorVisible，默认值是NO。
//
//13.截取屏幕图片
////创建一个基于位图的图形上下文并指定大小为CGSizeMake(200,400)
//
//UIGraphicsBeginImageContext(CGSizeMake(200,400));
////renderInContext 呈现接受者及其子范围到指定的上下文
//[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
////返回一个基于当前图形上下文的图片
//UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
////移除栈顶的基于当前位图的图形上下文
//UIGraphicsEndImageContext();
////以png格式返回指定图片的数据
//imageData = UIImagePNGRepresentation(aImage);
//
//14.更改cell选中的背景
//
//UIView *myview = [[UIView alloc] init];
//myview.frame = CGRectMake(0, 0, 320, 47);
//myview.backgroundColor = [UIColorcolorWithPatternImage:[UIImage imageNamed:@"0006.png"]];
//cell.selectedBackgroundView = myview;
//
//15.显示图像
//
//CGRect myImageRect = CGRectMake(0.0f, 0.0f, 320.0f, 109.0f);
//UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect];
//[myImage setImage:[UIImage imageNamed:@"myImage.png"]];
//myImage.opaque = YES; //opaque是否透明
//[self.view addSubview:myImage];
//
//16.能让图片适应框的大小（没有确认）
//
//NSString*imagePath = [[NSBundle mainBundle] pathForResource:@"XcodeCrash"ofType:@"png"];
//UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
//UIImage *newImage= [image transformWidth:80.f height:240.f];
//UIImageView *imageView = [[UIImageView alloc]initWithImage:newImage];
//[newImagerelease];
//[image release];
//[self.view addSubview:imageView];
//
//17.实现点击图片进行跳转的代码：生成一个带有背景图片的button，给button绑定想要的事件！
//
//UIButton *imgButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
//[imgButton setBackgroundImage:(UIImage *)[self.imgArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//imgButton.tag=[indexPath row];
//[imgButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//-(void)save{
//    UIGraphicsBeginImageContext(mybackgroundview.bounds.size); //currentView 当前的view
//    [mybackgroundview.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
//}

//UIGraphicsBeginImageContext(CGSizeMake(320, 300)); //currentView 当前的view
//
//[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//
//UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//
//UIGraphicsEndImageContext();
//
//UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);

@end