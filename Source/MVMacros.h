
#define ATTR @property (nonatomic, retain)
#define READ @property (readonly)

#define NSARRAY(args...) [NSArray arrayWithObjects:args, nil]
#define NSDICT(args...) [NSDictionary dictionaryWithObjectsAndKeys:args, nil]
