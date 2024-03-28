#define CACHE_SIZE 1000
#include "lib/immolate.cl"
// Finds number of negative jokers available in a seed. 7 seems common, 8 is rare. Trying to find 9/10.
long filter(instance* inst) {
    int maxAnte = 8;
    long cardsPerAnte[] = {8, 15, 15, 15, 15, 15, 15, 15};
    // These pull from Resample and Resample2 pools
    int numRerolls = 5;
    int numRerolls2 = 3;
    // Perform required initializations
    set_deck(inst, Plasma_Deck);
    int score = 0;
    init_locks(inst, 1, false, false);
    for (int ante = 1; ante <= maxAnte; ante++) {
        init_unlocks(inst, ante, false);
        if(next_tag(inst, ante) == Negative_Tag) {
            score++;
        }
        if(next_tag(inst, ante) == Negative_Tag) {
            score++;
        }
        for (int q = 1; q <= cardsPerAnte[ante-1]; q++) {
            item edition = next_joker_edition(inst, S_Shop, ante);
            if (edition == Negative) {
                score++;
            }
        }
        int numPacks = 6;
        if (ante == 1) numPacks = 4;
        for (int p = 1; p <= numPacks; p++) {
            pack packinfo = pack_info(next_pack(inst, ante));
            item editions[5];
            if (packinfo.type == Buffoon_Pack) {
                buffoon_pack_editions(editions, packinfo.size, inst, ante);
                for (int i = 0; i < packinfo.size; i++) {
                    if (editions[i] == Negative) {
                        score++;
                    }
                }
            }
        }
    }

    return score;
}