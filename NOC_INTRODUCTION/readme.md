# Introduction
This part of the video series will exists of 5 different models/examples that will be explained. These are the following:
1. _Random Walker_
2. _Probability Basics_
3. _Gaussian Distribution_
4. _Custom Distribution_
5. _Perlin Noise_


## The structure basis of code
Daniel (the host of the channel) tells us that for the project we will be making physics engines in different degrees of difficulty. He shows us the template that we will be working in, which is:

```java
float x;
float y;

x = x + a;
y = y + b;

ellipse(x, y ,2, 2);
```

The different degrees of difficulty will be displayed in `a` & `b`. Deppending on how complex they get, we might be simulating a force more accurately. So in this video series we will pretty much be calculating the movement of an object over time with different models. 

## Processing
Processing always uses 2 functions so it works as intended. First a `setup()` function, in which you describe (e.g.) variables. Second, a `draw()` function, which loops over and over. 

```java
void setup() {
    // code setup here 
    // variables
}

void draw() {
    // excecuting code here
}
```

### The Random Walker
As an exercise you get to make your own random walker. Daniel shows a basic setup for the code and then you get to change it however you want. This is the code I used with some screenshots. 

```java
// TAB ONE
Walker w;

void setup() {
  size(800, 600);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.render();
}

// TAB TWO
class Walker {
  int x,y;
  
  Walker () {
    x = width/2;
    y = height/2;
  }
  
  void render() {
    stroke(0);
    point(x,y);
  }
  
   void step() {
   int choice = int(random(4));
   
   if (choice == 0) {
     x = x + int(random(5));
   } else if (choice == 1) {
     x = x - int(random(5));
   } else if (choice == 2) {
     y = y + int(random(5)); 
   } else {
     y = y - int(random(5));
    }
  }
  
// AVODING WALKING OUT OF THE CANVAS 
  void reset() {
    if (x <= 0) {
      x = width/2;
      y = height/2;
    } else if (x >= width) {
      x = width/2;
      y = height/2;
    } else if (y <= 0) {
      x = width/2;
      y = height/2;
    } else if (y >= height) {
      x = width/2;
      y = height/2;
    }
  }
}
```

### Results
##### _Without reset function_
![alt text](https://imgur.com/wK57tds.png)

##### _With reset function_
![alt text](https://i.imgur.com/Tm43uek.png)

##### _First implementation_
![](https://i.imgur.com/JNy9sUu.png)

```java
void step() {
   int choice = int(random(8));
   
   if (choice == 0) {
      x++;
   } else if (choice == 1) {
     x--;
   } else if (choice == 2) {
     y++;
   } else if (choice == 3) {
     y--;
   } else if (choice == 4) {
     x++;
     y++;
   } else if (choice == 5) {
     x--;
     y--;
   } else if (choice == 6) {
     x++;
     y--;
   } else  {
     x--;
     y++;
   }
  }
```

### Probability Basics
Daniel describes the thought train behind basic probability. He says, if we try to show a distribution of heights with values `[0, 1, 2, 3]`, it is more likely that the height of the individuals in this distribution is around `1,5`. This being the _mean_, and in a perfect bell distribution this would also be the _median_. 

I'm going here a bit off-track and describing this from my own BA statistics (or probability in this case) knowledge. In basic statistics there are three concepts that are used a fair bit. These are:
* The mean (μ): average of a dataset
_To be calculated with:_ `μ = ( Σ Xi ) / n` 
* The mode (Mo): the value with the highest frequency in a dataset
* The median (x̃): the value in the middle of the set of numbers in a dataset

If we have this dataset: `[0, 1, 2, 3, 3, 4, 8]`, then what are the different values?
* mean (μ): `μ = 3`
```
n = 7         // total entries in the dataset
Σ Xi = 21     // total value of all entries together

μ = ( Σ Xi ) / n
μ = 21 / 7 = 3

``` 
* mode (Mo): `Mo = 3`
 _Simply because it's the value in the set with the highest frequency._

* median (x̃): `x̃ = 3` 
_Because it's the value in the middle of the dataset._ [0, 1, 2, **3**, 3, 4, 8]

#### How to use custom probability checks
A very ease way to make custom checks for certain probabilities is shown below.
```java
if (random(1) < 0.1) {
  // code will run ~10% of the time 
}
```
But, we can further develop this code into something more usable and neat looking, like is shown below. Note that this code does actually the same as the simplest example of the random walker. Every `step()` a random step is made to one of the four directions with the same probability. 
```java
float r = random(1);

if (r < 0.25) {
  x++;
} else if (r < 0.5) {
  x--;
} else if (r < 0.75) {
  y++;
} else {
  y--;
}
```

### Gaussian distribution
This is a distribution of numbers that we oftenly find in nature. Think about human heights. A lot of people are around the same height. Some are shorter, other taller. But very few are extremely short or tall. Hence, the normal distribution / bell curve / gaussian distribution. 

![Normal curve](https://i.imgur.com/YoVyUQh.jpg)

#### Using gaussian distribution in Processing
To utilize this kind of distribution, you need to import some utilities. Check this code out.
```java 
import java.util.Random;

Random generator;

void setup() {
  size(400, 300);
  generator = new Random();
}

void draw() {
  background(255);
  
  // casting syntax for Java, this is float(generator.nextGaussian())
  float h = (float) generator.nextGaussian();
  print(h);
  
  fill(0);
  ellipse(width/2,height/2,h,h);
}
``` 

There is one problem now. If you check the values for `h`, you can see they're pretty low. That's because with no specification the gaussian generator is giving us a distribution with `μ = 0` and a standard deviation (σ) of `σ = 1`. The standard deviation is a measure of the variability of the scores in a dataset. A relatively higher number means that the scores in the distribution differ more from the mean (μ). See the example underneath:

![](https://i.imgur.com/I9HZvDP.png)

* The standard deviation gets calculated with: `σ = sqrt[ Σ ( Xi – μ )2 / n ]` 

So, back to our case. We're getting numbers which are pretty close to each other because we didn't specify in which range we want the gaussian distribution. I honestly thought that there would be parameters to do this. But Daniel explains it in another way. 

> _**BUT**_, I want to clarify this first. If in a convertion, you're multiplying and summing (negative or positive, it doesn't matter), you _**A L W A Y S**_ multiply or divide **first**, then you add or subtract your numbers.  

He tells that we can do that in a more manual way. Like this: 

```java
Random gen = new Random();

// create your random number
float h = gen.nextGaussian();

// multiply it with your standard deviation
h = h * stddev;

// then move it further over the x-axis by adding or subtracting your mean
h = h + mean;
```

#### Exercise
I tried to remake the last example of code Daniel gave. This gives an illustration that shows standard devation in a proper way. In the next pictures the mean is the same, being `μ = 500`. The only difference is the standard deviation.

`σ = 50` 
![Distribution with standard deviation of 50](https://i.imgur.com/JdfJwgp.png)


`σ = 100` 
![Distribution with standard deviation of 100](https://i.imgur.com/k6JQaM5.png)


`σ = 150` 
![Distribution with standard deviation of 150](https://i.imgur.com/BgU6Q7A.png)

