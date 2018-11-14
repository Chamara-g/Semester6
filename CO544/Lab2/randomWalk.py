import numpy as np

matrix = np.array([[np.random.randint(0, 9) for i in range(0,100)] for j in range(0,100)])

start_x = np.random.randint(0,99)
start_y = np.random.randint(0,99)
position_x = start_x
position_y = start_y

size_x = len(matrix[0])
size_y = len(matrix)

for k in range(500):
    step = np.random.randint(0, 2)
    direction = np.random.randint(0, 4)

    if direction == 0:
        if position_x != 0:
            position_x -= step

    elif direction == 1:
        if position_y != 0:
            position_y -= step

    elif direction == 2:
        if position_x != size_x-1:
            position_x += step

    elif direction == 3:
        if position_y != size_y-1:
            position_y += step

    print('dir:',direction,'value:',step,' Step:',str(k),'(',position_x,',',position_y,')')




print(position_x,' ',position_y)
