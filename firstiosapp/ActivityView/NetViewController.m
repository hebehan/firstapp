//
//  NetViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/7/31.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "NetViewController.h"
#import "Toast.h"

@interface NetViewController()<UIScrollViewDelegate,NSURLConnectionDataDelegate>

@end
@implementation NetViewController{
    UIScrollView *_scrollView;
    UILabel *_resultLabel;
    UIButton *_getBut;
    UIActivityIndicatorView *_indicatorView;
}

- (void)viewDidLoad {
    self.title = @"网络相关";
    [self setStatusBarState:UIStatusBarStyleDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = self.view.center;
    _indicatorView.backgroundColor = [UIColor lightGrayColor];
    //设置背景色
    _indicatorView.backgroundColor = [UIColor blackColor];

    //设置背景透明
    _indicatorView.alpha = 0.5;

    //设置背景为圆角矩形
    _indicatorView.layer.cornerRadius = 6;
    _indicatorView.layer.masksToBounds = YES;
//    self.view.frame = CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64);
    CGRect buttonframe = CGRectMake(0,64,SCREEN_WIDTH*0.2,40);
//    for (int i = 0; i < 5; i++) {
//        UIButton *getButton = [[UIButton alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH*0.2,64,SCREEN_WIDTH*0.15,50)];
//        getButton.backgroundColor = [UIColor redColor];
//        [self.view addSubview:getButton];
//    }
    _getBut = [[UIButton alloc] initWithFrame:buttonframe];
    _getBut.backgroundColor = [UIColor cyanColor];
    [_getBut setTitle:@"同步GET" forState:UIControlStateNormal];
    [_getBut setFont:[UIFont systemFontOfSize:12]];
    [_getBut addTarget:self action:@selector(synchttpGet) forControlEvents:UIControlEventTouchUpInside];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,buttonframe.size.height+64+20,SCREEN_WIDTH,300)];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.59 green:0.76 blue:0.65 alpha:1.00];
    _scrollView.scrollEnabled = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT*10);
    UIButton *syncPostButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonframe.size.width*1+SCREEN_WIDTH*0.05,buttonframe.origin.y,buttonframe.size.width,buttonframe.size.height)];
    syncPostButton.backgroundColor = [UIColor cyanColor];
    [syncPostButton setTitle:@"同步POST" forState:UIControlStateNormal];
    [syncPostButton setFont:[UIFont systemFontOfSize:12]];
    syncPostButton.titleLabel.textColor = [UIColor blackColor];
    [syncPostButton addTarget:self action:@selector(syncHttpPost) forControlEvents:UIControlEventTouchUpInside];

    UIButton *asyncGetButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonframe.size.width*2+2*SCREEN_WIDTH*0.05,buttonframe.origin.y,buttonframe.size.width,buttonframe.size.height)];
    asyncGetButton.backgroundColor = [UIColor cyanColor];
    [asyncGetButton setTitle:@"异步GET" forState:UIControlStateNormal];
    [asyncGetButton setFont:[UIFont systemFontOfSize:12]];
    asyncGetButton.titleLabel.textColor = [UIColor blackColor];
    [asyncGetButton addTarget:self action:@selector(asyncGet) forControlEvents:UIControlEventTouchUpInside];

    UIButton *asyncPostButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonframe.size.width*3+3*SCREEN_WIDTH*0.05,buttonframe.origin.y,buttonframe.size.width,buttonframe.size.height)];
    asyncPostButton.backgroundColor = [UIColor cyanColor];
    [asyncPostButton setTitle:@"异步POST" forState:UIControlStateNormal];
    [asyncPostButton setFont:[UIFont systemFontOfSize:12]];
    asyncPostButton.titleLabel.textColor = [UIColor blackColor];
    [asyncPostButton addTarget:self action:@selector(asyncPost) forControlEvents:UIControlEventTouchUpInside];

    _resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _resultLabel.textColor = [UIColor blackColor];
    _resultLabel.backgroundColor = [UIColor blueColor];
    _resultLabel.font = [UIFont systemFontOfSize:15];
//    _resultLabel.frame = _scrollView.bounds;
    _resultLabel.numberOfLines = 0;
//    _scrollView.frame = CGRectMake(_scrollView.frame.origin.x,_scrollView.frame.origin.y,_scrollView.frame.size.width,size.height);
    [self.view addSubview:_scrollView];
    [self.view addSubview:_getBut];
    [self.view addSubview:syncPostButton];
    [self.view addSubview:asyncGetButton];
    [self.view addSubview:asyncPostButton];
    [_scrollView addSubview:_resultLabel];


}
/**
 * 同步get
 */
