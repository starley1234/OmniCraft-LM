$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 60, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 60;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [70, 0], [0, 60], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.908, 14.154], [25.008, 16.189], [23.314, 17.632], [21.162, 18.197], [18.978, 17.773], [17.194, 16.442], [16.164, 14.47], [16.092, 12.246], [16.992, 10.211], [18.686, 8.768], [20.838, 8.203], [23.022, 8.627], [24.806, 9.958], [25.836, 11.93]];  // mount hole 1, 14 points
void_2 = [[16.527, 27.763], [15.807, 29.391], [14.451, 30.546], [12.73, 30.998], [10.982, 30.658], [9.555, 29.594], [8.731, 28.016], [8.673, 26.237], [9.393, 24.609], [10.749, 23.454], [12.47, 23.002], [14.218, 23.342], [15.645, 24.406], [16.469, 25.984]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
