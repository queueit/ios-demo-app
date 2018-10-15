#import "CupCakesTableViewController.h"
#import "Product.h"
#import "DetailsViewController.h"

@interface CupCakesTableViewController ()
@property (nonatomic, strong) NSMutableArray *products;
@end

@implementation CupCakesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *data = @[@"Cake Pan", @"Kitchen Timer", @"Paper Baking Cups", @"Frosting"];
    NSArray *imagesData = @[@"1.jpeg", @"2.jpeg", @"3.jpeg", @"4.jpeg"];
    NSArray *prices = @[@10.99f, @4.99f, @0.99f, @3.99f];
    
    self.products = [[NSMutableArray alloc]init];
    
    NSString* desc = @"For very yummy cup cakes";
    for (int i = 0; i < data.count; i++)
    {
        Product* item = [[Product alloc]instance:
                         [imagesData objectAtIndex:i]
                         title:[data objectAtIndex:i]
                         productDescription:desc
                         price:[[prices objectAtIndex:i]floatValue]];
        [self.products addObject:item];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView* content = (UIView*)cell.contentView;
    UIImageView* imageView = (UIImageView*)[content viewWithTag:1];
    imageView.image = [UIImage imageNamed:[[self.products objectAtIndex:indexPath.row]previewImage]];
    UILabel* label = (UILabel*)[content viewWithTag:2];
    label.text = [[self.products objectAtIndex:indexPath.row]title];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![[segue identifier] isEqualToString:@"DetailsSegue"]) {
        return;
    }
    
    DetailsViewController* detailsView = [segue destinationViewController];
    Product* selectedProduct = (Product*)[self.products objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailsView.product = selectedProduct;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
