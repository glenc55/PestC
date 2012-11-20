//
//  dataView.m
//  Pesticheck
//
//  Created by Chad Glen on 12-07-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "dataView.h"
#import "mapView.h"
@interface dataView ()

@end

@implementation dataView
@synthesize pLab;
@synthesize rgbLab;
@synthesize addComments;
@synthesize toolBar;
@synthesize navBar;

@synthesize savedImage;
@synthesize labG;


@synthesize pestStrip;
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize managedObjectContext;
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
    [super viewDidLoad];
    addComments.delegate=self;
    addComments.text=pestStrip.comments;
    textField=[[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
    [textField setBorderStyle:UITextBorderStyleBezel];
    [textField setBackgroundColor:[UIColor whiteColor]];
    
    NSString *space1 =@"    ";
    rgbLab.text =[NSString stringWithFormat:@"%@R\n\n%@G\n\n%@B\n\nPixels",space1,space1,space1];
    savedImage.image = [UIImage imageWithData:pestStrip.image];
    savedImage.layer.masksToBounds=TRUE;
    savedImage.layer.cornerRadius=8.0f;
    labG.text=[NSString stringWithFormat:@"%1.0f\n\n%1.0f\n\n%1.0f\n\n%d",[pestStrip.redC floatValue],[pestStrip.greenC floatValue],[pestStrip.blueC floatValue],[pestStrip.control intValue]];  
    
    pLab.text=[NSString stringWithFormat:@"%1.0f\n\n%1.0f\n\n%1.0f\n\n%d",[pestStrip.redT floatValue],[pestStrip.greenT floatValue],[pestStrip.blueT floatValue],[pestStrip.test intValue]]; 
    
          


	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    
    [self setLabG:nil];
   
 
    [self setSavedImage:nil];
    
    [self setNavBar:nil];
    [self setToolBar:nil];
    [self setAddComments:nil];
    [self setRgbLab:nil];
    [self setPLab:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismissData:(id)sender {
    pestStrip.comments=addComments.text;
    [self dismissModalViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1){
        [self sendDataToWebsite:self];
    }
    
}

- (IBAction)openMenu:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Email Address" message:@"This doesn't matter" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Post to Website", nil];
    [alert addSubview:textField];
    //CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 50);
    //alert.transform=myTransform;
    [alert show];
   }

- (IBAction)toMap:(id)sender {
    mapView *mV =[self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    pestStrip.comments=addComments.text;
    [mV setLat:pestStrip.latitude];
    [mV setLon:pestStrip.longitude];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd, YYYY"];
    NSString *tDate=[dateFormat stringFromDate:pestStrip.dateAdded];
    [mV setTitle:tDate];
    [self presentModalViewController:mV animated:YES];

}

- (IBAction)sendDataToWebsite:(id)sender {
    email=textField.text;
    NSString *comments=pestStrip.comments;
    NSString *postrequest=nil;
    float lat, lon, ratio;
    ratio= [pestStrip.test floatValue]/[pestStrip.control floatValue];
    NSString *pixels=[NSString stringWithFormat:@"%f : %f", [pestStrip.control floatValue],[pestStrip.test floatValue]] ;
    lat =[pestStrip.latitude floatValue];
    lon=[pestStrip.longitude floatValue];
    NSString *gps =[NSString stringWithFormat:@"%f;%f",lat,lon];
    NSString *conc=[NSString stringWithFormat:@"%f", ratio];;
    UIImage *imageSent =[UIImage imageWithData:pestStrip.image];
    
    if ([pestStrip.sent boolValue]==NO){
        pestStrip.sent = [NSNumber numberWithBool:YES];
    NSData *data1 = UIImageJPEGRepresentation(imageSent, 0.9f);
    NSString *boundary = [NSString stringWithString:@"0xKhTmLbOuNdArY"];
    NSURL *url = [NSURL URLWithString:@"http://watermap.mcmaster.ca/index.php"];
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    NSMutableData *postBody = [NSMutableData data];
    
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"email\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[email dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"pixels\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[pixels dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"gps\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[gps dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"concentration\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[conc dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"postresult\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[postrequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name= \"comments\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[comments dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"SentPhoto\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:data1];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r \n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postBody length]];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:postBody];
    
   
    NSData *returnData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSString *string = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
    NSLog(@"%@",string);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:string message:nil delegate:self cancelButtonTitle:@"Cancel"otherButtonTitles:nil, nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Already Submitted Data" message:nil delegate:self cancelButtonTitle:@"Cancel"otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}
-(void) textViewDidBeginEditing:(UITextView *)textView{
    CGRect textViewRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textViewRect.origin.y + 0.5 * textViewRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (IBAction)dismissKeyboard:(id)sender {
    pestStrip.comments=addComments.text;
     [addComments resignFirstResponder];
}
@end
