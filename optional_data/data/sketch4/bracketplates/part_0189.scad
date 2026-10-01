$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 50, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 50;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [80, 0], [0, 50], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.417, 11.859], [27.607, 13.69], [26.083, 14.989], [24.146, 15.498], [22.18, 15.116], [20.575, 13.918], [19.648, 12.143], [19.583, 10.141], [20.393, 8.31], [21.917, 7.011], [23.854, 6.502], [25.82, 6.884], [27.425, 8.082], [28.352, 9.857]];  // mount hole 1, 14 points
void_2 = [[17.836, 23.168], [17.206, 24.592], [16.02, 25.603], [14.513, 25.998], [12.984, 25.701], [11.736, 24.77], [11.015, 23.389], [10.964, 21.832], [11.594, 20.408], [12.78, 19.397], [14.287, 19.002], [15.816, 19.299], [17.064, 20.23], [17.785, 21.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
