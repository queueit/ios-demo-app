#import "CupCakesTableViewController.h"
#import "Product.h"
#import "DetailsViewController.h"

@interface CupCakesTableViewController ()
@property (nonatomic) NSMutableArray *products;
@end

@implementation CupCakesTableViewController

static NSString * const data[] = {[0] = @"Cake Pan", [1] = @"Kitchen Timer", [2] = @"Paper Baking Cups", [3] = @"Frosting"};
static NSString * const imagesData[] = {[0] = @"1.jpeg", [1] = @"2.jpeg", [2] = @"3.jpeg", [3] = @"4.jpeg"};
static float const prices[] = {[0] = 10.99f, [1] = 4.99f, [2] = 0.99f, [3] = 3.99f};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.products = [[NSMutableArray alloc]init];
    
    NSString* desc = @"For very yummy cup cakes";
    for (int i = 0; i < 4; i++)
    {
        Product* item = [[Product alloc]instance:
                         imagesData[i]
                         title:data[i]
                         productDescription:desc
                         price:prices[i]];
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
