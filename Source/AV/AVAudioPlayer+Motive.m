#import "AVAudioPlayer+Motive.h"

@implementation AVAudioPlayer (AVAudioPlayerMotive)

+ (AVAudioPlayer *)audioPlayerForResource:(NSString *)resource {
	return [[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:resource ofType:nil]] error:NULL] autorelease];
}

@end
