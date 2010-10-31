#include <stdio.h>
#include <Block.h>
typedef int (^IntBlock)();

IntBlock counter(int start, int increment) {
	__block int i = start;
	
	return Block_copy( ^ {
		int ret = i;
		i += increment;
		return ret;
	});
	
}

int main() {
	IntBlock mycounter = counter(5, 2);
	printf("First call: %d\n", mycounter());
	printf("Second call: %d\n", mycounter());
	printf("Third call: %d\n", mycounter());
	
	Block_release(mycounter);
	
	return 0;
}
/* Output:
	First call: 5
	Second call: 7
	Third call: 9
*/
