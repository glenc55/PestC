//
//  mainView.m
//  Pesticheck
//
//  Created by Chad Glen on 12-07-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mainView.h"
#import "commentaryPage.h"
@interface mainView ()

@end

@implementation mainView

@synthesize locationManager;
@synthesize testLab;
@synthesize controlLab;
@synthesize startText;
@synthesize arrowImgs;
@synthesize sImage;
@synthesize line;



@synthesize tapResults;
@synthesize check1;

@synthesize managedObjectContext;

bool tookPic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    tookPic=FALSE;
     [[self locationManager] startUpdatingLocation];
    //line = [[lineSplit alloc] init];
    activ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activ.center=self.view.center;
    [activ setHidesWhenStopped:TRUE];
    check1.hidden=TRUE;
    UIPicker = [[UIImagePickerController alloc] init];
    UIPicker.allowsEditing=YES;
    UIPicker.delegate=self;
   
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    if([defaults objectForKey:@"FirstTime"] == nil) 
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Have you read the publication relating to this application?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
//        [alert setTag:5];
//        [alert show];
//
//    }  
//    [defaults setObject:@"firsttime" forKey:@"FirstTime"]; 
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setSImage:nil];
    [self setTestLab:nil];
    [self setControlLab:nil];
    [self setStartText:nil];
    [self setArrowImgs:nil];
    [self setLine:nil];
    [self setCheck1:nil];


    [self setTapResults:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)imgSelect:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        check1.hidden=TRUE;
        if (line){
            [line removeFromSuperview];
        }
        [self presentModalViewController:UIPicker animated:YES];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Camera is not available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    } 

}

- (IBAction)startAnalysis:(id)sender {
    
    PestStrip *pestStrip = [NSEntityDescription insertNewObjectForEntityForName:@"PestStrip" inManagedObjectContext:managedObjectContext];
    
    float x=line.myPath.currentPoint.x/320;
    float y=(line.vertLine.currentPoint.y-174)/242;
    
    UIImage* image = sImage.image;
    CGSize size =[image size];
    
    CGRect rect = CGRectMake(0, (size.height*y), (size.width*x), size.height*(1-y));
    CGRect rect1 =CGRectMake((size.width*x), (size.height*y), (size.width*(1-x)), size.height*(1-y));
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    CGImageRef imageRef1 = CGImageCreateWithImageInRect([image CGImage], rect1);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    UIImage *image2=[UIImage imageWithCGImage:imageRef1];
    CGSize size1=[image1 size];
    CGSize size2=[image2 size];
    
    
    NSArray *result1 = [[NSArray alloc] initWithArray:[self getRGBAsFromImage:image1 atX:0 andY:0 count:(size1.width*size1.height)]];
    NSArray *result2 = [[NSArray alloc] initWithArray:[self getRGBAsFromImage:image2 atX:0 andY:0 count:(size2.width*size2.height)]];
    
    
    int rowC,rowT,colC,colT,count=0,bluePixels=0,bluePixelsT=0;
    float RGB[3], RGBT[3];
    float ref,ratRB;
    int red=0,green=1,blue=2;

    for (int i=0;i<2;i++){
        RGB[i]=0;
        RGBT[i]=0;
    }
        
    rowC=image1.size.width;
    rowT=image2.size.width;
    colC=image1.size.height;
    colT=image2.size.height;
    
    
    for (int i=0;i<colC;i++){
        for (int j=0;j<rowC;j++){
            count = (i*rowC+j);
            Pixel *pixel = [result1 objectAtIndex:count];
            ref=0.3*pixel.red+0.59*pixel.green+0.11*pixel.blue;
            ratRB= pixel.red/pixel.blue;
          
            if (ref>0.3 && ratRB<0.8 && pixel.red<0.8){
      
                RGB[red]+=0.5*(81-100*ratRB)*pixel.red;
                RGB[blue]+=0.5*(81-100*ratRB)*pixel.blue;
                RGB[green]+=0.5*(81-100*ratRB)*pixel.green;
                bluePixels+=0.5*(81-100*ratRB);
         
            }
            }
        
    }
    for (int i=0;i<colT;i++){
        for (int j=0;j<rowT;j++){
            count = (i*rowT+j);
            
            Pixel *pixel = [result2 objectAtIndex:count];
            ref=0.3*pixel.red+0.59*pixel.green+0.11*pixel.blue;
            ratRB= pixel.red/pixel.blue;
                       if (ref>0.3 && ratRB<0.8 && pixel.red<0.8){
                
                RGBT[red]+=0.5*(81-100*ratRB)*pixel.red;
                RGBT[blue]+=0.5*(81-100*ratRB)*pixel.blue;
                RGBT[green]+=0.5*(81-100*ratRB)*pixel.green;
                bluePixelsT+=0.5*(81-100*ratRB);
            
            }
           }
        
    }
  
    for (int i=0;i<3;i++){
        if (bluePixelsT==0){
            RGBT[i]=0;
        }else {
            RGBT[i]=(RGBT[i]/bluePixelsT)*255;
        }
        if (bluePixels==0){
            RGB[i]=0;
            
        }else {
            RGB[i]=(RGB[i]/bluePixels)*255;
        }
    }

    if (bluePixelsT>bluePixels){
        bluePixelsT=bluePixels;
    }
    CLLocation *locate = [locationManager location];
    CLLocationCoordinate2D coordinate = [locate coordinate];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    pestStrip.image=imageData;
    pestStrip.latitude=[NSNumber numberWithDouble:coordinate.latitude];
    pestStrip.longitude=[NSNumber numberWithDouble:coordinate.longitude];
    pestStrip.test=[NSNumber numberWithInt:bluePixelsT];
    pestStrip.control=[NSNumber numberWithInt:bluePixels]; 
    pestStrip.test=[NSNumber numberWithInt:bluePixelsT];
    pestStrip.control=[NSNumber numberWithInt:bluePixels];
    pestStrip.redC=[NSNumber numberWithFloat:RGB[red]];
    pestStrip.redT=[NSNumber numberWithFloat:RGBT[red]];
    pestStrip.greenC=[NSNumber numberWithFloat:RGB[green]];
    pestStrip.greenT=[NSNumber numberWithFloat:RGBT[green]];
    pestStrip.blueC=[NSNumber numberWithFloat:RGB[blue]];
    pestStrip.blueT=[NSNumber numberWithFloat:RGBT[blue]];
    pestStrip.dateAdded=[NSDate date];
    
    
    check1.hidden=FALSE;
    tapResults.hidden=FALSE;
    [line removeFromSuperview];
    
    NSError *error1;
    if (![managedObjectContext save:&error1]){
        NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
    }
    

}
- (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    const CGFloat whitePoint[] = {0.95047, 1.0, 1.08883};
    const CGFloat blackPoint[] = {0, 0, 0};
    const CGFloat gamma[] = {1, 1, 1};
    const CGFloat matrix[] = {0.449695, 0.244634, 0.0251829, 0.316251, 0.672034, 0.141184, 0.18452, 0.0833318, 0.922602 };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateCalibratedRGB(whitePoint, blackPoint, gamma, matrix);
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) /255;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) /255;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) /255;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) /255;
        byteIndex += 4;
        
        Pixel *pixel=[[Pixel alloc] init];
        [pixel withRed:red withGreen:green withBlue:blue andAlpha:alpha];
        [result addObject:pixel];
    }
    
    free(rawData);
    
    return result;
}


