#include <stdio.h>
#include <Block.h>
typedef int (^IntBlock)();

IntBlock newCounter(int start, int increment) {
	__block int i = start;

	return Block_copy( ^ {
		int ret = i;
		i += increment;
		return ret;
	});
}

int main() {
	IntBlock mycounter = newCounter(5, 2);
	printf("First  call: %d\n", mycounter());
	printf("Second call: %d\n", mycounter());
	printf("Third  call: %d\n", mycounter());
	
	Block_release(mycounter);
	
	return 0;
}
