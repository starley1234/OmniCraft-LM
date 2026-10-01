$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 50, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 50;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [70, 0], [0, 50], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.417, 11.859], [24.607, 13.69], [23.083, 14.989], [21.146, 15.498], [19.18, 15.116], [17.575, 13.918], [16.648, 12.143], [16.583, 10.141], [17.393, 8.31], [18.917, 7.011], [20.854, 6.502], [22.82, 6.884], [24.425, 8.082], [25.352, 9.857]];  // mount hole 1, 14 points
void_2 = [[16.036, 23.168], [15.406, 24.592], [14.22, 25.603], [12.713, 25.998], [11.184, 25.701], [9.936, 24.77], [9.215, 23.389], [9.164, 21.832], [9.794, 20.408], [10.98, 19.397], [12.487, 19.002], [14.016, 19.299], [15.264, 20.23], [15.985, 21.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
