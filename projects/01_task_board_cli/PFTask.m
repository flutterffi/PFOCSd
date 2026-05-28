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

NSNumber *PFTaskStateNumberFromLabel(NSString *label) {
    NSDictionary<NSString *, NSNumber *> *stateMap = @{
        @"todo": @(PFTaskStateTodo),
        @"doing": @(PFTaskStateDoing),
        @"done": @(PFTaskStateDone)
    };

    return stateMap[label.lowercaseString];
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

- (NSDictionary<NSString *, id> *)dictionaryRepresentation {
    return @{
        @"title": self.title,
        @"tags": self.tags,
        @"state": PFTaskStateLabel(self.state)
    };
}

@end
