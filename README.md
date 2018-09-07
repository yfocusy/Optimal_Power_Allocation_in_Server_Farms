# Optimal_Power_Allocation_in_Server_Farms
# COMP9334 Project

1.Object

● Simulate a Processor Sharing (PS) server farm and decide how many server should be opened in order to achieve the minimal response time.

● Use statistically sound method to compare the performance of different systems and find out which solution is better.

2. Project condition

● Server number: s <= 10

● Power budget: p = 2000

● Clock frequency: f =1.25+0.31* ( p/200 −1) (measured in GHz)

● Under Round robin job assignment

3. Parameter

● The inter-arrival time: {a1,a2,...,ak,...,...}

1) Each ak is the product of two random numbers a1k and a2k, ak = a1k a2k

2) The sequence a1k is exponentially distributed with a mean arrival rate 7.2 requests/s.

3) The sequence a2k is uniformly distributed in the interval [0.75, 1.17]

● The service time:

1) If the server is operating at 1 GHz, then the probability density function g(t) of the service time t of the requests is:

1 2) Compute the indefinite integral of g(t) to get G(t) which is cumulative distribution function (CDF). Let G(a1) = 0 or G(a2) = 1 to get the constant C. The result is shown in the formula below.

3) G(t) is the generated uniformly distributed in the interval [0,1], the function of service time t:

● Number of servers opened : 0<s<=10

● Simulation time : Tend = 4000

● Replication times : r = 5, 10, 15, 20, 25, 30

● Removed jobs number: w = 1, 500, 1000


4. Simulation process

● Use Matlab to simulate and analysis the data of systems.

1) s = the number of servers which are opened, s= 3 to 10

2) Tend = simulation time, Tend = 4000

3) replication_id = replication number, from 5, 10, 15, 20, 25, to 30

4) w = how many jobs are non-steady ,w = 1000

5) Tave = the mean response time


