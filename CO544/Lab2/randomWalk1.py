import numpy as np
import pylab
import random

def randomWalk(X_start,Y_start):
    currentX = X_start;
    currentY = Y_start;

    for i in range(500):
        isGoing = np.random.randint(2) #0 wait, 1 going
        side = np.random.randint(4) # 0 front 1 back 2 up 3 down

        if side == 0:
            if currentX != 100: 
                currentX += isGoing #going front

        elif side == 1:
            if currentX != 0:
                currentX -= isGoing #going back

        elif side == 2:
            if currentY != 0:
                currentY -= isGoing #going up

        elif side == 3:
            if currentY != 100:
                currentY += isGoing #going down

        print('step:',i+1,'side:',side,'isGoing:',isGoing,'X:',currentX,'Y:',currentY)        

#give start point as arguments            
randomWalk(50,50)
    
