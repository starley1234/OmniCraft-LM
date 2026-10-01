$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 70, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 70;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [60, 0], [0, 70], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.908, 16.354], [22.008, 18.389], [20.314, 19.832], [18.162, 20.397], [15.978, 19.973], [14.194, 18.642], [13.164, 16.67], [13.092, 14.446], [13.992, 12.411], [15.686, 10.968], [17.838, 10.403], [20.022, 10.827], [21.806, 12.158], [22.836, 14.13]];  // mount hole 1, 14 points
void_2 = [[14.727, 32.263], [14.007, 33.891], [12.651, 35.046], [10.93, 35.498], [9.182, 35.158], [7.755, 34.094], [6.931, 32.516], [6.873, 30.737], [7.593, 29.109], [8.949, 27.954], [10.67, 27.502], [12.418, 27.842], [13.845, 28.906], [14.669, 30.484]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
