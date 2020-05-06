#import "DetailsViewController.h"
#import "Product.h"

@interface DetailsViewController ()
@property (nonatomic, strong)QueueITEngine* engine;
@property (weak, nonatomic) IBOutlet UIImageView *detailsPreviewImage;
@property (weak, nonatomic) IBOutlet UILabel *detailsDescription;
@property (weak, nonatomic) IBOutlet UILabel *detailsPrice;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitle;
@property (weak, nonatomic) IBOutlet UIStackView *detailsStackView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initQueueIt];
    [self runQueueIt];
}

-(void)initQueueIt {
    NSString* customerId = @"ticketania"; // Required
    NSString* eventAlias = @"cuppercakes"; // Required
    NSString* layoutName = nil; // Optional (pass nil if no layout specified)
    NSString* language = nil; // Optional (pass nil if no language specified)
    
    self.engine = [[QueueITEngine alloc]initWithHost:self customerId:customerId eventOrAliasId:eventAlias layoutName:layoutName language:language];
    //[self.engine setViewDelay:5]; // Optional delay parameter you can specify (in case you want to inject some animation before Queue-It UIWebView or WKWebView will appear
    self.engine.queuePassedDelegate = self; // Invoked once the user is passed the queue
    self.engine.queueViewWillOpenDelegate = self; // Invoked to notify that Queue-It UIWebView or WKWebview will open
    self.engine.queueDisabledDelegate = self; // Invoked to notify that queue is disabled
    self.engine.queueITUnavailableDelegate = self; // Invoked in case QueueIT is unavailable (500 errors)
    self.engine.queueUserExitedDelegate = self; // Invoked when user chooses to leave the queue
}

-(void)runQueueIt {
    @try
    {
        NSError* error = nil;
        BOOL success = [self.engine run:&error];
        if (!success) {
            if ([error code] == NetworkUnavailable) {
                // Thrown when Queue-It detects no internet connectivity
                NSLog(@"%ld", (long)[error code]);
                NSLog(@"Network unavailable was caught in DetailsViewController");
                NSLog(@"isRequestInProgress - %@", self.engine.isRequestInProgress ? @"YES" : @"NO");
            }
            else if ([error code] == RequestAlreadyInProgress) {
                // Thrown when request to Queue-It has already been made and currently in progress. In general you can ignore this.
            }
            else {
                NSLog(@"Unknown error was returned by QueueITEngine in DetailsViewController");
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception was caught in DetailsViewController");
    }
    
    //[self testMany]; // Uncomment if you wish to test the in progress error
}

-(void) testMany {
    @try
    {
        for (int i = 0; i < 10; i++) {
            NSError* error = nil;
            BOOL success = [self.engine run:&error];
            if (!success) {
                if ([error code] == NetworkUnavailable) {
                    // Thrown when Queue-It detects no internet connectivity
                    NSLog(@"%ld", (long)[error code]);
                    NSLog(@"Network unavailable was caught in DetailsViewController");
                    NSLog(@"isRequestInProgress - %@", self.engine.isRequestInProgress ? @"YES" : @"NO");
                }
                else if ([error code] == RequestAlreadyInProgress) {
                    NSLog(@"Request already in progress was caught in DetailsViewController");
                }
                else {
                    NSLog(@"Unknown error was returned by QueueITEngine in testMany in DetailsViewController");
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception was caught in DetailsViewController");
    }
}

-(void) notifyYourTurn: (QueuePassedInfo*) queuePassedInfo {
    // Callback for engine.queuePassedDelegate
    self.detailsTitle.text = self.product.title;
    self.detailsPreviewImage.image = [UIImage imageNamed:self.product.previewImage];
    self.detailsDescription.text = self.product.productDescription;
    self.detailsPrice.text = [NSString stringWithFormat:@"Price: %.02f$", self.product.price];
    NSLog(@"DONE!!!");    
}

-(void) notifyQueueViewWillOpen {
    // Callback for engine.queueViewWillOpenDelegate
    NSLog(@"Queue will open");
}

-(void) notifyQueueDisabled {
    // Callback for engine.queueDisabledDelegate
    NSLog(@"Queue is disabled");
}

-(void) notifyQueueITUnavailable: (NSString *) errorMessage {
    // Callback for engine.queueITUnavailableDelegate
    NSLog(@"QueueIT is currently unavailable");
}

-(void) notifyUserExited {
    // Callback for engine.queueUserExitedDelegate
    NSLog(@"User has left the queue");
}
@end
