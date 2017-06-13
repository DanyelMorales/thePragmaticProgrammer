# DOMAIN LANGUAGE EXERCISE

This script takes a set of  "Mnemonics" and generates a python code  which draws a shape  using "turtle graphics" engine. 



> The idea is originally taken from the book "The pragmatic programmer", chapter 2 , topic 12, page 63.



![assets/example.gif](assets/example.gif)

### Requirements

- Python 3.6 or higher 
- Perl 5.0 or higher



**Usage:**

```perl
perl main.pl ejemplo.map
```



**Commands:**

| Command |   Arg type    |                decription                |
| :-----: | :-----------: | :--------------------------------------: |
|    P    |      int      |                 Pen Size                 |
|    D    |     null      |        draw the motion of the pen        |
|  COLOR  | String String | String1 the border color & String2 the inner color of the shape |
|    W    |      int      |          move to west  n pixels          |
|    N    |      int      |          move to north n pixels          |
|    E    |      int      |          move to east n pixels           |
|    S    |      int      |          move to south n pixels          |
|    U    |     null      |    do not draw the motion of the pen     |



**Example of map file:**

```bash
P 2 # select pen 2
D   # pen down
COLOR blue yellow # line blue filled with yellow
W 2 # draw west 2cm
N 1 #then north 1
N 10 #then north 10
E 2 #then EASTH 2
S 1 #then back south
U   # pen up
```

**Notes:** 

* Comments are optional.
* the scale of pixel drawing is : 1 * 100 


## **Extending:**

The file "lib/rules.pl"  is used to read the allowed mnemonics, if you want to extend the script you have to:

- Add a new key/value item for command/rule in the Symbol Map
- Add a new subroutine to handle the value detected from the map file that contains the mnemonics.



**Symbol Map **

```perl
%commands = (
	P => "[0-9]+",
	D => "",
	COLOR => " *([a-zA-Z])* +([a-zA-Z])*",
	W => "[0-9]+",
	N => "[0-9]+",
	E => "[0-9]+", 
	S => "[0-9]+",
	U => ""
);
```

The Map above dictates the rules for the allowed mnemonics, and its regex rules. If you need to add a new mnemonic, just add a new item with the regex to detect the value from the map file. 



For example if we want to allow a new mnemonic called "Turtle" of just one digit (from 0 to 9) we should add the item *TURTLE => "[0-9]"*.

```perl
%commands = (
  ...,
  TURTLE => "[0-9]"
);
```


**Subroutines**

The next step is to create a subroutine called "do_TURTLE"

```perl
sub do_TURTLE{
	my ($value, $rule) = @_;
	my @capture = @_;
	$code = "print(\"I AM A turtle of size $value\");";
	addPythoner($code);
	return 1;
};
```

The code above will read the $value var which handles anything extracted from the map file following the "Symbol Map" regex.  The function "addPythoner" will push to the stack the python code that represents  our parsed mnemonic.



Things you must to know:

- $value :  Value taken from "map file" applying the Symbol Map regex for the mnemonic
- $rule : the regex used to find the value
- @capture: the array returned by the parser.
- Plz Return 1 if the translation was successful otherwise return 0 for future features that supports error handling
- Sometimes the $value is not what we expect, so we can process it a little bit more like in COLOR subroutine.



And that's it, hope you enjoy using and learning what I've done.



## Contact me:

If you have questions or you want to improve the code make a pull request or say hi to danyelmorales1991@gmail.com



:) Regards.