#import "PFTask.h"

NSString *PFTaskStateLabel(PFTaskState state) {
    switch (state) {
        case PFTaskStateTodo:
            return @"todo";
        case PFTaskStateDoing:
            return @"doing";
        case PFTaskStateDone:
            return @"done";
    }
}

@interface PFTask ()
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSArray<NSString *> *tags;
@property (nonatomic, assign, readwrite) PFTaskState state;
@end

@implementation PFTask

- (instancetype)initWithTitle:(NSString *)title
                         tags:(NSArray<NSString *> *)tags
                        state:(PFTaskState)state {
    self = [super init];
    if (self) {
        _title = [title copy];
        _tags = [tags copy];
        _state = state;
    }
    return self;
}

@end
