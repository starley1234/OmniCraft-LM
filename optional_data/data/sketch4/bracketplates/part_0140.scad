$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 60, fillet R10
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 60;               // height leg
fillet_r = 10;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[10, 0], [70, 0], [0, 60], [0, 10], [0.341, 7.412], [1.34, 5], [2.929, 2.929], [5, 1.34], [7.412, 0.341]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.417, 14.059], [24.607, 15.89], [23.083, 17.189], [21.146, 17.698], [19.18, 17.316], [17.575, 16.118], [16.648, 14.343], [16.583, 12.341], [17.393, 10.51], [18.917, 9.211], [20.854, 8.702], [22.82, 9.084], [24.425, 10.282], [25.352, 12.057]];  // mount hole 1, 14 points
void_2 = [[16.036, 27.668], [15.406, 29.092], [14.22, 30.103], [12.713, 30.498], [11.184, 30.201], [9.936, 29.27], [9.215, 27.889], [9.164, 26.332], [9.794, 24.908], [10.98, 23.897], [12.487, 23.502], [14.016, 23.799], [15.264, 24.73], [15.985, 26.111]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
