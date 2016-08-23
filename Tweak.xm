@interface SBModeViewController : NSObject
-(void)setViewControllers:(NSArray*)arr;
-(NSArray*)viewControllers;
-(void)setSelectedViewController:(id)vc;
-(void)viewDidLoad;
@end


%hook SBModeViewController
-(void)setViewControllers:(NSArray*)arr {
    for(id vc in arr) { // find Notifactions Page
        if([vc isKindOfClass:[%c(SBNotificationsViewController) class]] || // iOS 9
           [vc isKindOfClass:[%c(SBNotificationsModeViewController) class]]) { //iOS 8
            NSMutableArray* sorted = [arr mutableCopy];
            [sorted removeObject:vc];
            [sorted insertObject:vc atIndex:0]; // put it in first place
            arr = sorted;
            break;
        }
    }
    
    %orig;
}

-(void)viewDidLoad {
    %orig;
    
    NSArray* vcs = [self viewControllers];
    if(vcs) {
        id firstVC = [vcs firstObject];
        if(firstVC &&
                        ([firstVC isKindOfClass:[%c(SBNotificationsViewController) class]] || // iOS 9
                         [firstVC isKindOfClass:[%c(SBNotificationsModeViewController) class]])) { //iOS 8
            [self setSelectedViewController:firstVC]; // preselect it the first time
        }
    }
}
%end