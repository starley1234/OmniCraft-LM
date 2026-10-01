$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 70 x 70, fillet R15
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
leg_a = 70;               // base leg
leg_b = 70;               // height leg
fillet_r = 15;            // right-angle fillet radius

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[15, 0], [70, 0], [0, 70], [0, 15], [0.511, 11.118], [2.01, 7.5], [4.393, 4.393], [7.5, 2.01], [11.118, 0.511]];  // primary outline, 9 points, counter clockwise
void_1 = [[25.417, 16.259], [24.607, 18.09], [23.083, 19.389], [21.146, 19.898], [19.18, 19.516], [17.575, 18.318], [16.648, 16.543], [16.583, 14.541], [17.393, 12.71], [18.917, 11.411], [20.854, 10.902], [22.82, 11.284], [24.425, 12.482], [25.352, 14.257]];  // mount hole 1, 14 points
void_2 = [[16.036, 32.168], [15.406, 33.592], [14.22, 34.603], [12.713, 34.998], [11.184, 34.701], [9.936, 33.77], [9.215, 32.389], [9.164, 30.832], [9.794, 29.408], [10.98, 28.397], [12.487, 28.002], [14.016, 28.299], [15.264, 29.23], [15.985, 30.611]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
