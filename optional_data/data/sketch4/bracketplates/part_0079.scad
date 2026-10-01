$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 60, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 60;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [60, 0], [0, 60], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.908, 14.154], [22.008, 16.189], [20.314, 17.632], [18.162, 18.197], [15.978, 17.773], [14.194, 16.442], [13.164, 14.47], [13.092, 12.246], [13.992, 10.211], [15.686, 8.768], [17.838, 8.203], [20.022, 8.627], [21.806, 9.958], [22.836, 11.93]];  // mount hole 1, 14 points
void_2 = [[14.727, 27.763], [14.007, 29.391], [12.651, 30.546], [10.93, 30.998], [9.182, 30.658], [7.755, 29.594], [6.931, 28.016], [6.873, 26.237], [7.593, 24.609], [8.949, 23.454], [10.67, 23.002], [12.418, 23.342], [13.845, 24.406], [14.669, 25.984]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
