//
//  CJPYWebViewController.m
//  PinBoard
//
//  Created by 彭 勇 on 13-3-12.
//  Copyright (c) 2013年 ÂΩ≠Âãá. All rights reserved.
//

#import "CJPYWebViewController.h"
#import <MessageUI/MessageUI.h>
#import "ChromeProgressBar.h"
#import "IMTWebView.h"

@interface CJPYWebViewController ()<UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate,IMTWebViewProgressDelegate>
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *actionBarButtonItem;
@property (nonatomic, strong) UIActionSheet *pageActionSheet;

@property (nonatomic, strong) IMTWebView *mainWebView;
@property (nonatomic, strong) NSURL *URL;
@property(nonatomic,strong)ChromeProgressBar * chromeBar;

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;
- (void)actionButtonClicked:(UIBarButtonItem *)sender;


@end

@implementation CJPYWebViewController


- (UIBarButtonItem *)backBarButtonItem {
    
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        _backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		_backBarButtonItem.width = 18.0f;
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!_forwardBarButtonItem) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/forward"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        _forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		_forwardBarButtonItem.width = 18.0f;
    }
    return _forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!_refreshBarButtonItem) {
        _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
    }
    
    return _refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!_stopBarButtonItem) {
        _stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
    }
    return _stopBarButtonItem;
}

- (UIBarButtonItem *)actionBarButtonItem {
    
    if (!_actionBarButtonItem) {
        _actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonClicked:)];
    }
    return _actionBarButtonItem;
}

- (UIActionSheet *)pageActionSheet {
    if(!_pageActionSheet) {
        _pageActionSheet = [[UIActionSheet alloc]
                           initWithTitle:self.mainWebView.request.URL.absoluteString
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
        
        if((self.availableActions & CJPYWebViewControllerAvailableActionsCopyLink) == CJPYWebViewControllerAvailableActionsCopyLink)
            [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"Copy Link", @"")];
        
        if((self.availableActions & CJPYWebViewControllerAvailableActionsOpenInSafari) == CJPYWebViewControllerAvailableActionsOpenInSafari)
            [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"Open in Safari", @"")];
        
        if([MFMailComposeViewController canSendMail] && (self.availableActions & CJPYWebViewControllerAvailableActionsMailLink) == CJPYWebViewControllerAvailableActionsMailLink)
            [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"Mail Link to this Page", @"")];
        
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
        _pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    
    return _pageActionSheet;
}

#pragma mark - Initialization

- (id)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL*)pageURL {
    
    if(self = [super init]) {
        self.URL = pageURL;
        self.availableActions = CJPYWebViewControllerAvailableActionsOpenInSafari | CJPYWebViewControllerAvailableActionsMailLink;
        self.navigationItem.title=@"Untitled";
    }
    return self;
}


- (void)webView:(IMTWebView *)_webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources {
    //Set progress value
    [self.chromeBar setProgress:((float)resourceNumber) / ((float)totalResources) animated:NO];
    
    //Reset resource count after finished
    if (resourceNumber == totalResources) {
        _webView.resourceCount = 0;
        _webView.resourceCompletedCount = 0;
    }
}

#pragma mark - Memory management




- (void)dealloc {
    _mainWebView.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - View lifecycle



- (void)viewDidLoad {
	[super viewDidLoad];
    _mainWebView = [[IMTWebView alloc] initWithFrame:self.view.bounds];
    _mainWebView.delegate = self;
    _mainWebView.progressDelegate=self;
    _mainWebView.scalesPageToFit = YES;
    _mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    [self.view  addSubview:_mainWebView];
    [self loadRequest];
    [self updateToolbarItems];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    _mainWebView = nil;
    _backBarButtonItem = nil;
    _forwardBarButtonItem = nil;
    _refreshBarButtonItem = nil;
    _stopBarButtonItem = nil;
    _actionBarButtonItem = nil;
    _pageActionSheet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    NSAssert(self.navigationController, @"SVWebViewController needs to be contained in a UINavigationController. If you are presenting SVWebViewController modally, use SVModalWebViewController instead.");
    
	[super viewWillAppear:animated];
	
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled = self.mainWebView.canGoForward;
//    self.actionBarButtonItem.enabled = !self.mainWebView.isLoading;
    
    UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    self.navigationItem.rightBarButtonItems=@[self.actionBarButtonItem,self.forwardBarButtonItem,self.backBarButtonItem,refreshStopBarButtonItem,];
}

#pragma mark -
- (void)loadRequest {
    if (self.chromeBar) {
        [self.chromeBar removeFromSuperview];
    }
    self.chromeBar = [[ChromeProgressBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 4.0f)];
    [self.view addSubview:self.chromeBar];
}

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateToolbarItems];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self updateToolbarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateToolbarItems];
}

#pragma mark - Target actions

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [self.mainWebView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [self.mainWebView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [self.mainWebView reload];
    [self loadRequest];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    [self.mainWebView stopLoading];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self updateToolbarItems];
}

- (void)actionButtonClicked:(id)sender {
    
    if(!self.pageActionSheet)
        return;
	
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        [self.pageActionSheet showFromBarButtonItem:self.actionBarButtonItem animated:YES];
    else
        [self.pageActionSheet showFromToolbar:self.navigationController.toolbar];
    
}

- (void)doneButtonClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
	if([title isEqualToString:NSLocalizedString(@"Open in Safari", @"")])
        [[UIApplication sharedApplication] openURL:self.mainWebView.request.URL];
    
    if([title isEqualToString:NSLocalizedString(@"Copy Link", @"")]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.mainWebView.request.URL.absoluteString;
    }
    
    else if([title isEqualToString:NSLocalizedString(@"Mail Link to this Page", @"")]) {
        
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
		mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:[self.mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"]];
  		[mailViewController setMessageBody:self.mainWebView.request.URL.absoluteString isHTML:NO];
		mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
		[self presentModalViewController:mailViewController animated:YES];
	}
    
    self.pageActionSheet = nil;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
}


@end
