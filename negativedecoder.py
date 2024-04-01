def score_decoder(score, maxAnte):
	ante_array = []
	total = 0
	tags = 0
	neg_weight = 0
	while (score >= 5):
		ante_array.append(score%5)
		score = score //5
	ante_array.append(score)
	ante_array.reverse()
	# print(ante_array)
	num_jokers = ante_array[-1*maxAnte:]
	num_tag = ante_array[-1*(maxAnte+2):-1*maxAnte]
	neg_num = ante_array[-1*(maxAnte+4):-1*(maxAnte+2)]
	raw_weight = ante_array[0:-1*(maxAnte+4)]
	# print(num_jokers)
	# print(num_tag)
	# print(neg_num)
	# print(neg_total)
	for i, num in enumerate(neg_num):
		total += num * 5**(len(neg_num)-1-i)
	for i, num in enumerate(num_tag):
		tags += num * 5**(len(num_tag)-1-i)
	for i, num in enumerate(raw_weight):
		neg_weight += num * 5**(len(raw_weight)-1-i)
	print(f'Debug: weighted score - {neg_weight}')
	print(f'There are {total} negative jokers.')
	print(f'There are {tags} negative tags.')
	print(f'number of negs antes 1-8:{num_jokers}')
	return neg_weight

# score_decoder(1523909535,8) #29NT66TG
# score_decoder(1505469530, 8) #SJ6DH4L5
score_decoder(1768391901,8) #SJ6GGIBB