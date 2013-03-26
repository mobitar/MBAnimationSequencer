# FXAnimationController
FXAnimationController is a general purpose animation sequencer.

###Usage:
``` objective-c
FXAnimationController *animation = [FXAnimationController new];
[animation addAnimationToSequence:[FXAnimationStep viewAnimationStepWithBlock:^(UIView *view, CGFloat duration){
	view.alpha = 0.1;
} toViews:@[view1] duration:0.1]];
[animation addAnimationToSequence:[FXAnimationStep viewAnimationStepWithBlock:^(UIView *view, CGFloat duration){
	view.transform = ...
} toViews:@[view2, view3] duration:0.2]];

[animation addAnimationToSequence:[FXAnimationStep layerAnimationStepWithBlock:^(CALayer *layer, CGFloat duration){
layer.opacity = 1.0;

} toLayers:@[layer1, layer2] duration:0.2]];

animation.repeatCount = 5;
animation.delayBetweenRepititions = 0.4;
[animation playFromBeginning];
```
The above plays the animation steps sequentially, so when the first step completes, the second one commences, and so on.

You can check header files for full animation and step customization options, such as delays, delays between views within a step, etc.