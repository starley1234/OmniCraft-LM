$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 80 x 70, fillet R12
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
leg_a = 80;               // base leg
leg_b = 70;               // height leg
fillet_r = 12;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[12, 0], [80, 0], [0, 70], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409]];  // primary outline, 9 points, counter clockwise
void_1 = [[28.417, 16.259], [27.607, 18.09], [26.083, 19.389], [24.146, 19.898], [22.18, 19.516], [20.575, 18.318], [19.648, 16.543], [19.583, 14.541], [20.393, 12.71], [21.917, 11.411], [23.854, 10.902], [25.82, 11.284], [27.425, 12.482], [28.352, 14.257]];  // mount hole 1, 14 points
void_2 = [[17.836, 32.168], [17.206, 33.592], [16.02, 34.603], [14.513, 34.998], [12.984, 34.701], [11.736, 33.77], [11.015, 32.389], [10.964, 30.832], [11.594, 29.408], [12.78, 28.397], [14.287, 28.002], [15.816, 28.299], [17.064, 29.23], [17.785, 30.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
