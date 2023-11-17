from skimage.io import imread

theImage = imread('./Image_parser/clyde.png')
print(theImage.shape)
cont = 1
print('\n        DC.L      ', end="")
for row in range(theImage.shape[0]):
    for column in range(theImage.shape[1]):

        red = theImage[row, column, 0]
        green = theImage[row, column, 1]
        blue = theImage[row, column, 2]

        if cont % 6 == 0:
            print('$00%.2X%.2X%.2X'%(blue, green, red), end="")
        else:
            print('$00%.2X%.2X%.2X,'%(blue, green, red), end="")
        if cont % 6 == 0:
            print('\n        DC.L      ', end="")

        cont += 1
        