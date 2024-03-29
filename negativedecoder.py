def score_decoder(score, maxAnte):
	ante_array = []
	while (score > 5):
		ante_array.append(score%5)
		score = score //5
	ante_array.append(score)
	ante_array.reverse()
	# print(ante_array)
	ante_slice = ante_array[-1*maxAnte:]
	print(f'There are a total of {ante_array[0]*5+ante_array[1]} negs.')
	print(f'number of negs antes 1-8:{ante_slice}')
	# for i in range(0,maxAnte):
	# 	print(f'Ante {maxAnte-i} has {ante_array[-1*(i+1)]} negs.')
	return ante_array[0]*5+ante_array[1]

score_decoder(78241256,8)