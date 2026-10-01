$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 70, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 70;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [60, 0], [0, 70], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.417, 16.259], [21.607, 18.09], [20.083, 19.389], [18.146, 19.898], [16.18, 19.516], [14.575, 18.318], [13.648, 16.543], [13.583, 14.541], [14.393, 12.71], [15.917, 11.411], [17.854, 10.902], [19.82, 11.284], [21.425, 12.482], [22.352, 14.257]];  // mount hole 1, 14 points
void_2 = [[14.236, 32.168], [13.606, 33.592], [12.42, 34.603], [10.913, 34.998], [9.384, 34.701], [8.136, 33.77], [7.415, 32.389], [7.364, 30.832], [7.994, 29.408], [9.18, 28.397], [10.687, 28.002], [12.216, 28.299], [13.464, 29.23], [14.185, 30.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
