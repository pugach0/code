import time
import math
import os

base = os.path.join(os.environ["LOCALAPPDATA"], "StudyTracker")
timer = os.path.join(base, "timer.txt")

globalSeconds = 0
while True:
    hours = math.floor(globalSeconds / 3600)
    minutes = math.floor(globalSeconds / 60) - hours * 60
    seconds = globalSeconds - hours * 3600 - minutes * 60
    timeStr = f"{str(hours).zfill(2)}:{str(minutes).zfill(2)}:{str(seconds).zfill(2)}"

    with open(timer) as f:
        f.write(timeStr)
    globalSeconds += 1
    time.sleep(1)
    print(timeStr)