-(void)synchttpGet{
    NSString *urlString = baseurl;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSHTTPURLResponse *response1 = (NSHTTPURLResponse *)response;
//    NSLog(@"%@",response1.allHeaderFields.description);
//    NSLog(@"%d",response1.statusCode);
//    NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    result = @"dgdsfdffsgsdg";
//    NSLog(result);
    [self showResult:result];


}

/**
 * 同步post
 */
-(void)syncHttpPost{
    NSString *urlstring = [baseurl stringByAppendingString:@"App/getToken"];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSString *params = @"app_version=1.0&server_version=ios&appid=123456";
    NSData *paramsdata = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:paramsdata];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    CGSize size = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH*0.9,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//    _resultLabel.frame = CGRectMake(SCREEN_WIDTH*0.05,_scrollView.bounds.origin.y,size.width,size.height);
//    NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [self showResult:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//    _resultLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    _resultLabel.frame = _scrollView.bounds;
//    _resultLabel.font = [UIFont systemFontOfSize:15];
}
/**
 * 异步get
 */
-(void)asyncGet{
    [self showLoading];
    NSString *urlstring = @"https://www.gravatar.com/avatar/5663b0f39b9b536eea0c09703fb84be3?s=32&d=identicon&r=PG";
//    NSString *urlstring = baseurl;
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self closeLoading];
        NSHTTPURLResponse *response1 = (NSHTTPURLResponse *)response;
        NSLog(response1.allHeaderFields.description);
        NSLog(response1.MIMEType);
        UIImage *image = [[UIImage alloc] initWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [_scrollView addSubview:imageView];
//        [self showResult:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    }];
}

/**
 * 异步post
 */
-(void)asyncPost{
    [self showLoading];
    NSString *urlstring = [baseurl stringByAppendingString:@"App/getToken"];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *mutableURLRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    NSString *params = @"app_version=1.0&server_version=ios&appid=123456";
    NSData *paramsdata = [params dataUsingEncoding:NSUTF8StringEncoding];
    [mutableURLRequest setHTTPBody:paramsdata];
    [mutableURLRequest setHTTPMethod:@"POST"];
    [NSURLConnection connectionWithRequest:mutableURLRequest delegate:self];
}
-(void)showLoading{
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    self.view.userInteractionEnabled = NO;
//    self.tabBarController.tabBar.userInteractionEnabled = NO;
//    self.navigationItem.leftBarButtonItem.enabled = NO;
//    self.navigationController.navigationBar.userInteractionEnabled = NO;
//    self.view.window.userInteractionEnabled = NO;
    self.navigationController.view.userInteractionEnabled = NO;
//    [self performSelector:@selector(closeLoading) withObject:nil afterDelay:5];
}

-(void)closeLoading{
    self.view.userInteractionEnabled = YES;
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationController.view.userInteractionEnabled = YES;
//    self.view.window.userInteractionEnabled = NO;
    [_indicatorView stopAnimating];
    [Toast show:@"执行完毕"];

}
-(void)showResult:(NSString *)result{
    CGSize size = [result sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH*0.9,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//    _resultLabel.frame = CGRectMake(SCREEN_WIDTH*0.05,_scrollView.bounds.origin.y,size.width,size.height);
    _resultLabel.frame = CGRectMake(SCREEN_WIDTH*0.05,0,size.width,size.height);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,size.height);
    _resultLabel.text = result;
//    NSLog(@"_resultLabel.frame = %@",NSStringFromCGRect(_resultLabel.frame));
//    NSLog(@"_resultLabel.bouns = %@",NSStringFromCGRect(_resultLabel.bounds));
//    NSLog(@"_scrollView.frame = %@",NSStringFromCGRect(_scrollView.frame));
//    NSLog(@"_scrollView.bouns = %@",NSStringFromCGRect(_scrollView.bounds));
}

// 服务器接收到请求时
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

}
// 当收到服务器返回的数据时触发, 返回的可能是资源片段
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [self showResult:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}
// 当服务器返回所有数据时触发, 数据返回完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self closeLoading];
    NSLog(connection.currentRequest.allHTTPHeaderFields.description);
    NSLog(connection.originalRequest.allHTTPHeaderFields.description);
    NSLog([connection.originalRequest.URL absoluteString]);
    NSLog([connection.currentRequest.URL absoluteString]);
}
// 请求数据失败时触发
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

}
@end
