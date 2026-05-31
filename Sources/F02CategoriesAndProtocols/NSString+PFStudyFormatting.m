#import "NSString+PFStudyFormatting.h"

@implementation NSString (PFStudyFormatting)

- (NSString *)pf_titleCaseLabel {
    return [self capitalizedString];
}

@end
