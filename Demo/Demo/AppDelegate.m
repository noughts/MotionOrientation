//
//  AppDelegate.m
//  Demo
//
//  Created by 利辺羅 on 2013/08/19.
//
//

#import "AppDelegate.h"
#import "MotionOrientation.h"

@implementation AppDelegate{
	IBOutlet UIButton* _start_btn;
	IBOutlet UIButton* _stop_btn;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSBundle mainBundle] loadNibNamed:@"ViewController"
                                  owner:self
                                options:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // Register for MotionOrientation orientation changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(motionDeviceOrientationChanged:)
                                                 name:MotionOrientationChangedNotification
                                               object:nil];
    
    // Register for UIDevice orientation changes
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    return YES;
}

-(IBAction)onStartButtonTap:(id)sender{
	[[MotionOrientation sharedInstance] start];
}

-(IBAction)onStopButtonTap:(id)sender{
	[[MotionOrientation sharedInstance] stop];
}



- (void)motionDeviceOrientationChanged:(NSNotification *)notification{
	NSAssert( [NSThread isMainThread], @"" );
	_label1.text = notification.description;
	_label2.text = [self stringDescriptionForDeviceOrientation:[MotionOrientation sharedInstance].deviceOrientation];
	[UIView animateWithDuration:0.33 animations:^{
		_start_btn.transform = [MotionOrientation sharedInstance].affineTransform;
		_stop_btn.transform = [MotionOrientation sharedInstance].affineTransform;
	}];
}


- (void)deviceOrientationChanged:(NSNotification *)notification
{
    _label3.text = notification.description;
    _label4.text = [self stringDescriptionForDeviceOrientation:[UIDevice currentDevice].orientation];
}

- (NSString *)stringDescriptionForDeviceOrientation:(UIDeviceOrientation)orientation
{
    switch (orientation)
    {
        case UIDeviceOrientationPortrait:
            return @"Portrait";
        case UIDeviceOrientationPortraitUpsideDown:
            return @"PortraitUpsideDown";
        case UIDeviceOrientationLandscapeLeft:
            return @"LandscapeLeft";
        case UIDeviceOrientationLandscapeRight:
            return @"LandscapeRight";
        case UIDeviceOrientationFaceUp:
            return @"FaceUp";
        case UIDeviceOrientationFaceDown:
            return @"FaceDown";
        case UIDeviceOrientationUnknown:
        default:
            return @"Unknown";
    }
}

@end

