#takes a score from the negative filter and analyzes it so you can keep the filter running
#

#Settings
print_sum = True
base = 5
# max_ante = 30
#function
def score_decoder(score: int, max_ante: int = 8):
	ante_array = [] 	#keep track of how many negative jokers per ante
	tags = 0 			#negative tags
	neg_weight = 0 		#weighted sum of jokers and tags
	while (score >= base):											#unwrap score with base settings from negative.cl
		ante_array.append(score%base)									#write to ante array for each ante
		score = score //base											#decrement score to go to next ante
	ante_array.append(score)											#write last ante & packet header to array
	ante_array.reverse()												#switch the ante order for later reading
	jokers_per_ante = ante_array[-1*max_ante:]							#array of negative jokers len = max_ante
	num_tag = ante_array[-1*(max_ante+2):-1*max_ante]					#number of negative tags (2 digit header)
	raw_weight = ante_array[0:-1*(max_ante+2)]							#weighted sum at MSB of packet, for score filter purposes
	for i, num in enumerate(num_tag):#cook numbers back to base 10
		tags += num * base**(len(num_tag)-1-i)
	for i, num in enumerate(raw_weight):#cook numbers back to base 10
		neg_weight += num * base**(len(raw_weight)-1-i)
	if print_sum: print(f'Debug: weighted score - {neg_weight}')			
	print(f'There are {sum(jokers_per_ante)} negative jokers.')
	print(f'There are {tags} negative tags.')
	print(f'Negative jokers from Antes 1-8:{jokers_per_ante}')
	return neg_weight

#Check seeds here:
# score_decoder(____) #L5PSRC69
# score_decoder(78922537) #SJDHXQ88