# Projective Plane

Animation of three points on a projective plane. Created with [gloss](https://hackage.haskell.org/package/gloss).

Use the mouse to control the direction of movement.

![Screenshot](screenshot.png)

## What is the projective plane?

The [projective plane](https://en.wikipedia.org/wiki/Real_projective_plane) is a topological surface. You can think of it as a sphere where opposite points are considered identical, or as a hemisphere where opposite points on the boundary are considered identical. The projective plane cannot be embedded in 3d space, but _can_ be embedded in 4d space. (There is an [immersion](https://en.wikipedia.org/wiki/Boy's_surface) of the projective plane in 3d space, but this is difficult to visualise).

The projective plane is non-orientable, which means there is no consistent definition of "clockwise". You can see this in the animation: at the beginning, the red point is clockwise from the green point. But if you go off the edge and reappear on the other side, the red point is _counterclockwise_ from the green point. This property has some strange implications. If the Earth were a projective plane instead of a sphere, and you traveled in a straight line along the Earth's surface, eventually you would reach your original location, just like you would on a sphere. But everything in your surroundings would be a mirror image of what it was before. Your left-handed friend would be right-handed, and cars would drive on the opposite side of the road.
