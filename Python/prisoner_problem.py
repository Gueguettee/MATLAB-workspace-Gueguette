import random

# Test of prisoner problem :

n_prisoners = 100
n_trials = 1000
n_success = 0
n_longest_loop_under_51 = 0

def prisoner_problem(n_prisoners):
    global n_longest_loop_under_51

    # Create a list of prisoners
    prisoners = list(range(n_prisoners))

    # Create a list of doors
    doors = list(range(n_prisoners))

    # Randomly assign a door to each prisoner
    random.shuffle(doors)
    loops = []
    for i in range(n_prisoners):
        door = doors[i]
        ok = False
        for loop in loops:
            if not ok:
                for door2 in loop:
                    if i == door2[0] or door == door2[1]:
                        loop.append([door, i])
                        ok = True
                        break
        if not ok:
            loops.append([[door, i]])
    ok = False
    finalLoops = loops
    while(not ok):
        loops2 = finalLoops
        ok = True
        l = len(finalLoops)
        toNotGo = []
        toRemove = []
        for i in range(l):
            loopF = finalLoops[i].copy()
            for door in loopF:
                for ii in range(len(loops2)):
                    if i != ii and ii not in toNotGo and i not in toNotGo:
                        for door2 in loops2[ii]:
                            if door[1] == door2[0] or door[0] == door2[1]:
                                for door3 in loops2[ii]:
                                    #print(ii)
                                    #print(door3)
                                    finalLoops[i].append(door3)
                                toNotGo.append(i)
                                toNotGo.append(ii)
                                toRemove.append(ii)
                                ok = False
                                break
        if toRemove:
            toRemove.sort()
            toRemove.reverse()
        for loop in toRemove:
            finalLoops.pop(loop)
    
    i_max = 0
    max_loop = 0
    for i in range(len(finalLoops)):
        if len(finalLoops[i]) > max_loop:
            max_loop = len(finalLoops[i])
            i_max = i

    ok = False
    ii = 0
    longest_loop = []
    longest_loop = [finalLoops[i_max][0]]
    while(not ok):
        for i in range(1, len(finalLoops[i_max])):
            if longest_loop[ii][1] == finalLoops[i_max][i][0]:
                longest_loop.append(finalLoops[i_max][i])
        ii += 1
        if ii == len(finalLoops[i_max]):
            ok = True

    ok = True
    for loop in finalLoops:
        if len(loop) > 50:
            ok = False
            break
    if ok:
        n_longest_loop_under_51 += 1
    """for loop in finalLoops:
        for door in loop:
            ok = False
            for door2 in loop:
                if door[0] == door2[1] or door[1] == door2[0]:
                    ok = True
            if not ok:
                raise Exception("Error")"""
                
    # Assign each prisoner a door
    for i in range(n_prisoners):
        prisoners[i] = doors[i]

    for i in range(n_prisoners):
        exit = False
        n_doors = prisoners[i]
        n_trials_ = 0
        while(exit==False and n_trials_ < n_prisoners/2):
            if prisoners[i] == doors[n_doors]:
                exit = True
            else:
                n_doors = doors[n_doors]
                n_trials_ += 1
        if exit == False:
            return False
    return True

for i in range(n_trials):
    if prisoner_problem(n_prisoners):
        n_success += 1

print(f"{n_success/n_trials*100}% of success")
print(f"There are {n_longest_loop_under_51/n_trials*100}% loops under 51")
