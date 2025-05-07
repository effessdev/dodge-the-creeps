# Dodge the Creeps

Godot version: 4.4.1

## Naming Convensions

Obtained from [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#doc-gdscript-styleguide).

| Type         | Convention    | Example                     |
| ------------ | ------------- | --------------------------- |
| File names   | snake_case    | `yaml_parser.gd`            |
| Class names  | PascalCase    | `class_name YAMLParser`     |
| Node names   | PascalCase    | `Camera3D`, `Player`        |
| Functions    | snake_case    | `func load_level():`        |
| Variables    | snake_case    | `var particle_effect`       |
| Signals      | snake_case    | `signal door_opened`        |
| Constants    | CONSTANT_CASE | `const MAX_SPEED = 200`     |
| Enum names   | PascalCase    | `enum Element`              |
| Enum members | CONSTANT_CASE | `{EARTH, WATER, AIR, FIRE}` |

## Notes

- You can detect whether a key is pressed using `Input.is_action_pressed()`,
which returns true if it's pressed or false if it isn't.
- `$` is shorthand `for get_node()`. So in the code above,
`$AnimatedSprite2D.play()` is the same as `get_node("AnimatedSprite2D").play()`.
In GDScript, `$` returns the node at the relative path from the current node,
or returns null if the node is not found.
Since `AnimatedSprite2D` is a child of the current node, we can use `$AnimatedSprite2D`.
- Disabling the area's collision shape can cause an error if it happens in the
middle of the engine's collision processing.
Using `set_deferred()` tells Godot to wait to disable the shape until it's safe to do so.
- Create a new scene and add a Node named Main.
(The reason we are using Node instead of Node2D is because this node will be a
container for handling game logic. It does not require 2D functionality itself.)
- Draw the path in clockwise order, or your mobs will spawn pointing outwards instead of inwards!

## UI with Control Nodes

The basic node for UI elements is Control.
To create our UI, we'll use two types of Control nodes: `Label` and `Button`.

## Why `PI`

In functions requiring angles, Godot uses radians, not degrees.
Pi represents a half turn in radians, about 3.1415
(there is also `TAU` which is equal to `2 * PI`).
If you're more comfortable working with degrees, you'll need to use the
`deg_to_rad()` and `rad_to_deg()` functions to convert between the two.

## How Collision Masks Work in Godot

In Godot, collision layers and collision masks control what an object is and what it collides with.

- Collision Layer: This defines which group(s) the object belongs to.
- Collision Mask: This defines which groups the object will check for collisions with.

Each object can belong to one or more layers (up to 32), and it can also be set to detect collisions with objects in specific layers.

Example:
- If Object A is on Layer 1 and its Mask includes Layer 2,
it will only collide with objects that are on Layer 2.
- If Object B is on Layer 2 and its Mask includes Layer 1,
it will only collide with objects that are on Layer 1.
- Collision occurs only when both objects’ masks and layers align properly.

By unchecking Mask 1, you're telling the mob (likely on Layer 1) not to detect other Layer 1 objects,
which includes other mobs—thus, they won't collide with each other.
