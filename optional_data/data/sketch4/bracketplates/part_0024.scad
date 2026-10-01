$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 60, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 60;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [80, 0], [0, 60], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.908, 14.154], [28.008, 16.189], [26.314, 17.632], [24.162, 18.197], [21.978, 17.773], [20.194, 16.442], [19.164, 14.47], [19.092, 12.246], [19.992, 10.211], [21.686, 8.768], [23.838, 8.203], [26.022, 8.627], [27.806, 9.958], [28.836, 11.93]];  // mount hole 1, 14 points
void_2 = [[18.327, 27.763], [17.607, 29.391], [16.251, 30.546], [14.53, 30.998], [12.782, 30.658], [11.355, 29.594], [10.531, 28.016], [10.473, 26.237], [11.193, 24.609], [12.549, 23.454], [14.27, 23.002], [16.018, 23.342], [17.445, 24.406], [18.269, 25.984]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
