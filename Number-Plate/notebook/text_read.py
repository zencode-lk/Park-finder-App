import easyocr
import cv2
from matplotlib import pyplot as plt
import numpy as np

IMAGE_PATH = 'scaned_img_2.jpg'

reader = easyocr.Reader(['en'])
result = reader.readtext(IMAGE_PATH)
result

