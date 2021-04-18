/*:
 
# Hungry Minds 🍽
 
After all that running, Duke is now super hungry. So he sat down with his 3 friends to eat dinner.
 
While eating, they started discussing about all the cool new iOS, macOS, iPadOS, watchOS and tvOS features and updates that could be unveiled at WWDC this year.
 
Then Duke realised that they could perform an experiment, for a very famous problem called the **Dining Philosophers** problem related to the topic of **Process Synchronisation** in **Operating Systems**.

* Note: **The Dining Philosophers Problem**
 \
 \
The dining philosophers problem states that there are ***N*** (here, 4) philosophers sharing a circular table and they eat and think alternatively. A hungry philosopher may only eat if there are both forks (to his/her left and right) available. Otherwise a philosopher puts down their fork and begins thinking again.

The problem lies in effectively managing these philosophers, so they don't try to access illegal resources (in this case, forks in use).
 
This is a very interesting problem, and a solution to this exists and uses the concept of **Binary Semaphores**.

* Note: **Binary Semaphores**
  \
  \
A Binary Semaphore is a variable that holds either 0 or 1.
 \
 \
1 state represents the availability of a resource (in this case, fork) and 0 state indicates that the resource is occupied.
 \
 \
If a philosopher attempts to access an occupied fork, he/she will be added to the blocked queue. Once the fork is free for use, and the philosopher tries to access it, he will be removed from the blocked queue.
 \
 \
Here, we use ***4*** binary semaphores to mark ***4 forks***.
 
Numbering begins from top right for both forks and philosophers.
 
* Experiment: Tap on a philosopher to switch between the following states:
 \
 \
Thinking -> Took right fork -> Took left fork -> Eating -> Put right fork -> Put left fork.
\
\
At the end of a cycle you go back to Thinking state.
 
Play around and see who gets to eat and when.
 
## So, is the problem solved?
 
Although using Semaphores comes in handy when trying to manage our philoshophers, it may lead to two problematic situations - namely, **Starvation** and **Deadlocks**.

1. **Starvation :** It is a situation where some philosophers get to eat multiple times or for long periods of time and some never get a chance.
 
2. **Deadlock :** In this case, all the philosophers are blocked because each philosopher is waiting for another philosopher to finish eating, leading to an unending cycle.
 
* Experiment: **DEADLOCKS**
 \
 \
Keep playing the game and try to figure out how to achieve a deadlock!
 \
 \
**Hint:** See what happens when each philosopher has only one fork, and then each tries to grab their second fork
 
### Deadlock Solution
 
Solution is simple, make one of the philosopher pick and put down their Left fork first, instead of their right!
 
Hence, the others will follow the same pattern as before. But one of them will follow this pattern:
 
Thinking -> Took left fork -> Took right fork -> Eating -> Put left fork -> Put right fork.
 
## And so the problem is solved, and their stomachs are full!
 
That's enough work for Duke and his friends for today. Now, they eagerly wait for WWDC!
 
*/



