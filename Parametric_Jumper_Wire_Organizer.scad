/* Parametric dupont cable organizer by Michael Stickels */


/* [Parameters] */

// Number of wire slots
Slot_Count = 12;
// Height of wire slots (mm)
Slot_Height = 20;
// Distance between plates (mm)
Wire_Length = 75;


/* [Fine Tuning] (You probably don't need to change these unless you have unique wires) */
// Distance between fingers where wires go (mm)
Wire_Gap = 1.8;
// Gap at tip of fingers (mm)
Slot_Gap = 0.4;
// Distance between slots (mm)
Slot_Spacing = 5;
// Printing tolerance (gap on press fit parts to account for expansion) (mm)
Tolerance = 0.2;

// Part sizing
Comb_Thickness = 4;
Comb_Base_Height = 10;
Arm_Thickness = 4;
Arm_Height = 8;



/* The code (You definitely shouldn't have to edit anything down here) */

$fs = $preview ? 0.1 : 0.1;
$fa = $preview ? 3 : 1;

/* Wire Comb */
// Calculations based on parameters
Finger_Count = Slot_Count + 1;
Comb_Width = Slot_Count * Wire_Gap + Finger_Count * Slot_Spacing;
Finger_Tip_Diameter = Slot_Spacing + 0.5 * (Wire_Gap - Slot_Gap);
echo(Finger_Tip_Diameter);
// Base
        cube([Arm_Thickness + Tolerance, Comb_Thickness + 2, Arm_Height/2 + Tolerance/2 + 1]);
        translate([0,-10,0])
        intersection() {
            translate([0,-1,1]) rotate([-90,0,0]) cylinder(Comb_Thickness + 4, r=1);
            translate([0,-1,1]) cube([1, Comb_Thickness + 4, 1]);
        }
translate([0,20,20])
intersection() {
  sphere(5);
  translate([-10,0,0])
  cube([10, 10, 10]);
}
difference() {
    cube([Comb_Width, Comb_Thickness, Comb_Base_Height]);
    translate([0.1*Comb_Width - Tolerance/2,-1,-1])
    difference() {

        difference() {

        }   
    }
    difference() {
        translate([0.9*Comb_Width - Tolerance/2 - Arm_Thickness,-1,-1])
        cube([Arm_Thickness + Tolerance, Comb_Thickness + 2, Arm_Height/2 + Tolerance/2 + 1]);
    }
}

// Fingers
for (i = [0:1:Slot_Count]) {
    translate([i*(Slot_Spacing + Wire_Gap),0,Comb_Base_Height])
    cube([Slot_Spacing,Comb_Thickness,Slot_Height]);
    translate([Slot_Spacing/2 + i*(Slot_Spacing + Wire_Gap),0,Comb_Base_Height + Slot_Height])
    rotate([-90,0,0])
    cylinder(Comb_Thickness, d = Finger_Tip_Diameter);
}


// Snap fit arm


