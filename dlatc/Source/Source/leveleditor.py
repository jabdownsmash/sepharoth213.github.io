

# Pygame Cheat Sheet
# This program should show you the basics of using the Pygame library.
# by Al Sweigart http://inventwithpython.com
# modification by Horst JENS http://ThePythonGameBook

# Download files from:
#     http://inventwithpython.com/cat.png
#     http://inventwithpython.com/bounce.wav

import pygame, sys, os, json
#from pygame.locals import *

data = json.load(open('data.txt','r'))

# data = {
#     'types' : [],
#     'objects' : [
#         {
#             'column' : 1,
#             'beat' : 2,
#             'type' : 0
#         }
#     ],
#     'song' : '../Assets/dickbutt.ogg',
#     'bpm' : 100,
#     'maxColumns' : 5
# }

# print(data)

data['types'] = [
    {
        'size' : 30,
        'color' : 0xDD1111,
        'speed' : .25,
        'beatOffset' : 0,
        'type' : 0
    },
    {
        'size' : 20,
        'color' : 0x1111DD,
        'speed' : .25,
        'beatOffset' : 0,
        'type' : 1
    },
    {
        'size' : 40,
        'color' : 0x11DD11,
        'speed' : .25,
        'beatOffset' : 0,
        'type' : 2
    },
    {
        'size' : 50,
        'color' : 0xDDDDDD,
        'speed' : .25,
        'beatOffset' : 0,
        'type' : -1
    },
]

pygame.init()
fpsClock = pygame.time.Clock()

screen = pygame.display.set_mode((400, 600))
pygame.display.set_caption('Pygame Cheat Sheet')

redColor = pygame.Color(255, 0, 0)
red2Color = pygame.Color(135,40,0)
blueColor = pygame.Color(0, 0, 255)
blue2Color = pygame.Color(0, 40, 135)
whiteColor = pygame.Color(255, 255, 255)
blackColor = pygame.Color(0, 0, 0)
# mousex, mousey = 0, 0
# msg = 'Hello world!'
# try:
#     cat = os.path.join("data",'babytux.png')
#     font = os.path.join("data", 'freesansbold.ttf')
#     sound = os.path.join("data",'beep.ogg')
# except:
#     # does not raise alert if file does not exist ! TODO: fix
#     raise UserWarning, "could not found files inside subfolder data"
# catSurfaceObj = pygame.image.load(cat)
# fontObj = pygame.font.Font(font, 32)
# soundObj = pygame.mixer.Sound(sound)

a = pygame.mixer.Sound(data['songPath'])
songLength = a.get_length() * 60 / data['bpm']

cursorX = 0
cursorY = 0

objectType = 0

typeColors = [pygame.Color(255, 0, 0),pygame.Color(0, 0, 255),pygame.Color(0, 255, 0),pygame.Color(255, 255, 255)]

squareSize = 400/data['maxColumns']
savedConfirm = 0

screenOffset = 0

while True:
    screen.fill(blackColor)

    # pygame.draw.polygon(screen, greenColor, ((146, 0), (291, 106), (236, 277), (56, 277), (0, 106)))
    # pygame.draw.circle(screen, blueColor, (300, 50), 20, 0)
    # pygame.draw.ellipse(screen, redColor, (300, 250, 40, 80), 1)
    # pygame.draw.rect(screen, redColor, (10, 10, 50, 100))
    # pygame.draw.line(screen, blueColor, (60, 160), (120, 60), 4)

    for soundObject in data['objects']:
        pygame.draw.rect(screen, typeColors[soundObject['type']], (soundObject['column'] * squareSize, 600 - soundObject['beat'] * squareSize + screenOffset, squareSize, -squareSize))

    pygame.draw.rect(screen,typeColors[objectType], (cursorX * squareSize, 600 - cursorY * squareSize + screenOffset, squareSize, -squareSize),3)
    if savedConfirm > 0:
        savedConfirm -= 1
        pygame.draw.rect(screen,whiteColor, (0, 0, 400, 600),9)

    if 600 - cursorY * squareSize + screenOffset < 0:
        screenOffset += squareSize * 4
    if 600 - cursorY * squareSize + screenOffset - squareSize > 600:
        screenOffset -= squareSize * 4

    # pixArr = pygame.PixelArray(screen)
    # for x in range(100, 200, 4):
    #     for y in range(100, 200, 4):
    #         pixArr[x][y] = blueColor
    # del pixArr


    # screen.blit(catSurfaceObj, (mousex, mousey))

    # msgSurfaceObj = fontObj.render(msg, False, blueColor)
    # msgRectobj = msgSurfaceObj.get_rect()
    # msgRectobj.topleft = (10, 20)
    # screen.blit(msgSurfaceObj, msgRectobj)

    if cursorX > data['maxColumns'] - 1:
        cursorX = 0
    if cursorX < 0:
        cursorX = data['maxColumns'] - 1

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

        # elif event.type == pygame.MOUSEMOTION:
        #     mousex, mousey = event.pos
        # elif event.type == pygame.MOUSEBUTTONUP:
        #     mousex, mousey = event.pos
        #     soundObj.play()
        #     if event.button in (1, 2, 3):
        #         msg = 'left, middle, or right mouse click'
        #     elif event.button in (4, 5):
        #         msg = 'mouse scrolled up or down'

        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_1:
                objectType = 0
            if event.key == pygame.K_2:
                objectType = 1
            if event.key == pygame.K_3:
                objectType = 2
            if event.key == pygame.K_4:
                objectType = 3
            if event.key == pygame.K_SPACE:
                foundExisting = False
                for soundObject in data['objects']:
                    if soundObject['column'] == cursorX and soundObject['beat'] == cursorY:
                        foundExisting = True
                        soundObject['type'] = objectType
                if not foundExisting:
                    data['objects'].append({'column':cursorX,'beat':cursorY,'type':objectType})
            if event.key == pygame.K_z:
                for soundObject in data['objects']:
                    if soundObject['column'] == cursorX and soundObject['beat'] == cursorY:
                        data['objects'].remove(soundObject)
            if event.key == pygame.K_LEFT:
                cursorX -= 1
            if event.key == pygame.K_RIGHT:
                cursorX += 1
            if event.key == pygame.K_UP:
                cursorY += 1
            if event.key == pygame.K_DOWN:
                cursorY -= 1
            if event.key == pygame.K_s:
                open('data.txt', 'w').write(json.dumps(data, sort_keys=True, indent=4, separators=(',', ': ')))
                savedConfirm = 10
            if event.key == pygame.K_ESCAPE:
                pygame.event.post(pygame.event.Event(pygame.QUIT))

    pygame.display.update()
    fpsClock.tick(30) # pause to run the loop at 30 frames per second


