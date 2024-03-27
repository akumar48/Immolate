// Searches for first shop with two packs that give legendary jokers
#include "lib/immolate.cl"
long filter(instance* inst) {
    set_deck(inst, Plasma_Deck);
    int score = 0;
    for (int packIndex = 0; packIndex <= 3; packIndex++)
    {
        pack pack = pack_info(next_pack(inst, 1));
        item cards[5];
        if (pack.type == Spectral_Pack)
        {
            spectral_pack(cards, pack.size, inst, 1);
            for (int i = 0; i < pack.size; i++)
            {
                if (cards[i] == The_Soul)
                {
                    score++;
                }
            }
        }
        if (pack.type == Arcana_Pack)
        {
            arcana_pack(cards, pack.size, inst, 1);
            for (int i = 0; i < pack.size; i++)
            {
                if (cards[i] == The_Soul)
                {
                    score++;
                }
            }
        }

    }
    for (int ante = 1; ante <= 5; ante++)
    {
        for (int packIndex = 0; packIndex <= 5; packIndex++)
        {
            pack pack = pack_info(next_pack(inst, ante));
            item cards[5];
            if (pack.type == Spectral_Pack)
            {
                spectral_pack(cards, pack.size, inst, ante);
                for (int i = 0; i < pack.size; i++)
                {
                    if (cards[i] == The_Soul)
                    {
                        score++;
                    }
                }
            }
            if (pack.type == Arcana_Pack)
            {
                arcana_pack(cards, pack.size, inst, ante);
                for (int i = 0; i < pack.size; i++)
                {
                    if (cards[i] == The_Soul)
                    {
                        score++;
                    }
                }
            }
        }
    }
    return score;
}