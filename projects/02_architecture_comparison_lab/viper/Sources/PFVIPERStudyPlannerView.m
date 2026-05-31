#import "PFVIPERStudyPlannerView.h"

@implementation PFVIPERConsoleView

- (void)displayLines:(NSArray<NSString *> *)lines title:(NSString *)title {
    NSLog(@"[VIPER] %@", title);
    for (NSString *line in lines) {
        NSLog(@"%@", line);
    }
}

- (void)displayActionMessage:(NSString *)message {
    NSLog(@"%@", message);
}

- (void)displayMessage:(NSString *)message title:(NSString *)title {
    NSLog(@"[VIPER] %@", title);
    NSLog(@"%@", message);
}

@end
