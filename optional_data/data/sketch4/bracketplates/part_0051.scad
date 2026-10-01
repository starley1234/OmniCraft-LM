$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 50, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 50;               // height leg
fillet_r = 12;            // right-angle fillet radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [60, 0], [0, 50], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.417, 11.859], [21.607, 13.69], [20.083, 14.989], [18.146, 15.498], [16.18, 15.116], [14.575, 13.918], [13.648, 12.143], [13.583, 10.141], [14.393, 8.31], [15.917, 7.011], [17.854, 6.502], [19.82, 6.884], [21.425, 8.082], [22.352, 9.857]];  // mount hole 1, 14 points
void_2 = [[14.236, 23.168], [13.606, 24.592], [12.42, 25.603], [10.913, 25.998], [9.384, 25.701], [8.136, 24.77], [7.415, 23.389], [7.364, 21.832], [7.994, 20.408], [9.18, 19.397], [10.687, 19.002], [12.216, 19.299], [13.464, 20.23], [14.185, 21.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
