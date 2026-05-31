#import "PFMVPStudyPlannerView.h"

@implementation PFMVPConsoleView

- (void)displayLines:(NSArray<NSString *> *)lines title:(NSString *)title {
    NSLog(@"[MVP] %@", title);
    for (NSString *line in lines) {
        NSLog(@"%@", line);
    }
}

- (void)displaySavedPath:(NSString *)path {
    NSLog(@"saved path -> %@", path);
}

@end
