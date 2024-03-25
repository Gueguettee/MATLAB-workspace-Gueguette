import math
import matplotlib.pyplot as plt

f=500
step = 0.000001
min = 1
n_min = 0

array = []
array2 = []

for n in range(1, math.floor(1/f/step/2)):

    res = math.sin(math.pi * f * step * n) / (math.pi * f * step * n)
    array.append(res)
    array2.append(n*step)

    res = abs(res - math.sqrt(2)/2)

    print(res)

    if min > res:
        min = res
        n_min = n

plt.plot(array2, array)
plt.show()

print(min)
print(n_min*step)
    