- (IBAction)takePic:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        check1.hidden=TRUE;
        tookPic=TRUE;
        if (line){
            [line removeFromSuperview];
        }
		[self presentModalViewController:UIPicker animated:YES];
        
      
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Camera is not available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
	}

}
-(void)imagePickerControllerDidCancel:UIPicker
{
    if (tookPic==TRUE){
        tookPic=FALSE;
      
    }
    if (line){
        [line removeFromSuperview];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerController:UIPicker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* image = [info objectForKey: UIImagePickerControllerEditedImage];
    sImage.image = image;
    
    line= [[lineSplit alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [self.view insertSubview:line aboveSubview:sImage];
    for (int i=0;i<3;i++){
        [[arrowImgs objectAtIndex:i] setHidden:TRUE];
        [[startText objectAtIndex:i] setHidden:TRUE];
    }
    
    if (tookPic == TRUE){
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,  
                                   @selector(image:finishedSavingWithError:contextInfo:),
                                   nil);
        tookPic = FALSE;
  
        
    }
    
    controlLab.hidden=FALSE;
    testLab.hidden=FALSE;

    [self dismissModalViewControllerAnimated:YES];
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toTable"]){
        tableView *tV =[segue destinationViewController];
        [tV setManagedObjectContext:managedObjectContext];
    }
}
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:kCLLocationAccuracyNearestTenMeters];
	[locationManager setDelegate:self];
	
	return locationManager;
}
//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag==5){
//        if (buttonIndex==1){
//            commentaryPage *cP =[self.storyboard instantiateViewControllerWithIdentifier:@"commentPage"];
//            [self presentModalViewController:cP animated:YES];
//
//            NSLog(@"you pushed yes!");
//        }
//    }
//    
//}

- (IBAction)toComments:(id)sender {
    
    commentaryPage *cP =[self.storyboard instantiateViewControllerWithIdentifier:@"commentPage"];
    [self presentModalViewController:cP animated:YES];
}

@end
