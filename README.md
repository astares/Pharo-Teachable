# Pharo-Teachable
A teachable object for [Pharo](http://www.pharo.org).

## Intro

Using the small project you can easily create objects responding to specific messages. This is useful for mocking in unit tests and other. The code goes back to an early idea of [Ernest Micklei](https://github.com/emicklei) with an implementation for Pharo by [Torsten Bergmann (astares)](http://www.github.com/astares).

## Quick Start

```Smalltalk
Metacello new 
	repository: 'github://astares/Pharo-Teachable/src';
	baseline: 'Teachable';
	load 	
```

## Documentation

It's an implementation of a Teachable class who's instances can be taught to respond to messages. It's usefull for creating mocks who should behave like other objects (for instance inside of a test case) without actually implementing a real mock class. Here is an example how it can be used:

```Smalltalk
|teachable|
teachable := Teachable new.
teachable
    whenSend: #help return: 'ok';
    whenSend: #doit evaluate: [1 inspect];
    acceptSend: #noDebugger;
    whenSend: #negate: evaluate: [:num | num negated].
```

After teaching the object we can use it as if it had a normal implementation in a class:

```Smalltalk
teachable help. "this will return the string 'ok'"
teachable doit. "this will open the inspector on the SmallInteger 1"
teachable noDebugger. "this will accept the send of #noDebugger and return the teachable"
teachable negate: 120 "this will return -120"
```

see [https://astares.blogspot.com/2005/04/teaching-behavior.html](https://astares.blogspot.com/2005/04/teaching-behavior.html)

## Video

[![Watch the video](https://img.youtube.com/vi/aJCX4Rpp9AU/hqdefault.jpg)](https://www.youtube.com/watch?time_continue=1&v=aJCX4Rpp9AU)
