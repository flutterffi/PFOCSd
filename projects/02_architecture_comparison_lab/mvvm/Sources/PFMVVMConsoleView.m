#import "PFMVVMConsoleView.h"

@implementation PFMVVMConsoleView

- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels title:(NSString *)title {
    NSLog(@"[MVVM] %@", title);
    NSUInteger index = 0;
    for (PFMVVMStudyTaskViewModel *viewModel in viewModels) {
        NSLog(@"%lu. %@ | %@",
              (unsigned long)(index + 1),
              viewModel.titleText,
              viewModel.detailText);
        index += 1;
    }
}

@end
