#define CACHE_SIZE 1000
#include "lib/immolate.cl"
long filter(instance* inst) {
    int maxAnte = 8;
    init_locks(inst, 1, false, false);
    for (int ante = 1; ante <= maxAnte; ante++) {
        init_unlocks(inst, ante, false);
        printf("\n==ANTE %i==\n", ante);
        printf("Tags: ");
        print_item(next_tag(inst, ante));
        printf(", ");
        print_item(next_tag(inst, ante));
        printf("\n");
    }

    return 0;
}