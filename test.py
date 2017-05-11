#-*-coding:utf-8-*-
# -*-coding:utf-8-*-
# from __future__ import print_function
from __future__ import print_function
from ortools.graph import pywrapgraph
from numpy import genfromtxt
import numpy


def find_location(mat, n):
    for i in range(len(mat)):
        for j in range(len(mat[i])):
            if mat[i][j] == n:
                return i, j
    return -1, -1


channel = genfromtxt('channel.dat', delimiter='\t', dtype=int)
print(channel)

t = genfromtxt('output1.txt', delimiter='  ', comments='%', dtype=float)
at= numpy.array(t)
t = t[::-1]
print(t)

index = numpy.zeros(shape=(len(channel), len(channel[0])), dtype=int)
for i in range(len(index)):
    for j in range(len(index[i])):
        index[i][j] -= 1

mark = numpy.zeros(shape=(9, 9), dtype=int)
print(index)

cnt = 0
for i in range(len(channel)):
    for j in range(len(channel[i])):
        if channel[j][i] > 0:
            index[j][i] = cnt
            cnt += 1
print(index)

# get average of t
avg = numpy.mean(t)

# assign capacity, cost
start_node = []
end_node = []
capacities = []
unit_costs = []
supplies = [0] * 2 * cnt

sort_t_list=numpy.sort(numpy.array(t),axis=None)
length=len(sort_t_list)
t_threld=sort_t_list[int(0.9*length)]
threld=2

positive_cost=10
for i in range(len(channel)):
    for j in range(len(channel[i])):
        # input
        if channel[i][j] == 2:
            supplies[index[i][j]] = 1

        # output
        if channel[i][j] == 3:
            supplies[index[i][j]] = -1

        # add edge
        if channel[i][j] == 1 or channel[i][j] == 2:

            start_node.append(index[i][j])
            end_node.append(cnt+index[i][j])
            unit_costs.append(0)
            capacities.append(1)

            # top
            if i > 0:
                if channel[i - 1][j] == 1 or channel[i - 1][j] == 3:
                    start_node.append(cnt+index[i][j])
                    end_node.append(index[i - 1][j])
                    capacities.append(1)
                    if t[i - 1][j] + t[i][j] > threld * t_threld:
                        unit_costs.append(-t[i - 1][j] - t[i][j])
                    else:
                        unit_costs.append(positive_cost)
            # bottom
            if i < len(channel) - 1:
                if channel[i + 1][j] == 1 or channel[i + 1][j] == 3:
                    start_node.append(cnt+index[i][j])
                    end_node.append(index[i + 1][j])
                    capacities.append(1)
                    if t[i + 1][j] + t[i][j] > threld * t_threld:
                        unit_costs.append(-t[i + 1][j] - t[i][j])
                    else:
                        unit_costs.append(positive_cost)

            # left
            if j > 0:
                if channel[i][j - 1] == 1 or channel[i][j - 1] == 3:
                    start_node.append(cnt+index[i][j])
                    end_node.append(index[i][j - 1])
                    capacities.append(1)
                    if t[i][j - 1] + t[i][j] > threld * t_threld:
                        unit_costs.append(-t[i][j - 1] - t[i][j])
                    else:
                        unit_costs.append(positive_cost)

            # right
            if j < len(channel[i]) - 1:
                if channel[i][j + 1] == 1 or channel[i][j + 1] == 3:
                    start_node.append(cnt+index[i][j])
                    end_node.append(index[i][j + 1])
                    capacities.append(1)
                    if t[i][j + 1] + t[i][j] > threld * t_threld:
                        unit_costs.append(-t[i][j + 1] - t[i][j])
                    else:
                        unit_costs.append(positive_cost)

for i in range(len(unit_costs)):
    unit_costs[i] = int(unit_costs[i])
print(start_node)
print(end_node)
print(capacities)
print(unit_costs)
print(supplies)
print(len(start_node))
print(len(end_node))
print(len(capacities))
print(len(unit_costs))
print(len(supplies))
# Instantiate a SimpleMinCostFlow solver.
min_cost_flow = pywrapgraph.SimpleMinCostFlow()

# Add each arc.
for i in range(0, len(start_node)):
    min_cost_flow.AddArcWithCapacityAndUnitCost(start_node[i], end_node[i], capacities[i], unit_costs[i])

# Add node supplies.

for i in range(0, len(supplies)):
    min_cost_flow.SetNodeSupply(i, supplies[i])

# Find the minimum cost flow between node 0 and node 4.
if min_cost_flow.Solve() == min_cost_flow.OPTIMAL:
#    print('Minimum cost:', min_cost_flow.OptimalCost())
    print('')
#    print('  Arc    Flow / Capacity  Cost')
#    for i in range(min_cost_flow.NumArcs()):
#        cost = min_cost_flow.Flow(i) * min_cost_flow.UnitCost(i)
#        print('%1s -> %1s   %3s  / %3s       %3s' % (
#            min_cost_flow.Tail(i),
#            min_cost_flow.Head(i),
#            min_cost_flow.Flow(i),
#            min_cost_flow.Capacity(i),
#            cost))
else:
    print('There was an issue with the min cost flow input.')

for i in range(min_cost_flow.NumArcs()):
    if min_cost_flow.Flow(i) > 0:
        (r, c) = find_location(index, min_cost_flow.Tail(i) % cnt)
        channel[r][c] += 10
        (r, c) = find_location(index, min_cost_flow.Head(i) % cnt)
        channel[r][c] += 10

for i in range(len(channel)):
    for j in range(len(channel[i])):
        if 0 < channel[i][j] and channel[i][j] < 10:
            channel[i][j] = 0
        else:
            if channel[i][j] > 0:
                channel[i][j] %= 10

print(channel)
numpy.savetxt("bend_channel.dat", channel, fmt='%d')

