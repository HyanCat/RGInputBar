//
//  RGInputViewController.m
//  RGInputBar
//
//  Created by Songming on 2019/6/29.
//

#import "RGInputViewController.h"
#import "RGInputKeyboardLayoutGuide.h"

@interface RGInputViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *inputPanel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong, readwrite) NSString *content;

@property (nonatomic, strong) RGInputKeyboardLayoutGuide *guide;

@end

@implementation RGInputViewController

- (instancetype)initWithContent:(NSString *)content
{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

- (void)loadView
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIView *view = [[UINib nibWithNibName:@"RGInputView" bundle:bundle] instantiateWithOwner:self options:nil].firstObject;
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.guide = [[RGInputKeyboardLayoutGuide alloc] init];
    [self.view addLayoutGuide:self.guide];
    [self.guide install];
    [self.inputPanel.bottomAnchor constraintEqualToAnchor:self.guide.topAnchor].active = YES;
    self.inputPanel.alpha = 0;

    self.inputTextView.text = self.content;
    self.inputTextView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self showAnimated];
    [self.inputTextView becomeFirstResponder];
}

#pragma mark Actions

- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender
{
    [self hideAnimated];
}

- (IBAction)cancelButtonTouched:(id)sender
{
    [self hideAnimated];
}

- (IBAction)sendButtonTouched:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputViewControllerDidConfirm:)]) {
        [self.delegate rg_inputViewControllerDidConfirm:self];
    }
}

- (void)showAnimated
{
    self.inputPanel.alpha = 0.f;
    self.backgroundView.alpha = 0.f;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = .5f;
        self.inputPanel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)hideAnimated
{
    [self.inputTextView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.f;
        self.inputPanel.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)clearContent
{
    self.content = nil;
}

#pragma mark - Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *content = textView.text;
    self.content = content;
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputViewController:didChangeContent:)]) {
        [self.delegate rg_inputViewController:self didChangeContent:content];
    }
}

@end
