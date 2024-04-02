#define CACHE_SIZE 1000
#include "lib/immolate.cl"
// Finds number of negative jokers available in a seed. 
// Score is read with python script. (base5, #ofnegatives(2digits) #ofnum_tagss(2digits) ante1 ante2 ante3 .. ante8)
//immolate -f negative -s random -c 78125000 -g 37 (at least 8 jokers)
long filter(instance* inst) {
    int maxAnte = 8;
    long jokersPerAnte[] = {8, 8, 8, 8, 8, 8, 8, 8};
    // These pull from Resample and Resample2 pools
    int numRerolls = 5;
    int numRerolls2 = 3;
    // Perform required initializations
    // set_deck(inst, Red_Deck);
    int score = 0;
    int num_tags = 0;
    int jokers_this_ante = 0;
    int total_jokers = 0;
    int delta = 1;
    int base = 5;
    init_locks(inst, 1, false, false);
    for (int ante = 1; ante <= maxAnte; ante++) { //for every ante
        init_unlocks(inst, ante, false);                //all jokers unlcoked
        if(next_tag(inst, ante) == Negative_Tag) {      //is num_tags negative
            num_tags++;
        }
        if(next_tag(inst, ante) == Negative_Tag) {      //is num_tags negative
            num_tags++;
        }
        for (int shopJokerIndex = 1; shopJokerIndex <= jokersPerAnte[ante-1]; shopJokerIndex++) {
            item edition = next_joker_edition(inst, S_Shop, ante);  //search next jokersPerAnte
            if (edition == Negative) {                  //is joker negative
                jokers_this_ante++;
            }
        }
        int numPacks = 6;
        if (ante == 1) numPacks = 4;
        for (int p = 1; p <= numPacks; p++) {
            pack packinfo = pack_info(next_pack(inst, ante));   //for every pack
            item editions[5];
            if (packinfo.type == Buffoon_Pack) {                //if pack with jokers
                buffoon_pack_editions(editions, packinfo.size, inst, ante);
                for (int i = 0; i < packinfo.size; i++) {
                    if (editions[i] == Negative) {              //is joker negative
                        jokers_this_ante++;
                    }
                }
            }
        }
        total_jokers+=jokers_this_ante;                         //keep track of how many jokers
        score+= delta*jokers_this_ante;                         //add this antes jokers to score
        delta *= base;                                          //increment by base  for next ante (separates score)
        jokers_this_ante = 0;                                   //reset jokers this ante
    }
    score+= delta*num_tags;                                           //add num tags onto header  (2 digits)
    score+= delta*base*base*total_jokers;                            //add num jokers onto header (2 digits)
    score+= delta*base*base*base*base*(total_jokers+(num_tags>>1)); //add weighted sum to the front for score printing (rn jokers+0.5*tag)
    return score;
}